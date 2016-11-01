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

//+ (NSValueTransformer *)saveTimeJSONTransformerForKey:(NSString *)key {
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
//        return [datefmt dateFromString:dateString];
//    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
//        return [datefmt stringFromDate:date];
//    }];
//}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}

+ (NSValueTransformer *)saveTimeJSONTransformer {
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError **error) {
//        if ([value isKindOfClass:[NSString class]]) {
//            NSString *time = (NSString *)value;
//            NSDate *date = [self.dateFormatter dateFromString:time];
//            return @([date timeIntervalSince1970]);
//        } else if ([value isKindOfClass:[NSNumber class]]) {
//            return (NSNumber *)value;
//        }
//        return nil;
//    }];
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError **error) {
        NSNumber *dateNum = (NSNumber *)value;
        
        return [NSDate dateWithTimeIntervalSince1970:dateNum.floatValue];
    } reverseBlock:^id(id value, BOOL *success, NSError **error) {
        NSDate *numDate = (NSDate *)value;
        
        return [NSString stringWithFormat:@"%f", [numDate timeIntervalSince1970]];
    }];
}

@end
