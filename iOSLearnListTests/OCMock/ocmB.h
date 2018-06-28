//
//  ocmB.h
//  iOSLearnList
//
//  Created by mingwei on 2017/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ocmB : NSObject
- (NSString*)name;

- (NSString *)parseInt:(NSUInteger)value;

- (BOOL)isValidNumber:(NSNumber *)num;

+ (NSString *)getEntryName;

@end
