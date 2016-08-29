//
//  MW_A.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MW_A.h"

@implementation MW_A
- (void)printClassName {
    NSLog(@"class name in MW_A %@ in %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

@end
