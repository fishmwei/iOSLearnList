//
//  BaseMainViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "BaseMainViewController.h"


@interface BaseMainViewController ()

@end


@implementation BaseMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController.navigationBar.topItem setTitle:@"BaseVC"];
    self.showData = @[ @"UIBaseViewController", @"SysBaseViewController", @"ObjBaseViewController" ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
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
