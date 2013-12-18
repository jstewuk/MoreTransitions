//
//  ExpandFromCenter.m
//  VCTrxPhone
//
//  Created by Jim on 12/15/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import "ExpandFromCenter.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExpandFromCenter

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGPoint screenCenter = CGPointMake(screenBounds.size.width / 2.0, screenBounds.size.height /2.0);
    CGAffineTransform tinyTransform = CGAffineTransformMakeScale(.001, .001);
    CGAffineTransform twistTransform = CGAffineTransformMakeRotation(M_PI_2);
    CGAffineTransform startTransform = CGAffineTransformConcat(tinyTransform, twistTransform);

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.reverse) {
        UIImageView *snapView = [[UIImageView alloc] initWithImage:[self renderView:fromViewController.view]];
        snapView.center = screenCenter;
        snapView.transform = CGAffineTransformIdentity;
        
        [containerView insertSubview:snapView belowSubview:fromViewController.view];
        [fromViewController.view setAlpha:0.0]; // make it transparent
        [containerView insertSubview:toViewController.view belowSubview:snapView];
        
        [UIView
         animateWithDuration:duration
         animations:^{
             snapView.transform = startTransform;
         }
         completion:^(BOOL finished) {
             [snapView removeFromSuperview];
             [fromViewController.view removeFromSuperview];
             [transitionContext completeTransition:! [transitionContext transitionWasCancelled]];
         }];
    } else {
        UIImageView *snapView = [[UIImageView alloc] initWithImage:[self renderView:toViewController.view]];
        snapView.center = screenCenter;
        snapView.transform = startTransform;
        
        [containerView addSubview:snapView];
        
        [UIView
         animateWithDuration:duration
         animations:^{
             snapView.transform = CGAffineTransformIdentity;
         }
         completion:^(BOOL finished) {
             [containerView addSubview:toViewController.view];
             [snapView removeFromSuperview];
             [transitionContext completeTransition:! [transitionContext transitionWasCancelled]];
         }];
    }
}

- (UIImage *)renderView:(UIView *)view {
    CGSize size = view.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, 0);
    [view.layer renderInContext:c];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
