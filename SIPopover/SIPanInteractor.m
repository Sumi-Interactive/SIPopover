//
//  SIPanInteractor.m
//
//  Created by Kevin Cao on 2017/8/24.
//  Copyright © 2017年 Sumi Interactive. All rights reserved.
//

#import "SIPanInteractor.h"

@interface SIPanInteractor ()

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;

@end

@implementation SIPanInteractor

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    self = [super init];
    if (self)
    {
        _gestureRecognizer = gestureRecognizer;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
        _threshold = 0.25f;
    }
    return self;
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *target = gestureRecognizer.view;
    CGPoint translation = [gestureRecognizer translationInView:self.transitionContext.containerView];
    CGFloat height = CGRectGetHeight(target.bounds) * 2;
    
    CGFloat percent = translation.y / height;
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
            if ([self percentForGesture:gestureRecognizer] >= self.threshold)
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
