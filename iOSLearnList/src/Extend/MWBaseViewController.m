//
//  MWBaseViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIViewController+MWUtils.h"


@interface MWBaseViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, retain) MBProgressHUD *tipHud;


@property (nonatomic, assign) BOOL isNextNavigationBarHidden;
@property (nonatomic, assign) BOOL isFirstInto;


@end


@implementation MWBaseViewController
- (id)init {
    self = [super init];
    if (self) {
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
    
    if ([self shouldAutorotate]) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [UIViewController attemptRotationToDeviceOrientation];
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
        [self.navigationController setNavigationBarHidden:self.previousNavigationBarHidden animated:YES];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        return;
    }
    
//    // 开启自动旋转， 那么在消失时 发送通知
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    // 获取设备方向
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationUnknown) forKey:@"orientation"];
//    [UIViewController attemptRotationToDeviceOrientation];
//    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
//
//
//    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
//
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
 
    
    // 返回键不显示title
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    
    if (!self.title && !self.navigationItem.title) {
        if ([[self class] respondsToSelector:@selector(cellTitle)]) {
            self.navigationItem.title =  [[self class] performSelector:@selector(cellTitle)];
        } else {
            self.navigationItem.title = NSStringFromClass([self class]);
        }
    }
    
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

//- (BOOL)shouldAutorotate {
//    return NO;
//}

//- (BOOL)prefersStatusBarHidden {
//    return NO;
//}


@end
