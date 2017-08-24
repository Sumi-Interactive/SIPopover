//
//  SIPanInteractor.h
//
//  Created by Kevin Cao on 2017/8/24.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverInteractor.h"

@interface SIPanInteractor : SIPopoverInteractor

@property (nonatomic, assign) CGFloat threshold; // default is 0.25

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
