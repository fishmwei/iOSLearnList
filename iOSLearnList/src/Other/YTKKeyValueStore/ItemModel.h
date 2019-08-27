//
//  ItemModel.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/27.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, assign) NSInteger time;

@end

NS_ASSUME_NONNULL_END
