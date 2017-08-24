//
//  SIPopoverInteractor.h
//
//  Created by Kevin Cao on 2017/8/23.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIPopoverInteractor : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isInteracting;
@property (nonatomic, weak, readonly) id<UIViewControllerContextTransitioning> transitionContext;

@end
