//
//  ocmA.m
//  iOSLearnList
//
//  Created by mingwei on 2017/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "ocmA.h"
#import "ocmB.h"


@implementation ocmA
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.b = [ocmB new];
    }
    
    return self;
}

- (NSString*)name {
    return [self.b name];
}

@end
