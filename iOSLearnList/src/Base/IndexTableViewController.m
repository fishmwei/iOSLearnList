//
//  IndexTableViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/12.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "IndexTableViewController.h"


@implementation IndexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.navigationItem.title) {
        self.navigationItem.title = NSStringFromClass([self class]);
    }

    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewSafeAreaInsetsDidChange {
}

- (void)backBtnPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    cell.textLabel.text = [self.showData objectAtIndex:indexPath.row];


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self.showData objectAtIndex:indexPath.row];
    Class cls = NSClassFromString(className);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (cls) {
            UIViewController *vc = [[cls alloc] init];
            vc.hidesBottomBarWhenPushed = YES;

            if ([vc respondsToSelector:@selector(setIsOriginalNavigationBarHidden:)] && self.navigationController) {
                [vc performSelector:@selector(setIsOriginalNavigationBarHidden:) withObject:@(self.navigationController.navigationBarHidden)];
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    });


    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotate {
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
