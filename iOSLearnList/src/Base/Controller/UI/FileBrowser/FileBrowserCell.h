//
//  FileBrowserCell.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/11/14.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FileBrowserInfo;
@interface FileBrowserCell : UITableViewCell

- (void)fillWithInfo:(FileBrowserInfo *)info;

@end

NS_ASSUME_NONNULL_END
