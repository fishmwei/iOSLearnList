//
//  TabAnimation.m
//  iOSLearnList
//
//  Created by huangmingwei on 2018/7/2.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import "TabAnimation.h"

@implementation TabAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * container = transitionContext.containerView;
    
    UIView *oldView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    oldView.frame = [transitionContext initialFrameForViewController:fromVC];
    fromVC.view.hidden = YES;
    

    // 都添加到container中。注意顺序
    [container addSubview:toVC.view];
    [container addSubview:oldView];
    
    CGRect oldStartFrame = oldView.frame;
    CGRect oldEndFrame = CGRectMake(oldStartFrame.origin.x-oldStartFrame.size.width, oldStartFrame.origin.y, oldStartFrame.size.width, oldStartFrame.size.height);
    CGRect toStartFrame = CGRectMake(oldStartFrame.origin.x+oldStartFrame.size.width, oldStartFrame.origin.y, oldStartFrame.size.width, oldStartFrame.size.height);
    if (self.start > self.end) {
        //往右
        oldEndFrame = CGRectMake(oldStartFrame.origin.x+oldStartFrame.size.width, oldStartFrame.origin.y, oldStartFrame.size.width, oldStartFrame.size.height);
        toStartFrame = CGRectMake(oldStartFrame.origin.x-oldStartFrame.size.width, oldStartFrame.origin.y, oldStartFrame.size.width, oldStartFrame.size.height);
    }
    
    // 设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
    toVC.view.frame = toStartFrame;
    
    // 执行动画
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
 
        oldView.frame = oldEndFrame;
        
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        
//        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVC.view.hidden = NO;
        
        [oldView removeFromSuperview];
        //一定要记得动画完成后执行此方法，让系统管理 navigation
        [transitionContext completeTransition:YES];
    }];
}
@end
