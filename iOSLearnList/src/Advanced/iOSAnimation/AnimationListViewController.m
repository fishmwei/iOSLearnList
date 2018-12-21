//
//  AnimationListViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/27.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "AnimationListViewController.h"


@interface AnimationListViewController ()

@end


@implementation AnimationListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.showData = @[
                      @"CAMediaTimingFunctionVC",
                      @"TimerAnimationViewController",
                      @"CADisplayLinkViewController",
                      @"CAMediaTimingVC",
                      @"MWDrawingViewController",
                      @"RotateTestViewController" ];
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
