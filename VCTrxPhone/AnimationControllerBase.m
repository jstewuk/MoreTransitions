//
//  AnimationControllerBase.m
//  VCTrxPhone
//
//  Created by Jim on 12/15/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import "AnimationControllerBase.h"

@implementation AnimationControllerBase

- (NSString *)animationName {
    return NSStringFromClass([self class]);
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSAssert(NO, @"Must be overwritten in subclass");
}
@end
