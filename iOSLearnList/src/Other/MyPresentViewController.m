//
//  MyPresentViewController.m
//  iOSLearnList
//
//  Created by mingwei on 2018/8/1.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import "MyPresentViewController.h"

@interface MyPresentViewController ()

@end

@implementation MyPresentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"close" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
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
