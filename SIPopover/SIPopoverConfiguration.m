//
//  SIPopoverConfiguration.m
//  SIPopoverExample
//
//  Created by ulee on 16/7/13.
//  Copyright © 2016年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverConfiguration.h"

@implementation SIPopoverConfiguration

+ (instancetype)defaultConfig
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        _gravity = SIPopoverGravityNone;
        _transitionStyle = SIPopoverTransitionStyleSlideFromBottom;
        _backgroundEffect = SIPopoverBackgroundEffectNone;
        _duration = .4f;
        _tapBackgroundToDissmiss = YES;
    }
    return self;
}

@end
