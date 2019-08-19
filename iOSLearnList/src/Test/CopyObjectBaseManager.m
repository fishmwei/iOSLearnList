//
//  CopyObjectBaseManager.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/16.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "CopyObjectBaseManager.h"

@implementation CopyObjectBaseManager

- (id)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (NSMutableDictionary *)allConfig {
    if (!_allConfig) {
        _allConfig = [NSMutableDictionary dictionary];
    }
    
    return _allConfig;
}

- (id)copyWithZone:(NSZone *)zone {
    CopyObjectBaseManager *manager = [[self class] allocWithZone:zone];
    manager->_finishParse = _finishParse;
    manager.allConfig = [self.allConfig mutableCopy]; // allConfig 是可变的
    
    return manager;
}


@end
