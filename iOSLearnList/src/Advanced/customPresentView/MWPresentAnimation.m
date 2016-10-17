//
//  MWPresentAnimation.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/6/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWPresentAnimation.h"

@interface MWPresentAnimation () {
    UIView *_coverView;
}
@end

@implementation MWPresentAnimation
#pragma mark - Animated Transitioning

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //The view controller's view that is presenting the modal view
    UIView *containerView = [transitionContext containerView];
    
    if (self.type == MWAnimationPresent) {
        //The modal view itself
        UIView *modalView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        
        //View to darken the area behind the modal view
        if (!_coverView) {
            _coverView = [[UIView alloc] initWithFrame:containerView.frame];
            _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
            _coverView.alpha = 0.0;
        } else {
            _coverView.frame = containerView.frame;
        }
        [containerView addSubview:_coverView];
        
        //Using autolayout to position the modal view
        modalView.translatesAutoresizingMaskIntoConstraints = YES;
        [containerView addSubview:modalView];
        [containerView bringSubviewToFront:modalView];
        
        modalView.alpha = 0.0;
        
        [UIView animateWithDuration:0.5 animations:^{
            modalView.alpha = 1.0;
            _coverView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else if (self.type == MWAnimationDismiss) {
        //The modal view itself
        UIView *modalView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        
        //Grab a snapshot of the modal view for animating
        UIView *snapshot = [modalView snapshotViewAfterScreenUpdates:NO];
        snapshot.frame = modalView.frame;
        [containerView addSubview:snapshot];
        [containerView bringSubviewToFront:snapshot];
        [modalView removeFromSuperview];
        
        //Set the snapshot's anchor point for CG transform
//        CGRect originalFrame = snapshot.frame;
//        snapshot.layer.anchorPoint = CGPointMake(0.0, 1.0);
//        snapshot.frame = originalFrame;
        
//        CGRect endFrame = CGRectMake(CGRectGetMinX(originalFrame), CGRectGetMaxY(containerView.frame), CGRectGetWidth(originalFrame), CGRectGetHeight(originalFrame));
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             snapshot.alpha = 0.0;
                             _coverView.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             [snapshot removeFromSuperview];
                             [_coverView removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
        
//        //Animate using keyframe animation
//        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
//            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
//                snapshot.alpha = 0.0;
//                _coverView.alpha = 0.0;
//                
//            }];
//        } completion:^(BOOL finished) {
//            [snapshot removeFromSuperview];
//            [_coverView removeFromSuperview];
//            [transitionContext completeTransition:YES];
//        }];
    }
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.type == MWAnimationPresent) return 0.5;
    else if (self.type == MWAnimationDismiss) return 0.5;
    else return [super transitionDuration:transitionContext];
}

@end
