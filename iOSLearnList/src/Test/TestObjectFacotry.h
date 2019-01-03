//
//  TestObjectFacotry.h
//  iOSLearnList
//
//  Created by huangmingwei on 17/10/13.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestObjectSellerProtocol.h"
#import "TestObject.h"


@interface TestObjectFacotry : NSObject

+ (instancetype)sharedInstance;

- (void)addListener:(id<TestObjectSellerProtocol>)listener;


@end
