//
//  ocmA.h
//  iOSLearnList
//
//  Created by mingwei on 2017/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ocmB;
@interface ocmA : NSObject
@property (nonatomic, strong) ocmB *b;

- (NSString*)name;

- (NSString *)showInt:(NSNumber *)intValue;

@end
