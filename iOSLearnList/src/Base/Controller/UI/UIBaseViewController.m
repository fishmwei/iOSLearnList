//
//  UIBaseViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "UIBaseViewController.h"


@interface UIBaseViewController ()

@end


@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.showData = @[
                      @"FileBrowserListViewController",
                      @"HideNavigatorViewController",
                       @"testCollectionViewController",
                       @"autolayoutCellCtl",
                       @"myTableViewController",
                       @"collectionViewController",
                       @"SearchBarVC",
                       @"iAdViewController",
                       @"PresentingPopoverViewController",
                       @"DatePickerViewController",
                       @"blockViewController",
                       @"WebViewController" ];
    //    self.showData = ;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
