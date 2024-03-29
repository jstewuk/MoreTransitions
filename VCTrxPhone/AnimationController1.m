//
//  AnimationController1.m
//  VCTrxPhone
//
//  Created by Jim on 12/11/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import "AnimationController1.h"

@interface AnimationController1 ()

@end

@implementation AnimationController1

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.0;
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
    CGRect poppedFrame = CGRectOffset(pushedFrame, 0, screenBounds.size.height);
    
    toViewController.view.frame = self.reverse ? pushedFrame : poppedFrame;
    
    // add the view to the container
    if (! self.reverse) {
        [containerView addSubview:toViewController.view];
    } else {
        [containerView insertSubview:toViewController.view atIndex:0];
    }
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView
     animateWithDuration:duration
     animations:^{
         if (! self.reverse) {
             toViewController.view.frame =  pushedFrame;
         } else
             fromViewController.view.frame = poppedFrame;
     }
     completion:^(BOOL finished) {
         [transitionContext completeTransition:YES];
     }];
}

@end
