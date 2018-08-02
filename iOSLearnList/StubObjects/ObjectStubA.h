//
//  ObjectStubA.h
//  iOSLearnList
//
//  Created by huangmingwei on 17/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectStubA : NSObject

+ (id)stubA:(NSString *)name;

- (id)initWithName:(NSString *)name;
- (void)showName;

@end
