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
- (NSString*)name {
    return [self.b name];
}

- (NSString *)showInt:(NSUInteger)intValue {
//    NSLog(@"");
    return [NSString stringWithFormat:@"%@", intValue];
}

@end
