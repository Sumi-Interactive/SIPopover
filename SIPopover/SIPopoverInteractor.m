//
//  SIPopoverInteractor.m
//
//  Created by Kevin Cao on 2017/8/23.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import "SIPopoverInteractor.h"

@interface SIPopoverInteractor ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;

@end

@implementation SIPopoverInteractor

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    self = [super init];
    if (self)
    {
        _gestureRecognizer = gestureRecognizer;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
//    UIView *transitionContainerView = self.transitionContext.containerView;
//    
//    CGPoint locationInSourceView = [gesture locationInView:transitionContainerView];
//    CGFloat height = CGRectGetHeight(transitionContainerView.bounds);
//    
//    return locationInSourceView.y / height;
    
    UIView *target = gestureRecognizer.view;
    CGPoint translation = [gestureRecognizer translationInView:self.transitionContext.containerView];
    CGFloat height = CGRectGetHeight(target.bounds) * 2;
    
    CGFloat percent = translation.y / height;
    NSLog(@"%.3f", percent);
    return percent;
}

- (IBAction)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            // The Began state is handled by the view controllers.  In response
            // to the gesture recognizer transitioning to this state, they
            // will trigger the presentation or dismissal.
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:
            if ([self percentForGesture:gestureRecognizer] >= 0.25f)
                [self finishInteractiveTransition];
            else
                [self cancelInteractiveTransition];
            break;
        default:
            // Something happened. cancel the transition.
            [self cancelInteractiveTransition];
            break;
    }
}

@end
