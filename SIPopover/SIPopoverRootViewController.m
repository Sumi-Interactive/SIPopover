//
//  SIPopoverRootViewController.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverRootViewController.h"

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
    
    self.dimView.alpha = 0;
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimView.alpha = 1;
    }
                                                completion:nil];
    
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
    
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimView.alpha = 0;
    }
                                                completion:nil];
    
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
    [self updateViewLayout];
}

- (void)updateViewLayout
{
    CGFloat width = CGRectGetWidth(self.containerView.bounds);
    CGFloat height = CGRectGetHeight(self.containerView.bounds);
    CGSize size = [self.contentViewController preferredContentSize];
    CGFloat x = (width - size.width) / 2 + self.contentViewController.si_popoverOffset.horizontal;
    CGFloat y = (height - size.height) / 2 + self.contentViewController.si_popoverOffset.vertical;
    self.contentViewController.view.frame = CGRectMake(x, y, size.width, size.height);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:PreferredContentSizeKeyPath]) {
        [self.view setNeedsLayout];
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
    animator.transitionStyle = self.transitionStyle;
    animator.backgroundEffect = self.backgroundEffect;
    return animator;
}

@end
