//
//  AutorotateViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/7/3.
//  Copyright © 2019年 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutorotateViewController : MWBaseViewController

@property (nonatomic, assign) BOOL isAutoRotate; // 是否支持转屏 默认否
@property (nonatomic, assign) UIInterfaceOrientationMask supportedOrientation; // 支持方向 默认Portrait
@property (nonatomic, assign) UIInterfaceOrientation preferredOrientation; // 刚展示时的方向， 默认Portait

@property (nonatomic, assign) UIInterfaceOrientationMask configSupportedOrientation;

@end

NS_ASSUME_NONNULL_END
