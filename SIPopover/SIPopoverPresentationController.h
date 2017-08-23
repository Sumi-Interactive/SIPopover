//
//  SIPopoverPresentationController.h
//  SIPopoverExample
//
//  Created by Kevin Cao on 2017/8/23.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIPopoverDefine.h"
#import "SIPopoverInteractor.h"

@interface SIPopoverPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) SIPopoverGravity gravity;
@property (nonatomic, assign) SIPopoverTransitionStyle transitionStyle;
@property (nonatomic, assign) SIPopoverBackgroundEffect backgroundEffect;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL adjustTintMode; // default is NO
@property (nonatomic, readonly, strong) SIPopoverInteractor *interactor;
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;

@end
