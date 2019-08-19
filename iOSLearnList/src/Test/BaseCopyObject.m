//
//  BaseCopyObject.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/16.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "BaseCopyObject.h"

@implementation BaseCopyObject
- (id)initWithId:(NSString *)objectId content:(NSDictionary *)content {
    self = [super init];
    if (self) {
        _objectId = objectId;
        _content = [content copy];
    }
    
    return self;
}

@end
