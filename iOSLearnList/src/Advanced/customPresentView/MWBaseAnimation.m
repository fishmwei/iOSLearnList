//
//  MWBaseAnimation.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/6/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseAnimation.h"


@interface MWBaseAnimation ()
@end


@implementation MWBaseAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSAssert(NO, @"animateTransition: should be handled by subclass of BaseAnimation");
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinch {
    NSAssert(NO, @"handlePinch: should be handled by a subclass of BaseAnimation");
}

@end
