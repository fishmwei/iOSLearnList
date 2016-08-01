//
//  MWBaseViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MWBaseViewController ()

@property (nonatomic, retain) MBProgressHUD *tipHud;

@end

@implementation MWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
#ifdef __IPHONE_7_0
    {
        self.edgesForExtendedLayout = UIRectEdgeBottom;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
    
    _tipHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_tipHud];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTextTips:(NSString *)tips
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view addSubview:_tipHud];
    [self.view bringSubviewToFront:_tipHud];
    
    _tipHud.mode = MBProgressHUDModeText;
    _tipHud.labelText = tips;
    [_tipHud show:YES];
    [_tipHud hide:YES afterDelay:1];
}

- (void)showLoadingTips
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view addSubview:_tipHud];
    [self.view bringSubviewToFront:_tipHud];
    
    _tipHud.labelText = nil;
    _tipHud.mode = MBProgressHUDModeIndeterminate;
    [_tipHud show:YES];
}

- (void)dismissLoadingTips
{
    [_tipHud hide:YES];
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
