//
//  MWJSPerson.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWJSPerson.h"


@implementation MWJSPerson

@synthesize urls;

- (NSString *)fullName
{
    if (self.firstName && self.lastName) {
        return [self.firstName stringByAppendingString:self.lastName];
    }

    return @"unknow";
}

- (void)setFirstName:(NSString *)firstName lastName:(NSString *)lastName
{
    [self setFirstName:firstName];
    [self setLastName:lastName];
}


- (void)setFirstName:(NSString *)firstName
{
    _firstName = firstName;
}

@end
