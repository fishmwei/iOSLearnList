//
//  MWBaseAnimation.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/6/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MWAnimationType) {
    MWAnimationPresent,
    MWAnimationDismiss
};


@interface MWBaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) MWAnimationType type;
@property (nonatomic, assign) CGRect modalFrame;

@end
