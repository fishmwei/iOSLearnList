//
//  FileBrowserInfo.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/11/14.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileBrowserInfo : NSObject

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, assign) BOOL isFolder;

@end

NS_ASSUME_NONNULL_END
