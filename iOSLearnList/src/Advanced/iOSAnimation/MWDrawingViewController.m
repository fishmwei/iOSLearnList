//
//  MWDrawingViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWDrawingViewController.h"
#import <MWUITools/MWUITools.h>


@interface MWDrawingViewController ()

@end


@implementation MWDrawingViewController

- (void)loadView
{
    //    MWCGDrawView *vv = [[MWCGDrawView alloc] init];
    //    vv.MWDrawColor = [UIColor blueColor];

    MWCAShapeDrawView *vv = [[MWCAShapeDrawView alloc] init];
    vv.strokeColor = [UIColor blueColor];
    vv.fillColor = [UIColor redColor];

    self.view = vv;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

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
