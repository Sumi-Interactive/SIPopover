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

//- (UIOffset)si_popoverOffset
//{
//    return UIOffsetMake(0, -50);
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)panHandler:(UIPanGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
//    CGPoint location = [recognizer locationInView:view];
    CGPoint translation = [recognizer translationInView:view];
    CGPoint velocity = [recognizer velocityInView:view];
    
    CGFloat ratio = translation.y / CGRectGetHeight(view.bounds);
    ratio = MIN(1, MAX(0, ratio));
    NSLog(@"%.2f", ratio);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.si_popoverInteractor.isInteracting = true;
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.si_popoverInteractor updateInteractiveTransition:ratio];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            self.si_popoverInteractor.isInteracting = false;
            if(ratio < 0.3 || velocity.y <= 0.0 || recognizer.state == UIGestureRecognizerStateCancelled) {
                [self.si_popoverInteractor cancelInteractiveTransition];
            } else {
                [self.si_popoverInteractor finishInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
