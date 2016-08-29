//
//  CAScrollViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/8/4.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "CAScrollViewController.h"
#import "CACustomScrollView.h"

@interface CAScrollViewController ()

@end

@implementation CAScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CACustomScrollView *vv = [[CACustomScrollView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    vv.layer.frame = CGRectMake(0, 0, 200, 200);
    
    [self.view addSubview:vv];
    vv.layer.contents = (__bridge id)[UIImage imageNamed:@"launch4"].CGImage;
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
