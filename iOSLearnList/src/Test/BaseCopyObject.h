//
//  BaseCopyObject.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/16.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCopyObject : NSObject
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDictionary *content;


- (id)initWithId:(NSString *)objectId content:(NSDictionary *)content;

@end

NS_ASSUME_NONNULL_END
