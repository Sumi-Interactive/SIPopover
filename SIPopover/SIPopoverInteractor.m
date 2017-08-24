//
//  SIPopoverInteractor.m
//
//  Created by Kevin Cao on 2017/8/23.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverInteractor.h"

@interface SIPopoverInteractor ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation SIPopoverInteractor

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(self.isInteracting == true, @"isInteracting must be true");
    
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

@end
