//
//  SINavigationPopoverSegue.m
//  SIPopoverExample
//
//  Created by Vito on 5/22/14.
//  Copyright (c) 2014 Sumi Interactive. All rights reserved.
//

#import "SINavigationPopoverSegue.h"

@implementation SINavigationPopoverSegue

- (void)perform
{
    NSTimeInterval duration = self.duration <= 0 ? 0.4 : self.duration;
    UINavigationController *navigationController = [(UIViewController *)self.sourceViewController navigationController];
    [navigationController si_pushPopover:self.destinationViewController
                                 gravity:self.gravity
                         transitionStyle:self.transitionStyle
                        backgroundEffect:self.backgroundEffect
                                duration:duration];
}

@end
