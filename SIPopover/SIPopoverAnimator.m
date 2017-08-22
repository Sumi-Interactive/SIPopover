//
//  SIPopoverAnimator.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverAnimator.h"
#import "SIPopoverRootViewController.h"
#import "SIPopoverContext.h"

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
    SIPopoverContext *popoverContext = [[SIPopoverContext alloc] init];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    popoverContext.toViewController = toViewController;
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    popoverContext.fromViewController = fromViewController;
    
    UIView *containerView = [transitionContext containerView];
    popoverContext.containerView = containerView;
    
    UIView *toView = toViewController.view;
    popoverContext.toView = toView;
    
    UIView *fromView = fromViewController.view;
    popoverContext.fromView = fromView;
    
    UIView *actualToView = [transitionContext viewForKey:UITransitionContextToViewKey];
    popoverContext.actualToView = actualToView;
    
    UIView *actualFromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    popoverContext.actualFromView = actualFromView;
    
    BOOL isShowing = self.isPresentation;
    popoverContext.isShowing = isShowing;
    
    SIPopoverRootViewController *popoverRootViewController = (SIPopoverRootViewController *)(isShowing ? toViewController : fromViewController);
    
    NSAssert([popoverRootViewController isKindOfClass:[SIPopoverRootViewController class]], @"SIPopover internal error.");
    
    popoverContext.completion = ^(void) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        
        if (isShowing) {
            if (isCancelled) {
                [actualToView removeFromSuperview];
            }
        } else {
            if (!isCancelled) {
                [actualFromView removeFromSuperview];
            }
        }
        
        [transitionContext completeTransition:!isCancelled];
    };
    
    if (isShowing) {
        [containerView addSubview:actualToView];
        toView.frame = containerView.frame;
        [toView layoutIfNeeded];
        
        [popoverRootViewController transitionIn:popoverContext];
        
//        toView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
//        UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
//        mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    } else {
        
        [popoverRootViewController transitionOut:popoverContext];
        
//        UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
//        mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    }
}

@end
