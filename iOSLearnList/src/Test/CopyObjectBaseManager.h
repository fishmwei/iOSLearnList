//
//  CopyObjectBaseManager.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/16.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCopyObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CopyObjectBaseManager : NSObject <NSCopying>
{
@protected
    
    BOOL _finishParse;
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, __kindof BaseCopyObject *> *allConfig;

@end


NS_ASSUME_NONNULL_END
