//
//  ELSDPBaseAnimation.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/6/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ELSDPAnimationType) {
    ELSDPAnimationPresent,
    ELSDPAnimationDismiss
};


@interface ELSDPBaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) ELSDPAnimationType type;
@property (nonatomic, assign) CGRect modalFrame;

@end
