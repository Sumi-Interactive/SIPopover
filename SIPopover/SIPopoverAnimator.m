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
        self.duration = 0.8;
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
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    UIView *actualToView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *actualFromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    BOOL isNavigationPop = self.operation == UINavigationControllerOperationPop;
    BOOL isNavigationPush = self.operation == UINavigationControllerOperationPush;
    BOOL isPresentation = isNavigationPush || (self.isPresentation && self.operation == UINavigationControllerOperationNone);
    BOOL notPresentation = isNavigationPop || (!self.isPresentation && self.operation == UINavigationControllerOperationNone);
    
    SIPopoverRootViewController *popoverRootViewController = (SIPopoverRootViewController *)(isPresentation ? toViewController : fromViewController);
    
    NSAssert([popoverRootViewController isKindOfClass:[SIPopoverRootViewController class]], @"SIPopover internal error.");
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        if (notPresentation) {
            [actualFromView removeFromSuperview];
            
            // Only for navigation controller pop
            if (isNavigationPop) {
                toViewController.navigationController.delegate = nil;
            }
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
    
    if (isPresentation) {
        if (isNavigationPush) {
            UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:YES];
            fromViewSnapshot.tag = kSnapshotViewTag;
            [containerView insertSubview:fromViewSnapshot atIndex:0];
        }
        [containerView addSubview:actualToView];
        toView.frame = containerView.frame;
        [toView layoutIfNeeded];
        
        [popoverRootViewController transitionInCompletion:completion];
        
        toView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
        UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
        mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    } else {
        // Only for navigation controller pop
        if (isNavigationPop) {
            [containerView insertSubview:toView atIndex:0];
            UIView *snapshotView = [containerView viewWithTag:kSnapshotViewTag];
            if (snapshotView) {
                [snapshotView removeFromSuperview];
            }
        }
        [popoverRootViewController transitionOutCompletion:completion];
        
        UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
        mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    }
}

@end
