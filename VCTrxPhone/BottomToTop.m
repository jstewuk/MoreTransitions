//
//  BottomToTop.m
//  VCTrxPhone
//
//  Created by Jim on 12/11/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import "BottomToTop.h"

@interface BottomToTop ()

@end

@implementation BottomToTop

#pragma mark - UIViewControllerAnimatedTransitioning

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
    CGRect poppedFrame = CGRectOffset(pushedFrame, 0, screenBounds.size.height);
    
    toViewController.view.frame = self.isPopping ? pushedFrame : poppedFrame;
    
    // add the view to the container
    if (! self.isPopping) {
        [containerView addSubview:toViewController.view];
    } else {
        [containerView insertSubview:toViewController.view atIndex:0];
    }
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView
     animateWithDuration:duration
     animations:^{
         if (! self.isPopping) {
             toViewController.view.frame =  pushedFrame;
         } else
             fromViewController.view.frame = poppedFrame;
     }
     completion:^(BOOL finished) {
         [transitionContext completeTransition:YES];
     }];
}

@end
