//
//  ConfigCommon.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "ConfigCommon.h"


@interface ConfigCommon ()
{
    NSDictionary *dict;
}

@end


@implementation ConfigCommon

+ (id)shareInstance {
    static ConfigCommon *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ConfigCommon alloc] init];
        [instance readData];
    });

    return instance;
}

#pragma mark - private
- (void)readData {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Configuration" ofType:@"plist"];
    dict = [NSDictionary dictionaryWithContentsOfFile:path];
}

- (NSString *)currentConfig {
    return [dict objectForKey:@"CurrentConfig"];
}

@end
