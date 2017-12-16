//
//  AdaptIOS11ViewController.m
//  iOSLearnList
//
//  Created by mingwei on 2017/12/16.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "AdaptIOS11ViewController.h"
#import <Masonry/Masonry.h>

@interface AdaptIOS11ViewController ()
@property (nonnull, nonatomic) UIScrollView *scrollView;
@end

@implementation AdaptIOS11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideNavigationbar = YES;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:scrollView];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    if (@available(iOS 11.0, *)) {
//        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(-64, 0, 0, 0);
        
    }
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    scrollView.backgroundColor = [UIColor redColor];
    
    UIView *s = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 100, 1000)];
    s.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:s];
    
    [scrollView setContentSize:CGSizeMake(100, 1020)];
    scrollView.bounces = YES;
    self.navigationController.navigationBar.translucent = YES;
    
    
    self.scrollView = scrollView;
//    scrollView.safeAreaInsets = UIEdgeInsetsMake(0, 0, 100, 0);
    
//    //只有autolayout 有用？
//    UIView *v = [UIView new];
//    v.frame = self.view.bounds;
//    v.backgroundColor = [UIColor redColor];
//    v.directionalLayoutMargins  = NSDirectionalEdgeInsetsMake(10, 20, 30, 40);
//
//
//    UIView *subV = [UIView new];
//    subV.backgroundColor = [UIColor yellowColor];
//
//    [v addSubview:subV];
//    [subV mas_makeConstraints:^(MASConstraintMaker *maker) {
//        maker.edges.equalTo(v);
//    }];
//
//
//    [self.view addSubview:v];
    
    
//    self.additionalSafeAreaInsets = UIEdgeInsetsMake(100, 0, 0, 100);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    
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
