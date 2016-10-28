//
//  MWMtlObject.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWMtlObject.h"

@implementation MWMtlObject

static NSDateFormatter *datefmt;

+ (void)initialize {
    static dispatch_once_t p;
    dispatch_once(&p, ^{
        datefmt = [[NSDateFormatter alloc] init];
        datefmt.locale = [NSLocale currentLocale];
    });
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
        @"name":@"name",
        @"age":@"age",
        @"saveTime":@"saveTime"};
}

+ (NSValueTransformer *)saveTimeJSONTransformerForKey:(NSString *)key {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [datefmt dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [datefmt stringFromDate:date];
    }];
}

@end
