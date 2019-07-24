//
//  MWOrientation.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/7/24.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MWOrientation : NSObject
+ (void)setOrientation: (UIInterfaceOrientationMask)orientation;
+ (UIInterfaceOrientationMask)getOrientation;

+ (instancetype)sharedInstance;

- (void)lockToPortrait;
- (void)lockToLandscape;
- (void)lockToLandscapeLeft;
- (void)lockToLandscapeRight;
- (void)unlockAllOrientations;

@end

NS_ASSUME_NONNULL_END
