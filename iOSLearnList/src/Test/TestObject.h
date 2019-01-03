//
//  TestObject.h
//  iOSLearnList
//
//  Created by huangmingwei on 17/10/13.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectSaveProtocol;


@interface TestObject : NSObject
- (instancetype)initWithConsumer:(id<ObjectSaveProtocol>)consumer;
@property (nonatomic, assign) NSInteger number;


@end
