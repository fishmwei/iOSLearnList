//
//  LevelViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/13.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "LevelViewController.h"

@implementation LevelViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"LevelViewController"];
    
    

//    
//    [self.navigationController.navigationItem setTintColor:[UIColor orangeColor]];
//    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    btn.center = self.view.center;
    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitle:@"Next" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)gotoNext
{
    UIViewController *vc = [[[self class] alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
