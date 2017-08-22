//
//  SIPopoverRootViewController.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverRootViewController.h"
#import "SIPopoverAnimator.h"

static NSString * const PreferredContentSizeKeyPath = @"preferredContentSize";

@interface SIPopoverRootViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIView *snapshotView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, assign) UIStatusBarStyle savedStyle;
@property (nonatomic, assign) BOOL savedHidden;

@end

@implementation SIPopoverRootViewController

- (void)dealloc
{
    [self.contentViewController removeObserver:self forKeyPath:PreferredContentSizeKeyPath context:nil];
}

- (id)initWithContentViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
        _contentViewController = rootViewController;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.transitioningDelegate = self;
        [_contentViewController addObserver:self forKeyPath:PreferredContentSizeKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.savedStyle = [UIApplication sharedApplication].statusBarStyle;
    self.savedHidden = [UIApplication sharedApplication].statusBarHidden;
    
    self.overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.overlayView.alpha = 0;
    [self.view addSubview:self.overlayView];
    
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.containerView.autoresizesSubviews = NO;
    [self.view addSubview:self.containerView];
    
    [self addChildViewController:self.contentViewController];
    [self.containerView addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    [self.contentViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.contentViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
    [self.contentViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.contentViewController viewDidDisappear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.savedStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.savedHidden;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.containerView.bounds);
    CGFloat height = CGRectGetHeight(self.containerView.bounds);
    CGSize size = [self.contentViewController preferredContentSize];
    CGFloat x = (width - size.width) / 2;
    x += self.contentViewController.si_popoverOffset.horizontal;
    CGFloat y;
    switch (self.gravity) {
        case SIPopoverGravityNone:
            y = (height - size.height) / 2;
            y += self.contentViewController.si_popoverOffset.vertical;
            break;
        case SIPopoverGravityBottom:
            y = height - size.height;
            y -= self.contentViewController.si_popoverOffset.vertical;
            break;
        case SIPopoverGravityTop:
            y = 0;
            y += self.contentViewController.si_popoverOffset.vertical;
            break;
    }
    self.contentViewController.view.frame = CGRectMake(x, y, size.width, size.height);
}

- (void)transitionIn:(SIPopoverContext *)context
{
    UIView *contentView = self.contentViewController.view;
    
    // make content view snapshot
    UIView *contentSnapshotView = [contentView snapshotViewAfterScreenUpdates:YES];
    contentSnapshotView.frame = contentView.frame;
    [self.containerView addSubview:contentSnapshotView];
    
    // hide content view
    contentView.hidden = YES;
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        contentView.hidden = NO;
        [contentSnapshotView removeFromSuperview];
        context.completion();
    };
    
    switch (self.transitionStyle) {
        case SIPopoverTransitionStyleSlideFromTop:
        {
            CGFloat offset = -(contentSnapshotView.frame.origin.y + CGRectGetHeight(contentSnapshotView.bounds));
            contentSnapshotView.transform = CGAffineTransformMakeTranslation(0, offset);
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 contentSnapshotView.transform = CGAffineTransformIdentity;
                             }
                             completion:completion];
        }
            break;
        case SIPopoverTransitionStyleSlideFromBottom:
        {
            CGFloat offset = CGRectGetHeight(self.view.bounds) - contentSnapshotView.frame.origin.y;
            contentSnapshotView.transform = CGAffineTransformMakeTranslation(0, offset);
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 contentSnapshotView.transform = CGAffineTransformIdentity;
                             }
                             completion:completion];
        }
            break;
        case SIPopoverTransitionStyleBounce:
        {
            contentSnapshotView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            contentSnapshotView.alpha = 0;
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 contentSnapshotView.transform = CGAffineTransformIdentity;
                                 contentSnapshotView.alpha = 1;
                             }
                             completion:completion];
        }
            break;
    }
    
    switch (self.backgroundEffect) {
        case SIPopoverBackgroundEffectNone:
            break;
        case SIPopoverBackgroundEffectDarken:
        {
            self.view.backgroundColor = UIColor.clearColor;
            self.overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            self.overlayView.alpha = 0;
            [UIView animateWithDuration:self.duration
                             animations:^{
                                 self.overlayView.alpha = 1;
                             }];
        }
            break;
        case SIPopoverBackgroundEffectLighten:
        {
            self.view.backgroundColor = UIColor.clearColor;
            self.overlayView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
            self.overlayView.alpha = 0;
            [UIView animateWithDuration:self.duration
                             animations:^{
                                 self.overlayView.alpha = 1;
                             }];
        }
            break;
        case SIPopoverBackgroundEffectBlur:
        {
            // TODO:
        }
            break;
        case SIPopoverBackgroundEffectPushBack:
        {
            self.snapshotView = [context.fromView snapshotViewAfterScreenUpdates:YES];
            [self.view insertSubview:self.snapshotView belowSubview:self.overlayView];
            
            self.view.backgroundColor = UIColor.blackColor;
            self.overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            self.overlayView.alpha = 0;
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.snapshotView.transform = CGAffineTransformMakeScale(0.92, 0.92);
                                 self.overlayView.alpha = 1;
                             }
                             completion:nil];
        }
            break;
    }
    
    if (self.adjustTintMode) {
        self.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
        UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
        mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    }
}

