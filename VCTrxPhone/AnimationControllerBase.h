//
//  AnimationControllerBase.h
//  VCTrxPhone
//
//  Created by Jim on 12/15/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationControllerBase : NSObject <UIViewControllerAnimatedTransitioning>

/**
 isPopping == YES: view controller is getting popped off the stack
 */
@property (nonatomic, assign) BOOL isPopping;
@property (nonatomic, copy) NSString *animationName;

@end
