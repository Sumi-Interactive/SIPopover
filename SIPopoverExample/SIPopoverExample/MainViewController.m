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

@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation MainViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.params = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return;
            break;
        case 1:
            self.params[@"gravity"] = @(indexPath.row);
            break;
        case 2:
            self.params[@"transitionStyle"] = @(indexPath.row);
            break;
        case 3:
            self.params[@"backgroundEffect"] = @(indexPath.row);
            break;
        default:
            break;
    }

    NSInteger rows = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    for (NSInteger i = 0; i < rows; i++) {
        NSIndexPath *temp = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
        [tableView cellForRowAtIndexPath:temp].accessoryType = i == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"ShowPopover"]) {
        SIPopoverSegue *popover = (SIPopoverSegue *)segue;
        popover.gravity = [self.params[@"gravity"] integerValue];
        popover.transitionStyle = [self.params[@"transitionStyle"] integerValue];
        popover.backgroundEffect = [self.params[@"backgroundEffect"] integerValue];
    } else if ([segue.identifier isEqual:@"ShowNavigationPopover"]) {
        SINavigationPopoverSegue *popover = (SINavigationPopoverSegue *)segue;
        popover.gravity = [self.params[@"gravity"] integerValue];
        popover.transitionStyle = [self.params[@"transitionStyle"] integerValue];
        popover.backgroundEffect = [self.params[@"backgroundEffect"] integerValue];
    }
}

- (IBAction)dismissAction:(UIStoryboardSegue *)segue
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
