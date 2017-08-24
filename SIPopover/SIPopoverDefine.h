//
//  SIPopoverDefine.h
//  SIPopoverExample
//
//  Created by Vito on 5/22/14.
//  Copyright (c) 2014 Sumi Interactive. All rights reserved.
//

typedef NS_ENUM(NSUInteger, SIPopoverTransitionStyle) {
    SIPopoverTransitionStyleSlideFromBottom = 0,
    SIPopoverTransitionStyleSlideFromTop,
    SIPopoverTransitionStyleBounce
};

typedef NS_ENUM(NSInteger, SIPopoverBackgroundEffect) {
    SIPopoverBackgroundEffectNone = 0,
    SIPopoverBackgroundEffectDarken,
    SIPopoverBackgroundEffectLighten,
    SIPopoverBackgroundEffectPushBack
};

typedef NS_ENUM(NSInteger, SIPopoverGravity) {
    SIPopoverGravityNone = 0,
    SIPopoverGravityBottom,
    SIPopoverGravityTop
};

