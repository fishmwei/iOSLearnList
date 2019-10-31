//
//  HideNavigatorViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/4/12.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "HideNavigatorViewController.h"
#import "UIViewController+MWUtils.h"

@interface HideNavigatorViewController () <UIPageViewControllerDelegate>


@property (nonatomic, assign) BOOL isNextNavigationBarHidden;

@property (nonatomic, assign) BOOL isFirstInto;
@property (nonatomic, assign) BOOL isFirstOut;
@property (nonatomic, assign) BOOL isNavigaitonBarHiddenDismissed;

@property (nonatomic, assign) BOOL backupNavigateBarHiddenStatus;      // 保持一份打开本页面前的NavigateBar显隐状态，意在退出后恢复
@property (nonatomic, assign) BOOL firstBackupNavigateBarHiddenStatus; // 是否第一次执行NavigateBar显隐状态的保持

@end


@implementation HideNavigatorViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isFirstInto = YES;
        self.isFirstOut = YES;
        self.isNextNavigationBarHidden = NO;
        self.isNavigaitonBarHiddenDismissed = NO;
        self.hideNavigationbar = YES;
    }

    return self;
}

- (void)loadView {
    [super loadView];

    UIButton *prev = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    [prev setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [prev setTitle:@"Prev" forState:UIControlStateNormal];
    [self.view addSubview:prev];
    [prev addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];

    UIButton *nextHide = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 44)];
    [nextHide setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextHide setTitle:@"NextHide" forState:UIControlStateNormal];
    [self.view addSubview:nextHide];
    [nextHide addTarget:self action:@selector(goNextHide) forControlEvents:UIControlEventTouchUpInside];

    UIButton *nextShow = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 44)];
    [nextShow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextShow setTitle:@"NextShow" forState:UIControlStateNormal];
    [self.view addSubview:nextShow];
    [nextShow addTarget:self action:@selector(goNextShow) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goNextHide {
    HideNavigatorViewController *VC = [[HideNavigatorViewController alloc] init];
 
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)goNextShow {
    UIViewController *next = [[UIViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isFirstInto) {
        self.isFirstInto = NO;
        [self.navigationController setNavigationBarHidden:self.hideNavigationbar animated:NO];
    } else {
        [self.navigationController setNavigationBarHidden:self.hideNavigationbar animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (self.movingFromParentViewController) {
        [self.navigationController setNavigationBarHidden:self.previousNavigationBarHidden animated:animated];
    } else {
        [self.navigationController setNavigationBarHidden:self.isNextNavigationBarHidden animated:animated];
    }

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];


    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];

    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // µ±µ±Ç°¿ØÖÆÆ÷ÊÇ¸ù¿ØÖÆÆ÷Ê±£¬²»¿ÉÒÔ²à»¬·µ»Ø£¬ËùÒÔ²»ÄÜÊ¹Æä´¥·¢ÊÖÊÆ
    if (self.navigationController.childViewControllers.count == 1) {
        return NO;
    }

    return YES;
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
