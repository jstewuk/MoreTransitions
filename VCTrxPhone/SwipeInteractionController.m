//
//  SwipeInteractionController.m
//  VCTrxPhone
//
//  Created by Jim on 12/16/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import "SwipeInteractionController.h"

@interface SwipeInteractionController ()
@property(nonatomic, assign) BOOL shouldCompleteTransition;
@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) UIViewController *viewController;
@property(nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;
@end

@implementation SwipeInteractionController

- (void)wireToViewController:(UIViewController *)viewController  navigationController:navigationController {
    self.viewController = viewController;
    self.navigationController = navigationController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (UIPanGestureRecognizer *)gestureRecognizer {
    if (_gestureRecognizer == nil) {
        _gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    }
    return _gestureRecognizer;
}

- (void)prepareGestureRecognizerInView:(UIView *)view {
    [view addGestureRecognizer:self.gestureRecognizer];
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interactionInProgress = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = - (translation.x / 200);
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldCompleteTransition = fraction > 0.5;
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interactionInProgress = NO;
            if (self.shouldCompleteTransition) {
                [self finishInteractiveTransition];
                [self.viewController.view removeGestureRecognizer:self.gestureRecognizer];
             } else {
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
