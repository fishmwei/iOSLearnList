//
//  ItemModel.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/27.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"key" : @"key",
             @"name" : @"name",
             @"position" : @"position",
             @"time": @"time"
             };
}

@end
