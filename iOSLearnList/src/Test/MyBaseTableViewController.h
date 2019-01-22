//
//  MyBaseTableViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/1/22.
//  Copyright © 2019年 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *MyTableViewID = @"cellID";

@interface MyBaseTableViewController : UITableViewController

- (void)configureCell:(UITableViewCell *)cell data:(id)data;

@property (nonatomic, strong) NSArray *filteredProducts;



@end

NS_ASSUME_NONNULL_END
