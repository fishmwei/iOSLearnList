//
//  MWBaseViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface MWBaseViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, retain) MBProgressHUD *tipHud;


@property (nonatomic, assign) BOOL isOriginalNavigationBarHidden;
@property (nonatomic, assign) BOOL isNextNavigationBarHidden;
@property (nonatomic, assign) BOOL isFirstInto;


@end


@implementation MWBaseViewController
- (id)init {
    self = [super init];
    if (self) {
        //        self.hidesBottomBarWhenPushed = YES;
        _isOriginalNavigationBarHidden = YES;
        _isNextNavigationBarHidden = NO;
        _isFirstInto = YES;
        _hideNavigationbar = NO;
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isFirstInto) {
        [self.navigationController setNavigationBarHidden:self.hideNavigationbar animated:NO];
        self.isFirstInto = NO;
    } else {
        [self.navigationController setNavigationBarHidden:self.hideNavigationbar animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hideNavigationbar animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //Pop
    if (self.isMovingFromParentViewController) {
        [self.navigationController setNavigationBarHidden:_isOriginalNavigationBarHidden animated:YES];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        return;
    }

    if (self.isBeingDismissed) {
        return;
    }

    if ([self isEqual:self.navigationController.topViewController]) {
        return;
    }

    [self.navigationController setNavigationBarHidden:_isNextNavigationBarHidden animated:animated];
}

#pragma mark 设置手势右滑后退
- (void)setRightPanPopCtrlEnabled:(BOOL)isEnabled {
    //禁用滑动后退
    self.navigationController.interactivePopGestureRecognizer.enabled = isEnabled;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;


    self.view.backgroundColor = [UIColor whiteColor];

#ifdef __IPHONE_7_0
    {
        self.edgesForExtendedLayout = UIRectEdgeBottom;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif

    _tipHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_tipHud];

    screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTextTips:(NSString *)tips {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view addSubview:_tipHud];
    [self.view bringSubviewToFront:_tipHud];

    _tipHud.mode = MBProgressHUDModeText;
    _tipHud.labelText = tips;
    [_tipHud show:YES];
    [_tipHud hide:YES afterDelay:1];
}

- (void)showLoadingTips {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view addSubview:_tipHud];
    [self.view bringSubviewToFront:_tipHud];

    _tipHud.labelText = nil;
    _tipHud.mode = MBProgressHUDModeIndeterminate;
    [_tipHud show:YES];
}

- (void)dismissLoadingTips {
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
