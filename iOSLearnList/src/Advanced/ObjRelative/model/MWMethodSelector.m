//
//  MWMethodSelector.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/3.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWMethodSelector.h"
#import <objc/runtime.h>


@implementation MWMethodSelector

- (void)printTag
{
    NSLog(@"Class name:%s tagStr:%@", object_getClassName([self class]), self.tagStr);
}

@end
