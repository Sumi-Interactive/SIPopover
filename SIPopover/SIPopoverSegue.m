//
//  SIPopoverSegue.m
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverSegue.h"

@implementation SIPopoverSegue

- (void)perform
{
    NSTimeInterval duration = self.duration <= 0 ? 0.4 : self.duration;
    [self.sourceViewController si_presentPopover:self.destinationViewController
                                         gravity:self.gravity
                                 transitionStyle:self.transitionStyle
                                backgroundEffect:self.backgroundEffect
                                        duration:duration];
}

@end
