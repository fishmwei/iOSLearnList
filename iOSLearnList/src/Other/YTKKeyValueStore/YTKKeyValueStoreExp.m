//
//  YTKKeyValueStoreExp.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/26.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "YTKKeyValueStoreExp.h"
#import "YTKTableDetailViewController.h"

@implementation YTKKeyValueStoreExp
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"tables"];
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addTable)];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithTitle:@"Del" style:UIBarButtonItemStyleDone target:self action:@selector(removeTable)];
    [self.navigationItem setRightBarButtonItems:@[right1, right2]];
    
    
    self.showData = [[YTKStoreManager sharedManager] getTableNames];
}

- (void)addTable {
    NSString *tablenName = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [[YTKStoreManager sharedManager] createTable:tablenName];
    
    self.showData = [[YTKStoreManager sharedManager] getTableNames];
    [self.tableView reloadData];
}

- (void)removeTable {
    if (self.showData.count <= 0) {
        return;
    }
    
    NSString *tableName = [self.showData lastObject];
    [[YTKStoreManager sharedManager] removeTable:tableName];
    self.showData = [[YTKStoreManager sharedManager] getTableNames];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tableName = [self.showData objectAtIndex:indexPath.row];
    YTKTableDetailViewController *vc = [YTKTableDetailViewController new];
    [vc setTitle:tableName];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
