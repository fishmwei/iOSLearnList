//
//  ConfigCommon.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "ConfigCommon.h"

@interface ConfigCommon()
{
    NSDictionary *dict;
}

@end
@implementation ConfigCommon


#pragma  mark - private
- (void)readData
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Configuration" ofType:@"plist"];
    dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
}



@end
