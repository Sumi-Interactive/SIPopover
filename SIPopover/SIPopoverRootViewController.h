//
//  SIPopoverRootViewController.h
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SIPopover.h"
#import "SIPopoverContext.h"
#import "SIPopoverInteractor.h"

@interface SIPopoverRootViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, strong, readonly) UIViewController *contentViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController;

@property (nonatomic, assign) SIPopoverGravity gravity;
@property (nonatomic, assign) SIPopoverTransitionStyle transitionStyle;
@property (nonatomic, assign) SIPopoverBackgroundEffect backgroundEffect;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL adjustTintMode; // default is NO
@property (nonatomic, readonly, strong) SIPopoverInteractor *interactor;

- (void)transitionIn:(SIPopoverContext *)context;
- (void)transitionOut:(SIPopoverContext *)context;

@end
