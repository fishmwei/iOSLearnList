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
#import "MWNavigationProtocol.h"

@interface AutorotateViewController () <MWNavigationProtocol>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) BOOL inLandScape;
@end

@implementation AutorotateViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _isAutoRotate = YES;
        _inLandScape = NO;
        _supportedOrientation = UIInterfaceOrientationMaskPortrait;
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
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    NSLog(@"First %ld", [UIDevice currentDevice].orientation);
    
    self.view.backgroundColor = [UIColor redColor];
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor lightGrayColor];
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
    
    UIViewController *vc = [MWBaseViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forceOrientation2Landscape {
//    _isAutoRotate = YES;
    _inLandScape = YES;
    self.supportedOrientation = UIInterfaceOrientationMaskLandscape;
    
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationUnknown) forKey:@"orientation"];
//    [UIViewController attemptRotationToDeviceOrientation];
    
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
//    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)resumeOrientation {
 
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)enableAutoRotate {
    _isAutoRotate = !_isAutoRotate;
}

#pragma mark - orientation

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    if (_inLandScape) {
        self.supportedOrientation = UIInterfaceOrientationMaskLandscape;
        
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
        [UIViewController attemptRotationToDeviceOrientation];
    }
    
    UIDeviceOrientation oriention = [[UIDevice currentDevice] orientation];
    if (oriention != UIDeviceOrientationPortrait) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    [self handleDeviceOrientationDidChange:UIInterfaceOrientationUnknown];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
   
    [super viewWillDisappear:animated];
    
//    if (_inLandScape) {
        _supportedOrientation = UIInterfaceOrientationMaskPortrait;
        _preferredOrientation = UIInterfaceOrientationPortrait;
    
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
        [UIViewController attemptRotationToDeviceOrientation];
//    }
    
    /**
     *  销毁 设备旋转 通知
     *
     *  @return return value description
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil
     ];
    
    
    /**
     *  结束 设备旋转通知
     *
     *  @return return value description
     */
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
}

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    return;
    
    
    //1.获取 当前设备 实例
    UIDevice *device = [UIDevice currentDevice];
    
    if (device.orientation != UIDeviceOrientationPortrait) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    BOOL shouldRotate = NO;
    /**
     *  2.取得当前Device的方向，Device的方向类型为Integer
     *
     *  必须调用beginGeneratingDeviceOrientationNotifications方法后，此orientation属性才有效，否则一直是0。orientation用于判断设备的朝向，与应用UI方向无关
     *
     *  @param device.orientation
     *
     */
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            shouldRotate = YES;
            break;
            
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            shouldRotate = YES;
            break;
            
            //系統無法判斷目前Device的方向，有可能是斜置
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            //  旋转角度 =  需要旋转的角度 - 当前的角度
            shouldRotate = YES;
//            self.view.transform = CGAffineTransformMakeRotation((CGFloat)(90 *M_PI)/180);
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
//            self.view.transform = CGAffineTransformMakeRotation((CGFloat)(-90 *M_PI)/180);
            shouldRotate = YES;
            break;
            
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            shouldRotate = YES;
//            self.view.transform = CGAffineTransformMakeRotation((CGFloat)(0 *M_PI)/180);
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕直立，上下顛倒");
//            self.view.transform = CGAffineTransformMakeRotation((CGFloat)(0 *M_PI)/180);
            break;
            
        default:
            NSLog(@"无法辨识");
            break;
    }
    
    if ((NSInteger)device.orientation != (NSInteger)interfaceOrientation && shouldRotate) {
        [UIViewController attemptRotationToDeviceOrientation];
    }
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications ];
}

/**
 * 是否自动旋转
 */
- (BOOL)shouldAutorotate {
    return _isAutoRotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.supportedOrientation;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
      return self.preferredOrientation;
}

#pragma mark -- 更新状态栏方向

- (void)refreshStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation {
    [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:YES];
}

- (void)processOrientationWhenPushViewController:(UIViewController *)controller {
////    if (![controller shouldAutorotate]) {
////        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//
////        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationUnknown) forKey:@"orientation"];
////        [UIViewController attemptRotationToDeviceOrientation];
//
//        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
//        [UIViewController attemptRotationToDeviceOrientation];
//
////        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
////    }
}

- (void)processOrientationWhenPopViewController {
    // 恢复？ 之前的界面?
    
//    _supportedOrientation = UIInterfaceOrientationMaskPortrait;
//    _preferredOrientation = UIInterfaceOrientationPortrait;
    
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
}

@end
