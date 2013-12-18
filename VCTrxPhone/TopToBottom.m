//
//  TopToBottom.m
//  VCTrxPhone
//
//  Created by Jim on 12/15/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import "TopToBottom.h"

@implementation TopToBottom


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // get state
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect pushedFrame = [transitionContext finalFrameForViewController:toViewController];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // get container view
    UIView *containerView = [transitionContext containerView];
    
    // init state
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect poppedFrame = CGRectOffset(pushedFrame, 0, - screenBounds.size.height);
    
    toViewController.view.frame = self.reverse ? pushedFrame : poppedFrame;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.reverse) {
        toViewController.view.frame = pushedFrame;
        [containerView insertSubview:toViewController.view atIndex:0];
        
        [UIView
         animateWithDuration:duration
         animations:^{
              fromViewController.view.frame = poppedFrame;
         }
         completion:^(BOOL finished) {
             [transitionContext completeTransition:! [transitionContext transitionWasCancelled]];
         }];
    } else {
        toViewController.view.frame = poppedFrame;
        [containerView addSubview:toViewController.view];
        
        [UIView
         animateWithDuration:duration
         animations:^{
             toViewController.view.frame =  pushedFrame;
         }
         completion:^(BOOL finished) {
             [transitionContext completeTransition:! [transitionContext transitionWasCancelled]];
         }];
    }
}


@end
