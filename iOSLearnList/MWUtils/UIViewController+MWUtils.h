//
//  UIViewController+MWUtils.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/10/31.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MWUtils)

/*
 * 保存controller创建时，导航栏的隐藏状态，框架在gopage时，调用push时会赋值, default NO
 */
@property (nonatomic, assign) BOOL previousNavigationBarHidden;

@end

NS_ASSUME_NONNULL_END
