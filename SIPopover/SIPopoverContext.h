//
//  SIPopoverContext.h
//
//  Created by Kevin Cao on 2017/8/21.
//  Copyright (c) 2017 Sumi Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIPopoverContext : NSObject

@property (nonatomic, weak) UIViewController *toViewController;
@property (nonatomic, weak) UIViewController *fromViewController;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIView *toView;
@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, weak) UIView *actualToView;
@property (nonatomic, weak) UIView *actualFromView;
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, copy) void (^completion)(void);

@end
