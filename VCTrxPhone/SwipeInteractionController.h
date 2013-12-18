//
//  SwipeInteractionController.h
//  VCTrxPhone
//
//  Created by Jim on 12/16/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeInteractionController : UIPercentDrivenInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController
        navigationController:navigationController;

@property (nonatomic, assign) BOOL interactionInProgress;

@end
