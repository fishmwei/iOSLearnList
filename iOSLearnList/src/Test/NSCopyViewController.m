//
//  NSCopyViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/16.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "NSCopyViewController.h"
#import "SubCopyObjectBaseManager.h"

@interface NSCopyViewController ()
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) SubCopyObjectBaseManager *manager;
@end

@implementation NSCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _datas = [NSMutableArray array];
    
    _manager = [[SubCopyObjectBaseManager alloc] init];
    
    NSDictionary *content = @{@"a":@"1", @"b":@2, @"c":@(3)};
    BaseCopyObject *obj = [[BaseCopyObject alloc] initWithId:@"first" content:content];
    [_manager.allConfig setObject:obj forKey:@"a.b.c"];
    
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithTitle:@"Copy" style:UIBarButtonItemStyleDone target:self action:@selector(copyItems)];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithTitle:@"MutableCopy" style:UIBarButtonItemStyleDone target:self action:@selector(copyMutalbeItems)];
    [self.navigationItem setRightBarButtonItems:@[right1, right2]];

    self.showData = self.datas;
}

- (void)copyItems {
    SubCopyObjectBaseManager *copy = [self.manager copy];
    NSDictionary *content = @{@"a":@"1", @"b":@2, @"c":@(3)};
    BaseCopyObject *obj = [[BaseCopyObject alloc] initWithId:@"new" content:content];
    [copy.allConfig setObject:@"bbbb" forKey:@"new"];
    [_datas addObject:copy];
    [self.tableView reloadData];
}

- (void)copyMutalbeItems {

}


#pragma mark - tableView datasource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    CopyObjectBaseManager *obj = [self.showData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
