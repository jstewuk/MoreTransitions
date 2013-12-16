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
    //CGRect toFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    
    // Snapshot toViewControllerView
    UIImageView *snapView = nil;
    if (self.isPopping) {
        snapView = [[UIImageView alloc] initWithImage:[self renderView:fromViewController.view]];
    } else {
        snapView = [[UIImageView alloc] initWithImage:[self renderView:toViewController.view]];
    }
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGPoint screenCenter = CGPointMake(screenBounds.size.width / 2.0, screenBounds.size.height /2.0);
    snapView.center = screenCenter;
    CGAffineTransform tinyTransform = CGAffineTransformMakeScale(.001, .001);
    CGAffineTransform twistTransform = CGAffineTransformMakeRotation(M_PI_2);
    CGAffineTransform startTransform = CGAffineTransformConcat(tinyTransform, twistTransform);
     if (! self.isPopping) {
         snapView.transform = startTransform;
    }
    
    if (self.isPopping) {
        [containerView addSubview:snapView];
        [fromViewController.view removeFromSuperview];
        [containerView insertSubview:toViewController.view atIndex:0];
    } else {
        [containerView addSubview:snapView];
    }
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView
     animateWithDuration:duration
     animations:^{
         if (self.isPopping) {
             snapView.transform = startTransform;
         } else {
             snapView.transform = CGAffineTransformIdentity;
         }
     }
     completion:^(BOOL finished) {
         if (! self.isPopping) {
             [containerView addSubview:toViewController.view];
         }
         [snapView removeFromSuperview];
         [transitionContext completeTransition:YES];
     }];
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
