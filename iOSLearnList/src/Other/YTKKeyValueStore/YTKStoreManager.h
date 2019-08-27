//
//  YTKStoreManager.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/27.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ItemModel;

@interface YTKStoreManager : NSObject

+ (instancetype)sharedManager;

- (NSArray *)getTableNames;

- (void)createTable:(NSString *)name;

- (void)removeTable:(NSString *)name;

- (void)addItem:(ItemModel *)item talbeName:(NSString *)tableName;

- (void)removeItem:(ItemModel *)item talbeName:(NSString *)tableName;

- (NSArray <ItemModel *> *)getItems:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
