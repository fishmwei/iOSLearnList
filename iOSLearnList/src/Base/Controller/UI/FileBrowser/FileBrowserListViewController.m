//
//  FileBrowserListViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/11/14.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "FileBrowserListViewController.h"
#import "FileBrowserViewController.h"

@interface FileBrowserListViewController ()

@end

@implementation FileBrowserListViewController

+ (NSString *)cellTitle {

    return @"目录浏览";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showData = @[
                      @"Documents",
                      @"Cache",
                      @"Library"
                      ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self.showData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            FileBrowserViewController *vc = [[FileBrowserViewController alloc] initWithDirectoryPath:path];
            [vc setTitle:[self.showData objectAtIndex:indexPath.row]];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}

@end
