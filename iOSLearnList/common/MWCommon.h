//
//  MWCommon.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define iOSLearnBundle_Name @"iOSLearnList.bundle"
#define iOSLearnBundle_Path [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:iOSLearnBundle_Name]
#define iOSLearnBundle [NSBundle bundleWithPath:iOSLearnBundle_Path]


@interface MWCommon : NSObject
+ (UIImage *)imageNamed:(NSString *)imageName;

@end
