//
//  UIViewController+SIPopover.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "UIViewController+SIPopover.h"
#import "SIPopoverPresentationController.h"

@implementation UIViewController (SIPopover)

- (UIOffset)si_popoverOffset
{
    return UIOffsetZero;
}

- (void)si_presentPopover:(UIViewController *)viewController
{
    [self si_presentPopover:viewController gravity:SIPopoverGravityNone transitionStyle:SIPopoverTransitionStyleSlideFromBottom backgroundEffect:SIPopoverBackgroundEffectDarken duration:0.4];
}

- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle
{
    [self si_presentPopover:viewController gravity:gravity transitionStyle:transitionStyle backgroundEffect:SIPopoverBackgroundEffectDarken duration:0.4];
}

- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect
{
    [self si_presentPopover:viewController gravity:gravity transitionStyle:transitionStyle backgroundEffect:backgroundEffect duration:0.4];
}

- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect duration:(NSTimeInterval)duration
{
    SIPopoverPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
    presentationController = [[SIPopoverPresentationController alloc] initWithPresentedViewController:viewController presentingViewController:self];
    viewController.transitioningDelegate = presentationController;
    presentationController.gravity = gravity;
    presentationController.transitionStyle = transitionStyle;
    presentationController.backgroundEffect = backgroundEffect;
    presentationController.duration = duration;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
