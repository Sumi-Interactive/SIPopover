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

@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:self.gestureRecognizer];
}

- (void)panHandler:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self dismissAction:self.gestureRecognizer];
    }
    
    // Remaining cases are handled by the
    // SIPopoverPresentationController.
}

- (IBAction)dismissAction:(id)sender {
    if ([self.transitioningDelegate isKindOfClass:SIPopoverPresentationController.class]) {
        SIPopoverPresentationController *delegate = (SIPopoverPresentationController *)self.transitioningDelegate;
        if ([sender isKindOfClass:UIPanGestureRecognizer.class]) {
            delegate.gestureRecognizer = (UIPanGestureRecognizer *)sender;
        } else {
            delegate.gestureRecognizer = nil;
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
