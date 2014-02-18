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
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    SIPopoverRootViewController *popoverRootViewController;
    
    if (self.isPresentation) {
        fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        
        [containerView addSubview:toViewController.view];
        toViewController.view.frame = fromViewController.view.frame;
        [toViewController.view layoutIfNeeded];
        
        popoverRootViewController = (SIPopoverRootViewController *)toViewController;
    } else {
        popoverRootViewController = (SIPopoverRootViewController *)fromViewController;
    }
    
    UIView *contentView = popoverRootViewController.contentViewController.view;
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        if (!self.isPresentation) {
            [fromViewController.view removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
    
    switch (self.transitionStyle) {
        case SIPopoverTransitionStyleSlideFromTop:
        {
            if (self.isPresentation) {
                CGRect originalFrame = contentView.frame;
                CGRect rect = contentView.frame;
                rect.origin.y = -CGRectGetHeight(rect);
                contentView.frame = rect;
                [UIView animateWithDuration:duration
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     contentView.frame = originalFrame;
                                 }
                                 completion:completion];
            } else {
                [UIView animateWithDuration:duration
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     CGRect rect = contentView.frame;
                                     rect.origin.y = -CGRectGetHeight(rect);
                                     contentView.frame = rect;
                                 }
                                 completion:completion];
            }
        }
            break;
        case SIPopoverTransitionStyleSlideFromBottom:
        {
            CGFloat containerHeight = CGRectGetHeight(fromViewController.view.bounds);
            if (self.isPresentation) {
                CGRect originalFrame = contentView.frame;
                CGRect rect = contentView.frame;
                rect.origin.y = containerHeight;
                contentView.frame = rect;
                [UIView animateWithDuration:duration
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     contentView.frame = originalFrame;
                                 }
                                 completion:completion];
            } else {
                toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
                [UIView animateWithDuration:duration
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     CGRect rect = contentView.frame;
                                     rect.origin.y = containerHeight;
                                     contentView.frame = rect;
                                 }
                                 completion:completion];
            }
        }
            break;
        case SIPopoverTransitionStyleBounce:
        {
            if (self.isPresentation) {
                contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                contentView.alpha = 0;
                [UIView animateKeyframesWithDuration:duration
                                               delay:0
                                             options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                          animations:^{
                                              [UIView addKeyframeWithRelativeStartTime:0
                                                                      relativeDuration:0.8
                                                                            animations:^{
                                                                                contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                                contentView.alpha = 1;
                                                                            }];
                                              [UIView addKeyframeWithRelativeStartTime:0.8
                                                                      relativeDuration:0.2
                                                                            animations:^{
                                                                                contentView.transform = CGAffineTransformIdentity;
                                                                            }];
                                          }
                                          completion:completion];
            } else {
                toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
                [UIView animateKeyframesWithDuration:duration
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
        }
            break;
    }
}

@end
