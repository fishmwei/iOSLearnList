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
#import "RotateEnvetViewController.h"

@interface AutorotateViewController () <MWNavigationProtocol>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) BOOL inLandScape;

@property (nonatomic, strong) UILabel *orientationLabel;

@end

@implementation AutorotateViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _isAutoRotate = YES;
        _configSupportedOrientation = UIInterfaceOrientationMaskPortrait;
        _supportedOrientation = UIInterfaceOrientationMaskPortrait;
        _preferredOrientation = UIInterfaceOrientationPortrait;
        
//        _configSupportedOrientation = UIInterfaceOrientationMaskLandscapeRight;
//        _supportedOrientation = UIInterfaceOrientationMaskLandscapeRight;
//        _preferredOrientation = UIInterfaceOrientationLandscapeRight;
        
        self.hideNavigationbar = YES;
    }
    
    return self;
}

- (void)updatePreferredOrientation {
    switch (self.supportedOrientation) {
        case UIInterfaceOrientationMaskPortrait:
            self.preferredOrientation = UIInterfaceOrientationPortrait;
            break;
        case UIInterfaceOrientationMaskLandscapeLeft:
            self.preferredOrientation = UIInterfaceOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationMaskLandscapeRight:
        case UIInterfaceOrientationMaskLandscape:
            self.preferredOrientation = UIInterfaceOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationMaskPortraitUpsideDown:
            self.preferredOrientation = UIInterfaceOrientationPortraitUpsideDown;
            break;
        case UIInterfaceOrientationMaskAll:
        case UIInterfaceOrientationMaskAllButUpsideDown:
            self.preferredOrientation = UIInterfaceOrientationPortrait;
            break;
        default:
            self.preferredOrientation = UIInterfaceOrientationPortrait;
            break;
    }
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
    
    self.orientationLabel = [UILabel new];
    [_bgView addSubview:self.orientationLabel];
    self.orientationLabel.frame = CGRectMake(200, 40, 200, 40);
    self.orientationLabel.text = @"UNKNOWN";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DeviceOrientationChanaged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)DeviceOrientationChanaged:(NSNotification *)info {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    UIDeviceOrientation o = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsPortrait(o)) {
        self.orientationLabel.text = @"Portrait";
    } else if (UIDeviceOrientationIsLandscape(o)) {
        self.orientationLabel.text = @"Landscape";
    } else {
        self.orientationLabel.text = @"Error";
    }
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
}

- (void)nextAuto {
    UIViewController *vc = [AutorotateViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)nextNormal {
    
    UIViewController *vc = [RotateEnvetViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forceOrientation2Landscape {
    self.configSupportedOrientation = UIInterfaceOrientationMaskLandscape;
    self.supportedOrientation = self.configSupportedOrientation;
    [self updatePreferredOrientation];
    [self innerSetOrientation];
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

//    if ([[UIDevice currentDevice] orientation] != UIDeviceOrientationPortrait) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    } else {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 内嵌页面不处理
    if (![self.parentViewController  isKindOfClass:[UINavigationController class]] && self.parentViewController) {
        return;
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^(){
        [self innerSetOrientation];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
   
    [super viewWillDisappear:animated];
    
    if (self.beingDismissed) {
        return;
    }
    
    // 内嵌页面不处理
    if (![self.parentViewController  isKindOfClass:[UINavigationController class]] && self.parentViewController) {
        return;
    }
    
    // push 恢复默认竖直方向
    if (NSNotFound != [self.navigationController.viewControllers indexOfObject:self] && ![self.navigationController.topViewController isEqual:self]) {
        self.supportedOrientation = UIInterfaceOrientationMaskPortrait;
        self.preferredOrientation = UIInterfaceOrientationPortrait;
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    }
}

- (void)innerSetOrientation {
    self.supportedOrientation = self.configSupportedOrientation;
    [self updatePreferredOrientation];
    
    // 按需旋转页面
    switch (self.configSupportedOrientation) {
        case UIInterfaceOrientationMaskPortrait:
            if (!UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
                [self forceDeviceOrientation:UIDeviceOrientationPortrait];
            }
            break;
        case UIInterfaceOrientationMaskLandscapeLeft:
            if (UIDeviceOrientationLandscapeRight != ([UIDevice currentDevice].orientation)) {
                [self forceDeviceOrientation:UIDeviceOrientationLandscapeRight];
            }
            break;
        case UIInterfaceOrientationMaskLandscapeRight:
        case UIInterfaceOrientationMaskLandscape:
            if (!UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
                [self forceDeviceOrientation:UIDeviceOrientationLandscapeLeft];
            }
            break;
        case UIInterfaceOrientationMaskAll:
        case UIInterfaceOrientationMaskAllButUpsideDown:
            [self forceDeviceOrientation:[UIDevice currentDevice].orientation];
            break;
            
        case UIInterfaceOrientationMaskPortraitUpsideDown:
            break;
            
        default:
            break;
    }
    
    [UIViewController attemptRotationToDeviceOrientation];
}

- (void)forceDeviceOrientation: (UIDeviceOrientation)deviceOrientation {
    // 比如存在工具窗口时， 不要乱旋转了
    if ([self.view.window isKeyWindow]) {
        [[UIDevice currentDevice] setValue:@(deviceOrientation) forKey:@"orientation"];
    }
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

- (BOOL)prefersStatusBarHidden {
    return NO;
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
