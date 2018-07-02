//
//  TabAnimation.h
//  iOSLearnList
//
//  Created by huangmingwei on 2018/7/2.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TabAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) NSUInteger start;
@property (nonatomic, assign) NSUInteger end;
@end
