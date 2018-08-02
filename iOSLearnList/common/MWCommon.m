//
//  MWCommon.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWCommon.h"


@implementation MWCommon
+ (UIImage *)imageNamed:(NSString *)imageName
{
    //    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"iOSLearnListBundle" ofType:@"bundle"]];
    //
    //    return [[UIImage imageWithContentsOfFile:[bundle pathForResource:imageName ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];


    //先获取bundle
    //    NSBundle *mwBundle = nil;
    //    NSString *mwBundlePath = [[NSBundle mainBundle] pathForResource:@"iOSLearnListBundle" ofType:@"bundle"];
    //    if (mwBundlePath && [[NSFileManager defaultManager] fileExistsAtPath:mwBundlePath]) {
    //        mwBundle = [NSBundle bundleWithPath:mwBundlePath];
    //    }
    //
    //    if (mwBundle == nil) {
    //        mwBundle = [NSBundle mainBundle];
    //    }
    //
    //    NSString *imgPath = [mwBundle pathForResource:imageName ofType:@"png"];
    //
    //    if (mwBundle) {
    //        return [];
    //    }


    NSString *bundleName = @"iOSLearnListBundle";
    NSString *str = [NSString stringWithFormat:@"%@.bundle/%@", bundleName, imageName];
    if ([UIImage imageNamed:str]) {
        return [UIImage imageNamed:str];
    }

    return [UIImage imageNamed:imageName];


    //   return [UIImage imageWithContentsOfFile:[iOSLearnBundle_Path stringByAppendingPathComponent:imageName]];
}


@end
