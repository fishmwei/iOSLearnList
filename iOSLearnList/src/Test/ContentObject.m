
//
//  NSCopyObject.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/16.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "ContentObject.h"

@implementation ContentObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _addr = [NSString stringWithFormat:@"addr %p", self];
    }
    
    return self;
}

//- (id)copyWithZone:(NSZone *)zone {
//    CopyObject *obj = [[self class] allocWithZone:zone];
//    obj.configs = [_configs mutableCopy];
//    obj.name = _name;
//
//    return obj;
//}
//
//- (NSString *)description {
//    return [NSString stringWithFormat:@"name: %@  %p, \r\n %@", _name, (void *)_configs, _configs];
//}

@end
