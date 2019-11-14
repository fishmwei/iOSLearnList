//
//  FileBrowserViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/11/14.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "IndexTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class FileBrowserInfo;
@protocol FileBrowserViewControllerDelegate <NSObject>

- (BOOL)shouldShowFileInfo:(FileBrowserInfo *)info;

@end

@interface FileBrowserViewController : IndexTableViewController

@property (nonatomic, weak) id<FileBrowserViewControllerDelegate> fileListDelegate;

- (instancetype)initWithDirectoryPath:(NSString *)directoryPath;

@end

NS_ASSUME_NONNULL_END
