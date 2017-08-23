//
//  SIPopoverInteractor.h
//
//  Created by Kevin Cao on 2017/8/23.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIPopoverInteractor : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isInteracting;

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
