//
//  SIPopoverConfiguration.h
//  SIPopoverExample
//
//  Created by ulee on 16/7/13.
//  Copyright © 2016年 Sumi Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIPopoverRootViewController.h"

@interface SIPopoverConfiguration : NSObject

@property (nonatomic, assign) SIPopoverGravity gravity;
@property (nonatomic, assign) SIPopoverTransitionStyle transitionStyle;
@property (nonatomic, assign) SIPopoverBackgroundEffect backgroundEffect;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL tapBackgroundToDissmiss;
@property (nonatomic, copy) void (^didFinishedHandler)(UIViewController *sender);

+ (instancetype)defaultConfig;

@end