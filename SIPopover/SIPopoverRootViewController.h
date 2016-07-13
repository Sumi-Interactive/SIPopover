//
//  SIPopoverRootViewController.h
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SIPopover.h"

typedef void(^SIPopoverDismissBlock)(void);

@interface SIPopoverRootViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, strong, readonly) UIViewController *contentViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController;
- (instancetype)initWithContentViewController:(UIViewController *)contentViewController dismiss:(SIPopoverDismissBlock)dismiss;

@property (nonatomic, assign) SIPopoverGravity gravity;
@property (nonatomic, assign) SIPopoverTransitionStyle transitionStyle;
@property (nonatomic, assign) SIPopoverBackgroundEffect backgroundEffect;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL tapBackgroundToDissmiss;
@property (nonatomic, copy) SIPopoverDismissBlock dismissBlock;

- (void)transitionInCompletion:(void(^)(BOOL finished))completion;
- (void)transitionOutCompletion:(void(^)(BOOL finished))completion;

@end
