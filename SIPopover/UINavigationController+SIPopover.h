//
//  UINavigationController+SIPopover.h
//  SIPopoverExample
//
//  Created by Vito on 5/22/14.
//  Copyright (c) 2014 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIPopoverDefine.h"

@class SIPopoverConfiguration;

@interface UINavigationController (SIPopover)

- (void)si_pushPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle;
- (void)si_pushPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect duration:(NSTimeInterval)duration;

- (void)si_pushPopover:(UIViewController *)viewController withConfig:(SIPopoverConfiguration *)config;

@end
