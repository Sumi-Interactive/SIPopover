//
//  UIViewController+SIPopover.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "UIViewController+SIPopover.h"
#import "SIPopoverRootViewController.h"

@implementation UIViewController (SIPopover)

- (UIOffset)si_popoverOffset
{
    return UIOffsetZero;
}

- (void)si_presentPopover:(UIViewController *)viewController
{
    [self si_presentPopover:viewController transitionStyle:SIPopoverTransitionStyleSlideFromBottom backgroundEffect:SIPopoverBackgroundEffectDarken duration:0.4];
}

- (void)si_presentPopover:(UIViewController *)viewController transitionStyle:(SIPopoverTransitionStyle)transitionStyle
{
    [self si_presentPopover:viewController transitionStyle:transitionStyle backgroundEffect:SIPopoverBackgroundEffectDarken duration:0.4];
}

- (void)si_presentPopover:(UIViewController *)viewController transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect
{
    [self si_presentPopover:viewController transitionStyle:transitionStyle backgroundEffect:backgroundEffect duration:0.4];
}

- (void)si_presentPopover:(UIViewController *)viewController transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect duration:(NSTimeInterval)duration
{
    SIPopoverRootViewController *rootViewController = [[SIPopoverRootViewController alloc] initWithContentViewController:viewController];
    rootViewController.transitionStyle = transitionStyle;
    rootViewController.backgroundEffect = backgroundEffect;
    rootViewController.duration = duration;
	[self presentViewController:rootViewController animated:YES completion:nil];
}

@end
