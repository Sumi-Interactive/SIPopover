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

@property (nonatomic, strong) UIView *dimView;
@property (nonatomic, strong) UIView *containerView;

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
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dimView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.dimView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.dimView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:self.dimView];
    
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.containerView.autoresizesSubviews = NO;
    [self.view addSubview:self.containerView];
    
    [self addChildViewController:self.contentViewController];
    [self.containerView addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    
    [self.contentViewController addObserver:self forKeyPath:PreferredContentSizeKeyPath options:NSKeyValueObservingOptionNew context:nil];
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

- (void)transitionInCompletion:(void (^)(BOOL finished))completion
{
    UIView *contentView = self.contentViewController.view;
    switch (self.transitionStyle) {
        case SIPopoverTransitionStyleSlideFromTop:
        {
            CGRect originalFrame = contentView.frame;
            CGRect rect = contentView.frame;
            rect.origin.y = -CGRectGetHeight(rect);
            contentView.frame = rect;
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 contentView.frame = originalFrame;
                             }
                             completion:completion];
        }
            break;
        case SIPopoverTransitionStyleSlideFromBottom:
        {
            CGFloat containerHeight = CGRectGetHeight(self.view.bounds);
            CGRect originalFrame = contentView.frame;
            CGRect rect = contentView.frame;
            rect.origin.y = containerHeight;
            contentView.frame = rect;
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 contentView.frame = originalFrame;
                             }
                             completion:completion];
        }
            break;
        case SIPopoverTransitionStyleBounce:
        {
            contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            contentView.alpha = 0;
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 contentView.transform = CGAffineTransformIdentity;
                                 contentView.alpha = 1;
                             }
                             completion:completion];
        }
            break;
    }
    
    self.dimView.alpha = 0;
    [UIView animateWithDuration:self.duration
                     animations:^{
                         self.dimView.alpha = 1;
                     }];
}

- (void)transitionOutCompletion:(void (^)(BOOL finished))completion
{
    UIView *contentView = self.contentViewController.view;
    switch (self.transitionStyle) {
        case SIPopoverTransitionStyleSlideFromTop:
        {
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 CGRect rect = contentView.frame;
                                 rect.origin.y = -CGRectGetHeight(rect);
                                 contentView.frame = rect;
                             }
                             completion:completion];
        }
            break;
        case SIPopoverTransitionStyleSlideFromBottom:
        {
            CGFloat containerHeight = CGRectGetHeight(self.view.bounds);
            [UIView animateWithDuration:self.duration
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 CGRect rect = contentView.frame;
                                 rect.origin.y = containerHeight;
                                 contentView.frame = rect;
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
                                                                            contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                        }];
                                          [UIView addKeyframeWithRelativeStartTime:0.2
                                                                  relativeDuration:0.8
                                                                        animations:^{
                                                                            contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                                                            contentView.alpha = 0;
                                                                        }];
                                      }
                                      completion:completion];
        }
            break;
    }
    [UIView animateWithDuration:self.duration
                     animations:^{
                         self.dimView.alpha = 0;
                     }];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:PreferredContentSizeKeyPath]) {
        [self.view setNeedsLayout];
    }
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    SIPopoverAnimator *animator = [[SIPopoverAnimator alloc] init];
    animator.operation = operation;
    animator.duration = self.duration;
    return animator;
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
