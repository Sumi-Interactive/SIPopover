//
//  SIPopoverAnimator.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverAnimator.h"
#import "SIPopoverRootViewController.h"

static NSInteger const kSnapshotViewTag = 999;

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
    
    BOOL isNavigationPop = self.operation == UINavigationControllerOperationPop;
    BOOL isNavigationPush = self.operation == UINavigationControllerOperationPush;
    BOOL isPresentation = isNavigationPush || (self.isPresentation && self.operation == UINavigationControllerOperationNone);
    BOOL notPresentation = isNavigationPop || (!self.isPresentation && self.operation == UINavigationControllerOperationNone);
    
    
    SIPopoverRootViewController *popoverRootViewController = (SIPopoverRootViewController *)(isPresentation ? toViewController : fromViewController);
    
    NSAssert([popoverRootViewController isKindOfClass:[SIPopoverRootViewController class]], @"SIPopover internal error.");
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        if (notPresentation) {
            [fromViewController.view removeFromSuperview];
            
            // Only for navigation controller pop
            if (isNavigationPop) {
                toViewController.navigationController.delegate = nil;
            }
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
    
    if (isPresentation) {
        if (isNavigationPush) {
            UIView *fromViewSnapshot = [fromViewController.view snapshotViewAfterScreenUpdates:YES];
            fromViewSnapshot.tag = kSnapshotViewTag;
            [containerView insertSubview:fromViewSnapshot atIndex:0];
        }
        [containerView addSubview:toViewController.view];
        toViewController.view.frame = fromViewController.view.frame;
        [toViewController.view layoutIfNeeded];
        
        [popoverRootViewController transitionInCompletion:completion];
        fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    } else {
        // Only for navigation controller pop
        if (isNavigationPop) {
            [containerView insertSubview:toViewController.view atIndex:0];
            UIView *snapshotView = [containerView viewWithTag:kSnapshotViewTag];
            if (snapshotView) {
                [snapshotView removeFromSuperview];
            }
        }
        [popoverRootViewController transitionOutCompletion:completion];
        toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    }
}

@end
