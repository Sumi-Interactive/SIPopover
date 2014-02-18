//
//  ContentViewController.m
//  SIPopoverExample
//
//  Created by Kevin Cao on 14-2-18.
//  Copyright (c) 2014年 Sumi Interactive. All rights reserved.
//

#import "ContentViewController.h"
#import "SIPopover.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (CGSize)preferredContentSize
{
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? CGSizeMake(400, 200) : CGSizeMake(300, 300);
}

- (UIOffset)si_popoverOffset
{
    return UIOffsetMake(0, -50);
}

@end
