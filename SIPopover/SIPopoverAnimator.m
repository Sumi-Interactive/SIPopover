//
//  SIPopoverAnimator.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverAnimator.h"
#import "SIPopoverRootViewController.h"

@implementation SIPopoverAnimator

- (id)init
{
    self = [super init];
    if (self) {
        self.duration = 0.4;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    SIPopoverRootViewController *popoverRootViewController;
    
    if (self.isPresentation) {
        [containerView addSubview:toViewController.view];
        toViewController.view.frame = fromViewController.view.frame;
        [toViewController.view layoutIfNeeded];
        
        popoverRootViewController = (SIPopoverRootViewController *)toViewController;
    } else {
        popoverRootViewController = (SIPopoverRootViewController *)fromViewController;
    }
    
    NSAssert([popoverRootViewController isKindOfClass:[SIPopoverRootViewController class]], @"SIPopover internal error.");
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        if (!self.isPresentation) {
            [fromViewController.view removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
    
    if (self.isPresentation) {
        [popoverRootViewController transitionInCompletion:completion];
        fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    } else {
        [popoverRootViewController transitionOutCompletion:completion];
        toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    }
}

@end
