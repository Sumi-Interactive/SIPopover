//
//  SINavigationPopoverSegue.h
//  SIPopoverExample
//
//  Created by Vito on 5/22/14.
//  Copyright (c) 2014 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+SIPopover.h"

@interface SINavigationPopoverSegue : UIStoryboardSegue

@property (nonatomic, assign) SIPopoverGravity gravity;
@property (nonatomic, assign) SIPopoverTransitionStyle transitionStyle;
@property (nonatomic, assign) SIPopoverBackgroundEffect backgroundEffect;
@property (nonatomic, assign) NSTimeInterval duration;

@end
