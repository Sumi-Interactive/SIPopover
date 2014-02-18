//
//  SIPopoverAnimator.h
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface SIPopoverAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign, getter = isPresentation) BOOL presentation;
@property (nonatomic, assign) SIPopoverTransitionStyle transitionStyle;
@property (nonatomic, assign) SIPopoverBackgroundEffect backgroundEffect; // no support yet

@end
