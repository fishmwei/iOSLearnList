//
//  AutorotateViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/7/3.
//  Copyright © 2019年 fishmwei. All rights reserved.
//

#import "AutorotateViewController.h"
#import "MWBaseViewController.h"
#import "MWOrientation.h"


@interface AutorotateViewController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) BOOL inLandScape;
@end

@implementation AutorotateViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _isAutoRotate = YES;
        _inLandScape = NO;
        _supportedOrientation = UIInterfaceOrientationMaskAll;
        _preferredOrientation = UIInterfaceOrientationPortrait;
    }
    
    return self;
}

- (void)moveBgViewToView:(UIView *)parentView {
    [_bgView removeFromSuperview];
    
    [parentView addSubview:_bgView];
    _bgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // masConstraint ??
    [parentView addConstraints: @[
                                 [NSLayoutConstraint constraintWithItem:_bgView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:parentView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:0],
                                 [NSLayoutConstraint constraintWithItem:_bgView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:parentView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1
                                                               constant:0],
                                 [NSLayoutConstraint constraintWithItem:_bgView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:parentView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1
                                                               constant:0],
                                 [NSLayoutConstraint constraintWithItem:_bgView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:parentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:0],
                                 
                                 ]];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _bgView = [UIView new];
    [self moveBgViewToView:self.view];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_bgView addSubview:btn];
    btn.frame = CGRectMake(0, 60, 200, 30);
    [btn setTitle:@"Rotate" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(enableAutoRotate) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_bgView addSubview:btn];
    btn.frame = CGRectMake(0, 90, 200, 30);
    [btn setTitle:@"Landscape" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(forceOrientation2Landscape) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_bgView addSubview:btn];
    btn.frame = CGRectMake(0, 120, 200, 30);
    [btn setTitle:@"goBack" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_bgView addSubview:btn];
    btn.frame = CGRectMake(0, 150, 200, 30);
    [btn setTitle:@"NextAuto" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextAuto) forControlEvents:UIControlEventTouchUpInside];
    
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_bgView addSubview:btn];
    btn.frame = CGRectMake(0, 200, 200, 30);
    [btn setTitle:@"NextNormal" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextNormal) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)nextAuto {
    UIViewController *vc = [AutorotateViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)nextNormal {
    [[MWOrientation sharedInstance] lockToPortrait];
    
    UIViewController *vc = [MWBaseViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)resumeOrientation {
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
//    [UIViewController attemptRotationToDeviceOrientation];
    
    [[MWOrientation sharedInstance] lockToPortrait];
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)enableAutoRotate {
    _isAutoRotate = !_isAutoRotate;
}

#pragma mark - orientation


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    if (self.isMovingFromParentViewController) {
        [[MWOrientation sharedInstance] unlockAllOrientations];
    }
    
    [super viewDidDisappear:animated];
    
    
}

/**
 * 是否自动旋转
 */
- (BOOL)shouldAutorotate {
    return YES;
    if (self.isMovingFromParentViewController) {
        return NO;
    }
    
    return self.isAutoRotate; //暂时只支持默认的竖屏
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.supportedOrientation;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return self.preferredOrientation;
    return UIInterfaceOrientationLandscapeRight;
}
- (BOOL)prefersStatusBarHidden {
    //    [super prefersStatusBarHidden];
    
//    [super prefersStatusBarHidden]
    return NO;
}
- (void)forceOrientation2Landscape {
    
    [[MWOrientation sharedInstance] lockToLandscape];
    return;
    
    if (_inLandScape) {
        return;
    }
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeRight) forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
//    _isAutoRotate = YES;
//
//    /*
//     * 执行动画
//     */
//    [UIView animateWithDuration:0.5 animations:^{
//        self.bgView.transform = CGAffineTransformMakeRotation(M_PI_2);
//        self.bgView.bounds = CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds));
//        self.bgView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
//    } completion:^(BOOL finished) {
//        //        self.state = MovieViewStateFullscreen;
//        _inLandScape = YES;
//    }];
    
//    [self refreshStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
}

//- (void)resumeOrientation {
//    if (!_inLandScape) {
//        return;
//    }
//
////    [UIView animateWithDuration:0.5 animations:^{
////        self.bgView.transform = CGAffineTransformIdentity;
////        self.bgView.bounds = self.view.bounds;
////        self.bgView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
////    } completion:^(BOOL finished) {
////        _inLandScape = NO;
////    }];
////
////    [self refreshStatusBarOrientation:UIInterfaceOrientationPortrait];
//}


#pragma mark -- 更新状态栏方向

- (void)refreshStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation {
    [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:YES];
}

//- (BOOL)prefersS


@end
