//
//  HideTabController.m
//  iOSLearnList
//
//  Created by mingwei on 2018/8/1.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import "HideTabController.h"
#import <Masonry/Masonry.h>
#import "MyPresentViewController.h"

@interface HideTabController ()
@property (nonatomic, assign) BOOL isHidden;
@end

@implementation HideTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.isHidden = NO;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"hideTab" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hideTabbar) forControlEvents:UIControlEventTouchUpInside];
    
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"showTab" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showTabbar) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"goFirst" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goFirst) forControlEvents:UIControlEventTouchUpInside];
    
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 450, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 550, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"close" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(210, 550, 100, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"calcute" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(calcute) forControlEvents:UIControlEventTouchUpInside];
}

- (void)calcute {
    NSString *string = @"plugin://plugin/test";
    NSURL *url = [NSURL URLWithString:string];
    NSString *host = url.host;
    NSString *scheme = url.scheme;
    
//    NSError *error = NULL;
//    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:host options:0 error:&error];
//
//
//    NSRange range = [exp rangeOfFirstMatchInString:string
//                                           options:0
//                                             range:NSMakeRange(scheme.length, string.length-scheme.length)];
    
    NSRange range = [string rangeOfString:host options:0 range:NSMakeRange(scheme.length, string.length - scheme.length)];
    NSLog(@"%@", NSStringFromRange(range));
    NSString *replaceString = [@"hello.prefix" stringByAppendingPathExtension:host];
    NSString *result = [string stringByReplacingCharactersInRange:range withString:replaceString ];
    
    NSLog(@"%@", result);
    // 正则匹配， 获取首个
    
}

- (void)hideTabbar {
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.isHidden = YES;
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    [self.view setNeedsLayout];
    
    
}

- (void)showTabbar {
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.isHidden = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.view setNeedsLayout];
}

- (void)goFirst {
    UITabBarController *vc = self.tabBarController;
    if (vc) {
        [vc setSelectedIndex:0];
    }
}

- (void)push {
    MWBaseViewController *vc = [MWBaseViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)present {
    HideTabController *vc = [HideTabController new];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isHidden) {
        [self hideTabbar];
    } else {
        [self showTabbar];
    }
}

- (void)close {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.tabBarController) {
        if (self.navigationController && [self isEqual:self.navigationController.viewControllers[0]]) {
            if (self.navigationController.viewControllers.count > 1) {
                self.tabBarController.tabBar.hidden = YES;
                
            } else if (self.navigationController.viewControllers.count == 1) { // 切tab
                if (self.presentedViewController) { //presented 另一个controller， 不变
                    
                } else {
                    self.tabBarController.tabBar.hidden = NO;
                }
            }
        }
    }
    
    
//    if (self.tabBarController
//        && self.navigationController
//        && [self isEqual:self.navigationController.topViewController]
//        && self.navigationController.viewControllers.count == 1) {
//        //返回上一页 不操作
//        if (self.movingFromParentViewController) {
//
//        } else if (self.beingDismissed) {
//
//        } else if (self.presentedViewController) {
//
//        } else {
//            self.tabBarController.tabBar.hidden = NO;
//        }
//
//    }
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}





@end
