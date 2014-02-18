//
//  UIViewController+SIPopover.h
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SIPopoverTransitionStyle) {
    SIPopoverTransitionStyleSlideFromBottom = 0,
    SIPopoverTransitionStyleSlideFromTop,
    SIPopoverTransitionStyleBounce,
};

typedef NS_ENUM(NSInteger, SIPopoverBackgroundEffect) {
    SIPopoverBackgroundEffectNone = 0,
    SIPopoverBackgroundEffectDarken = 1 << 0,
    SIPopoverBackgroundEffectLighten = 1 << 1,
    SIPopoverBackgroundEffectBlur = 1 << 2,
    SIPopoverBackgroundEffectPushBack = 1 << 3,
};

@interface UIViewController (SIPopover)

- (UIOffset)si_popoverOffset;

- (void)si_presentPopover:(UIViewController *)viewController transitionStyle:(SIPopoverTransitionStyle)transitionStyle;
- (void)si_presentPopover:(UIViewController *)viewController transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect;
- (void)si_presentPopover:(UIViewController *)viewController transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect duration:(NSTimeInterval)duration;

@end
