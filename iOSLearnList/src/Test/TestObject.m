//
//  TestObject.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/10/13.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "TestObject.h"
#import "ObjectSaveProtocol.h"

@interface TestObject()
@property (nonatomic, weak) id<ObjectSaveProtocol> consumer;
@end

@implementation TestObject
- (instancetype)initWithConsumer:(id<ObjectSaveProtocol>)consumer {
    self = [super init];
    if (self) {
        self.consumer = consumer;
        [self consumerSelf];
    }
    
    return self;
}

- (void)consumerSelf {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.consumer saveObject:self];
    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.consumer saveObject:self];
//    });
}


@end
