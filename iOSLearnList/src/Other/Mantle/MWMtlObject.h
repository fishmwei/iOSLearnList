//
//  MWMtlObject.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MWMtlObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSNumber *age;

@end
