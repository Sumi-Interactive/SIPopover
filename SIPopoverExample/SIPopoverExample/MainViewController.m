//
//  MainViewController.m
//  SIPopoverExample
//
//  Created by Kevin Cao on 14-2-18.
//  Copyright (c) 2014年 Sumi Interactive. All rights reserved.
//

#import "MainViewController.h"
#import "SIPopover.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SIPopoverSegue *popover = (SIPopoverSegue *)segue;
	if ([segue.identifier isEqualToString:@"ShowPopover1"]) {
        popover.transitionStyle = SIPopoverTransitionStyleSlideFromBottom;
	} else if ([segue.identifier isEqualToString:@"ShowPopover2"]) {
        popover.transitionStyle = SIPopoverTransitionStyleSlideFromTop;
	} else if ([segue.identifier isEqualToString:@"ShowPopover3"]) {
        popover.transitionStyle = SIPopoverTransitionStyleBounce;
	}
}

- (IBAction)dismissAction:(UIStoryboardSegue *)segue
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
