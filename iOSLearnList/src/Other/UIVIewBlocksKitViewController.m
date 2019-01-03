//
//  UIVIewBlocksKitViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "UIVIewBlocksKitViewController.h"
#import <BlocksKit/UIView+BlocksKit.h>


@implementation UIVIewBlocksKitViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.showData = @[@"UIVIewBlocksKitViewController"];

    [self setupData];
    [self setupUI];
}

- (void)setupData {
    __weak typeof(self) weakSelf = self;
    [self.view bk_whenTapped:^{
        [weakSelf.view endEditing:YES];
    }];

    [self.view bk_whenDoubleTapped:^{
        [weakSelf.view bk_eachSubview:^(UIView *v) {
            NSLog(@"class of subView:%@", NSStringFromClass([v class]));
        }];
    }];
}

- (void)setupUI {
    for (int i = 0; i < 3; i++) {
        UIView *v = [[UIView alloc] init];
        v.frame = CGRectMake(0, 80 * i, 60, 60);
        v.tag = i;
        [self.view addSubview:v];
        v.backgroundColor = [UIColor blueColor];
    }

    UITextView *t = [[UITextView alloc] init];
    t.frame = CGRectMake(100, 100, 100, 30);
    [self.view addSubview:t];
    t.backgroundColor = [UIColor orangeColor];
}

@end
