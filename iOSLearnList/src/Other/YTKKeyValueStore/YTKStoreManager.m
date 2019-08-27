//
//  YTKStoreManager.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/27.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "YTKStoreManager.h"
#import "YTKStoreManager+private.h"
#import <Mantle/Mantle.h>
#import "ItemModel.h"

@implementation YTKStoreManager

+ (instancetype)sharedManager {
    static YTKStoreManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YTKStoreManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _store = [[YTKKeyValueStore alloc] initDBWithName:@"ytkStore.db"];
        [_store createTableWithName:TABLE_LIST_NAME];
    }
    
    return self;
}

- (NSArray *)getTableNames {
    NSArray *items = [_store getAllItemsFromTable:TABLE_LIST_NAME];
    NSMutableArray *names = [NSMutableArray array];
    
    for (YTKKeyValueItem *item in items) {
        NSArray *content = item.itemObject;
        [names addObjectsFromArray:content];
    }
    
    return [names copy];
}

- (void)createTable:(NSString *)name {
    if (name && name.length > 0) {
        [_store createTableWithName:name];
        [_store putString:name withId:name intoTable:TABLE_LIST_NAME];
    }
}

- (void)removeTable:(NSString *)name {
    [_store clearTable:name];
    [_store deleteObjectById:name fromTable:TABLE_LIST_NAME];
}


- (void)addItem:(ItemModel *)item talbeName:(NSString *)tableName {
    NSDictionary *info = [MTLJSONAdapter JSONDictionaryFromModel:item error:nil];
    [_store putObject:info withId:item.key intoTable:tableName];
}

- (void)removeItem:(ItemModel *)item talbeName:(NSString *)tableName {
    [_store deleteObjectById:item.key fromTable:tableName];
}

- (NSArray <ItemModel *> *)getItems:(NSString *)tableName {
    NSArray *allItems = [_store getAllItemsFromTable:tableName];
    NSMutableArray *results = [NSMutableArray array];
    for (YTKKeyValueItem *item in allItems) {
        NSDictionary *info = item.itemObject;
        ItemModel *model = [MTLJSONAdapter modelOfClass:[ItemModel class] fromJSONDictionary:info error:nil];
        [results addObject:model];
    }
    
    return [results copy];
}

@end
