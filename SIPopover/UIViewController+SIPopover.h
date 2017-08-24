//
//  UIViewController+SIPopover.h
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIPopoverDefine.h"
#import "SIPopoverInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@class SIPopoverPresentationController;

@interface UIViewController (SIPopover)

@property (nonatomic, assign, readonly) UIOffset si_popoverOffset;
@property (nonatomic, strong, readonly, nullable) SIPopoverPresentationController *si_popoverTransitionController;

- (void)si_presentPopover:(UIViewController *)viewController;
- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle;
- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect;
- (void)si_presentPopover:(UIViewController *)viewController gravity:(SIPopoverGravity)gravity transitionStyle:(SIPopoverTransitionStyle)transitionStyle backgroundEffect:(SIPopoverBackgroundEffect)backgroundEffect duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
