//
//  CustomTableViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2018/7/27.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import "CustomTableViewController.h"
#import <Masonry/Masonry.h>


@interface CustomTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*showData;
@end

@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setupTableView];
    
    self.showData = @[@{
                       @"title":@"声明了jssdk注入的页面",
                       @"key":@"imported"
                       },
                      @{
                          @"title":@"声明了jssdk未注入的页面",
                          @"key":@"unImported"
                          },
                      @{
                          @"title":@"声明了jssdk注入的颗粒页面",
                          @"key":@"plugin_imported"
                          },
                      @{
                          @"title":@"声明了jssdk未注入的颗粒页面",
                          @"key":@"plugin_unImported"
                          }
                      ];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  - mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma  - mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *data = [self.showData objectAtIndex:indexPath.row];
    cell.textLabel.text = data[@"title"];
    return cell;
}

- (void)goPage:(NSString *)pageURI{
    if (!pageURI) {
        return;
    }
    
    
}

@end
