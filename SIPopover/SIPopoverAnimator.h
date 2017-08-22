//
//  SIPopoverAnimator.h
//
//  Created by Kevin Cao on 13-12-15.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIPopoverAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign, getter = isPresentation) BOOL presentation;

@end
