//
//  HideNavigatorViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/4/12.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "HideNavigatorViewController.h"

@interface HideNavigatorViewController ()
@property (nonatomic, assign) BOOL isOriginalNavigationBarHidden;
@property (nonatomic, assign) BOOL isNextNavigationBarHidden;

@property (nonatomic, assign) BOOL isFirstInto;
@property (nonatomic, assign) BOOL isFirstOut;
@property (nonatomic, assign) BOOL isNavigaitonBarHiddenDismissed;

@property (nonatomic, assign) BOOL backupNavigateBarHiddenStatus;           // 保持一份打开本页面前的NavigateBar显隐状态，意在退出后恢复
@property (nonatomic, assign) BOOL firstBackupNavigateBarHiddenStatus;      // 是否第一次执行NavigateBar显隐状态的保持

@end

@implementation HideNavigatorViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isFirstInto = YES;
        self.isFirstOut = YES;
        self.isNextNavigationBarHidden = YES;
        self.isNavigaitonBarHiddenDismissed = NO;
        self.hideNavigationbar = YES;
    }
    
    return self;
}
- (void)loadView {
    [super loadView];
    if (self.isFirstInto) {
        self.isOriginalNavigationBarHidden = self.navigationController.navigationBarHidden;
    }
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

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
