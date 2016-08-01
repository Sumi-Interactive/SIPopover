//
//  UIViewController+SIPopover.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "UIViewController+SIPopover.h"
#import "SIPopoverRootViewController.h"
#import "SIPopoverConfiguration.h"

@implementation UIViewController (SIPopover)

- (UIOffset)si_popoverOffset
{
    return UIOffsetZero;
}

- (void)si_presentPopover:(UIViewController *)viewController
{
    SIPopoverConfiguration *configuration = [SIPopoverConfiguration defaultConfig];
    [self si_presentPopover:viewController withConfig:configuration];
}

- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle
{
    SIPopoverConfiguration *configuration = [SIPopoverConfiguration defaultConfig];
    configuration.gravity = gravity;
    configuration.transitionStyle = transitionStyle;
    [self si_presentPopover:viewController withConfig:configuration];
}

- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect
{
    SIPopoverConfiguration *configuration = [SIPopoverConfiguration defaultConfig];
    configuration.gravity = gravity;
    configuration.transitionStyle = transitionStyle;
    configuration.backgroundEffect = backgroundEffect;
    [self si_presentPopover:viewController withConfig:configuration];
}

- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect duration:(NSTimeInterval)duration
{
    SIPopoverConfiguration *configuration = [SIPopoverConfiguration defaultConfig];
    configuration.gravity = gravity;
    configuration.transitionStyle = transitionStyle;
    configuration.backgroundEffect = backgroundEffect;
    configuration.duration = duration;
    [self si_presentPopover:viewController withConfig:configuration];
}

- (void)si_presentPopover:(UIViewController *)viewController withConfig:(SIPopoverConfiguration *)config
{
    SIPopoverRootViewController *rootViewController = [[SIPopoverRootViewController alloc] initWithContentViewController:viewController];
    rootViewController.gravity = config.gravity;
    rootViewController.transitionStyle = config.transitionStyle;
    rootViewController.backgroundEffect = config.backgroundEffect;
    rootViewController.duration = config.duration;
    rootViewController.tapBackgroundToDissmiss = config.tapBackgroundToDissmiss;
    rootViewController.didFinishedHandler = config.didFinishedHandler;
    [self presentViewController:rootViewController animated:YES completion:nil];
}

@end
