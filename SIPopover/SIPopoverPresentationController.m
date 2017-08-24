//
//  SIPopoverPresentationController.m
//  SIPopoverExample
//
//  Created by Kevin Cao on 2017/8/23.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverPresentationController.h"

@interface SIPopoverPresentationController() <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *snapshotView;
@property (nonatomic, strong) UIView *presentationWrappingView;

@end

@implementation SIPopoverPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (UIView*)presentedView
{
    return self.presentationWrappingView;
}

- (void)presentationTransitionWillBegin
{
    UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
    self.presentationWrappingView = presentationWrapperView;
    
    // The default implementation of -presentedView returns
    // self.presentedViewController.view.
    UIView *presentedViewControllerView = [super presentedView];
    
    // presentationWrapperView
    // |- presentedViewControllerView (presentedViewController.view)
    presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    presentedViewControllerView.frame = presentationWrapperView.bounds;
    [presentationWrapperView addSubview:presentedViewControllerView];
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.opaque = NO;
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    self.dimmingView = dimmingView;
    self.dimmingView.alpha = 0;
    [self.containerView addSubview:dimmingView];
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    switch (self.backgroundEffect) {
        case SIPopoverBackgroundEffectDarken:
        {
            self.dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                self.dimmingView.alpha = 1;
            } completion:nil];
        }
            break;
        case SIPopoverBackgroundEffectLighten:
        {
            self.dimmingView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                self.dimmingView.alpha = 1;
            } completion:nil];
        }
            break;
        case SIPopoverBackgroundEffectBlur:
        {
            
        }
            break;
        case SIPopoverBackgroundEffectPushBack:
        {
            self.dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            UIView *snapshotView = [self.presentingViewController.view snapshotViewAfterScreenUpdates:YES];
            [self.containerView insertSubview:snapshotView belowSubview:self.dimmingView];
            self.snapshotView = snapshotView;
            self.presentingViewController.view.hidden = YES;
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                self.dimmingView.alpha = 1;
                self.snapshotView.transform = CGAffineTransformMakeScale(0.92, 0.92);
            } completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    // The value of the 'completed' argument is the same value passed to the
    // -completeTransition: method by the animator.  It may
    // be NO in the case of a cancelled interactive transition.
    if (completed == NO)
    {
        // The system removes the presented view controller's view from its
        // superview and disposes of the containerView.  This implicitly
        // removes the views created in -presentationTransitionWillBegin: from
        // the view hierarchy.  However, we still need to relinquish our strong
        // references to those view.
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
        self.snapshotView = nil;
        self.presentingViewController.view.hidden = NO;
//        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    }
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    switch (self.backgroundEffect) {
        case SIPopoverBackgroundEffectDarken:
        {
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                self.dimmingView.alpha = 0;
            } completion:nil];
        }
            break;
        case SIPopoverBackgroundEffectLighten:
        {
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                self.dimmingView.alpha = 0;
            } completion:nil];
        }
            break;
        case SIPopoverBackgroundEffectBlur:
        {
            
        }
            break;
        case SIPopoverBackgroundEffectPushBack:
        {
//            UIView *presentingView = self.presentingViewController.view;
//            presentingView.transform = CGAffineTransformMakeScale(0.92, 0.92);
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                self.dimmingView.alpha = 0;
                self.snapshotView.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    // The value of the 'completed' argument is the same value passed to the
    // -completeTransition: method by the animator.  It may
    // be NO in the case of a cancelled interactive transition.
    if (completed == YES)
    {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
        self.snapshotView = nil;
        self.presentingViewController.view.hidden = NO;
//        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    }
}

#pragma mark - Layout

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size = presentedViewContentSize;
    
    switch (self.gravity) {
        case SIPopoverGravityNone:
        {
            presentedViewControllerFrame.origin.x = (CGRectGetWidth(containerViewBounds) - presentedViewContentSize.width) / 2;
            presentedViewControllerFrame.origin.y = (CGRectGetHeight(containerViewBounds) - presentedViewContentSize.height) / 2;
        }
            break;
        case SIPopoverGravityBottom:
        {
            presentedViewControllerFrame.origin.x = (CGRectGetWidth(containerViewBounds) - presentedViewContentSize.width) / 2;
            presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
        }
            break;
        case SIPopoverGravityTop:
        {
            presentedViewControllerFrame.origin.x = (CGRectGetWidth(containerViewBounds) - presentedViewContentSize.width) / 2;
            presentedViewControllerFrame.origin.y = 0;
            break;
        }
        default:
            break;
    }
    
    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}

