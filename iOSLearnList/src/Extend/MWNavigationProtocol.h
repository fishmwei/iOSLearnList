//
//  MWNavigationProtocol.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/7/24.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MWNavigationProtocol <NSObject>

- (void)processOrientationWhenPushViewController:(UIViewController *)controller;

- (void)processOrientationWhenPopViewController;

@end

NS_ASSUME_NONNULL_END
