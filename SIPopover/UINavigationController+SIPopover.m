//
//  UINavigationController+SIPopover.m
//  SIPopoverExample
//
//  Created by Vito on 5/22/14.
//  Copyright (c) 2014 Sumi Interactive. All rights reserved.
//

#import "UINavigationController+SIPopover.h"
#import "SIPopoverRootViewController.h"
#import "SIPopoverConfiguration.h"

@implementation UINavigationController (SIPopover)

- (void)si_pushPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle
{
    [self si_pushPopover:viewController gravity:gravity transitionStyle:transitionStyle backgroundEffect:SIPopoverBackgroundEffectDarken duration:0.4];
}

- (void)si_pushPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect duration:(NSTimeInterval)duration
{
    SIPopoverRootViewController *rootViewController = [[SIPopoverRootViewController alloc] initWithContentViewController:viewController];
    rootViewController.gravity = gravity;
    rootViewController.transitionStyle = transitionStyle;
    rootViewController.backgroundEffect = backgroundEffect;
    rootViewController.duration = duration;
    rootViewController.tapBackgroundToDissmiss = YES;
    self.delegate = rootViewController;
    [self pushViewController:rootViewController animated:YES];
}

- (void)si_pushPopover:(UIViewController *)viewController withConfig:(SIPopoverConfiguration *)config {
    SIPopoverRootViewController *rootViewController = [[SIPopoverRootViewController alloc] initWithContentViewController:viewController];
    rootViewController.gravity = config.gravity;
    rootViewController.transitionStyle = config.transitionStyle;
    rootViewController.backgroundEffect = config.backgroundEffect;
    rootViewController.duration = config.duration;
    rootViewController.tapBackgroundToDissmiss = config.tapBackgroundToDissmiss;
    rootViewController.didFinishedHandler = config.didFinishedHandler;
    self.delegate = rootViewController;
    [self pushViewController:rootViewController animated:YES];
}

@end

