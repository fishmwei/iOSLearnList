//
//  ocmB.m
//  iOSLearnList
//
//  Created by mingwei on 2017/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "ocmB.h"

@implementation ocmB
- (NSString*)name {
    return @"ocmB";
}

- (NSString *)parseInt:(NSUInteger)value {
    return [NSString stringWithFormat:@"%lu", value];
}

- (BOOL)isValidNumber:(NSNumber *)num {
    return [num integerValue] < 5;
}

+ (NSString *)getEntryName {
    return NSStringFromClass([self class]);
}

@end