#pragma mark - Action

- (IBAction)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.gestureRecognizer) {
        return [[SIPopoverInteractor alloc] initWithGestureRecognizer:self.gestureRecognizer];
    }
    return nil;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [transitionContext isAnimated] ? self.duration : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *targetView = isPresenting ? toView : fromView;
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    [containerView addSubview:toView];
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    };
    
    if (isPresenting) {
        targetView.frame = toViewFinalFrame;

        switch (self.transitionStyle) {
            case SIPopoverTransitionStyleSlideFromBottom:
            {
                CGFloat offset = CGRectGetHeight(containerView.bounds) - targetView.frame.origin.y;
                targetView.transform = CGAffineTransformMakeTranslation(0, offset);
                
                [UIView animateWithDuration:transitionDuration
                                      delay:0
                     usingSpringWithDamping:1
                      initialSpringVelocity:0
                                    options:UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     targetView.transform = CGAffineTransformIdentity;
                                 } completion:completion];
            }
                break;
            case SIPopoverTransitionStyleSlideFromTop:
            {
                CGFloat offset = -(targetView.frame.origin.y + CGRectGetHeight(targetView.frame));
                targetView.transform = CGAffineTransformMakeTranslation(0, offset);
                
                [UIView animateWithDuration:transitionDuration
                                      delay:0
                     usingSpringWithDamping:1
                      initialSpringVelocity:0
                                    options:UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     targetView.transform = CGAffineTransformIdentity;
                                 } completion:completion];
            }
                break;
            case SIPopoverTransitionStyleBounce:
            {
                targetView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                targetView.alpha = 0;
                
                [UIView animateWithDuration:transitionDuration
                                      delay:0
                     usingSpringWithDamping:0.5
                      initialSpringVelocity:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     targetView.transform = CGAffineTransformIdentity;
                                     targetView.alpha = 1;
                                 }
                                 completion:completion];
            }
                break;
            default:
                break;
        }
    } else {
        switch (self.transitionStyle) {
            case SIPopoverTransitionStyleSlideFromBottom:
            {
                CGFloat offset = CGRectGetHeight(containerView.bounds) - targetView.frame.origin.y;
                [UIView animateWithDuration:transitionDuration
                                      delay:0
                     usingSpringWithDamping:1
                      initialSpringVelocity:0
                                    options:UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     targetView.transform = CGAffineTransformMakeTranslation(0, offset);
                                 } completion:completion];
            }
                break;
            case SIPopoverTransitionStyleSlideFromTop:
            {
                CGFloat offset = -(targetView.frame.origin.y + CGRectGetHeight(targetView.frame));
                [UIView animateWithDuration:transitionDuration
                                      delay:0
                     usingSpringWithDamping:1
                      initialSpringVelocity:0
                                    options:UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     targetView.transform = CGAffineTransformMakeTranslation(0, offset);
                                 } completion:completion];
            }
                break;
            case SIPopoverTransitionStyleBounce:
            {
                [UIView animateKeyframesWithDuration:transitionDuration
                                               delay:0
                                             options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                          animations:^{
                                              [UIView addKeyframeWithRelativeStartTime:0
                                                                      relativeDuration:0.2
                                                                            animations:^{
                                                                                targetView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                            }];
                                              [UIView addKeyframeWithRelativeStartTime:0.2
                                                                      relativeDuration:0.8
                                                                            animations:^{
                                                                                fromView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                                                                targetView.alpha = 0;
                                                                            }];
                                          }
                                          completion:completion];
            }
                break;
            default:
                break;
        }
    }
    
}

@end
