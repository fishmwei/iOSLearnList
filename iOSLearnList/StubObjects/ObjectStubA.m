//
//  ObjectStubA.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "ObjectStubA.h"


@interface ObjectStubA ()
{
    NSString *_name;
}

@end


@implementation ObjectStubA

+ (id)stubA:(NSString *)name {
    return [[ObjectStubA alloc] initWithName:name];
}

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }

    return self;
}

- (void)showName {
    NSLog(@"name is %@", _name);
}

@end
