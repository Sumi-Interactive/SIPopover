//
//  ContentViewController.m
//  SIPopoverExample
//
//  Created by Kevin Cao on 14-2-18.
//  Copyright (c) 2014年 Sumi Interactive. All rights reserved.
//

#import "ContentViewController.h"
#import "SIPopover.h"
#import "SIPanInteractor.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    self.si_popoverTransitionController.dismissalInteractor = [[SIPanInteractor alloc] initWithGestureRecognizer:gestureRecognizer];
}

- (void)panHandler:(UIPanGestureRecognizer *)recognizer
{
    SIPopoverInteractor *interactor = self.si_popoverTransitionController.dismissalInteractor;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            interactor.isInteracting = true;
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            interactor.isInteracting = false;
            break;
        default:
            break;
    }
    
    // Remaining cases are handled by the
    // SIPopoverPresentationController.
}

- (IBAction)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
