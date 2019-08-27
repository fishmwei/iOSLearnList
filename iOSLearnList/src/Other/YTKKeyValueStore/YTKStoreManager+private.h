//
//  YTKStoreManager+private.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/27.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "YTKStoreManager.h"

#import <YTKKeyValueStore/YTKKeyValueStore.h>

NS_ASSUME_NONNULL_BEGIN

#define TABLE_LIST_NAME @"tables"

@interface YTKStoreManager ()

@property (nonatomic, strong) YTKKeyValueStore *store;

@end

NS_ASSUME_NONNULL_END