- (void)transitionOut:(SIPopoverContext *)context
{
    UIView *contentView = self.contentViewController.view;
    
    // make content view snapshot
    UIView *contentSnapshotView = [contentView snapshotViewAfterScreenUpdates:YES];
    contentSnapshotView.frame = contentView.frame;
    [self.containerView addSubview:contentSnapshotView];
    
    // hide content view
    contentView.hidden = YES;
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        contentView.hidden = NO;
        [contentSnapshotView removeFromSuperview];
        context.completion();
    };
    
    switch (self.transitionStyle) {
        case SIPopoverTransitionStyleSlideFromTop:
        {
            CGFloat offset = -(contentSnapshotView.frame.origin.y + CGRectGetHeight(contentSnapshotView.bounds));
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 contentSnapshotView.transform = CGAffineTransformMakeTranslation(0, offset);
                             }
                             completion:completion];
        }
            break;
        case SIPopoverTransitionStyleSlideFromBottom:
        {
            CGFloat offset = CGRectGetHeight(self.view.bounds) - contentSnapshotView.frame.origin.y;
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 contentSnapshotView.transform = CGAffineTransformMakeTranslation(0, offset);
                             }
                             completion:completion];
        }
            break;
        case SIPopoverTransitionStyleBounce:
        {
            [UIView animateKeyframesWithDuration:self.duration
                                           delay:0
                                         options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                      animations:^{
                                          [UIView addKeyframeWithRelativeStartTime:0
                                                                  relativeDuration:0.2
                                                                        animations:^{
                                                                            contentSnapshotView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                        }];
                                          [UIView addKeyframeWithRelativeStartTime:0.2
                                                                  relativeDuration:0.8
                                                                        animations:^{
                                                                            contentSnapshotView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                                                            contentSnapshotView.alpha = 0;
                                                                        }];
                                      }
                                      completion:completion];
        }
            break;
    }
    
    switch (self.backgroundEffect) {
        case SIPopoverBackgroundEffectNone:
            break;
        case SIPopoverBackgroundEffectDarken:
        {
            [UIView animateWithDuration:self.duration
                             animations:^{
                                 self.overlayView.alpha = 0;
                             }];
        }
            break;
        case SIPopoverBackgroundEffectLighten:
        {
            [UIView animateWithDuration:self.duration
                             animations:^{
                                 self.overlayView.alpha = 0;
                             }];
        }
            break;
        case SIPopoverBackgroundEffectBlur:
        {
            // TODO:
        }
            break;
        case SIPopoverBackgroundEffectPushBack:
        {
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.snapshotView.transform = CGAffineTransformIdentity;
                                 self.overlayView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 [self.snapshotView removeFromSuperview];
                                 self.snapshotView = nil;
                             }];
        }
            break;
    }
    
    if (self.adjustTintMode) {
        UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
        mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    }
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:PreferredContentSizeKeyPath]) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self.view setNeedsLayout];
                             [self.view layoutIfNeeded];
                         }];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self animatorWithPresentation:YES];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self animatorWithPresentation:NO];
}

- (SIPopoverAnimator *)animatorWithPresentation:(BOOL)presentation
{
    SIPopoverAnimator *animator = [[SIPopoverAnimator alloc] init];
    animator.presentation = presentation;
    animator.duration = self.duration;
    return animator;
}

@end
