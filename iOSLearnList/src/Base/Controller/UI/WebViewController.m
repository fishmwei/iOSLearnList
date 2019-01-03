//
//  WebViewController.m
//  iOSLearnList
//
//  Created by mingwei on 2016/12/30.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "WebViewController.h"
#import <Masonry/Masonry.h>


@interface WebViewController ()
@property (nonatomic, retain) UIWebView *wbView;
@end


@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.width.equalTo(@100);
        mk.height.equalTo(@44);
        mk.centerX.equalTo(self.view.mas_centerX);
        mk.top.equalTo(@50);

    }];

    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(BtnPressed) forControlEvents:UIControlEventTouchUpInside];


    self.wbView = [[UIWebView alloc] init];
    [self.view addSubview:self.wbView];
    self.wbView.layer.borderWidth = 1;
    self.wbView.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.wbView mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.left.equalTo(self.view.mas_left);
        mk.right.equalTo(self.view.mas_right);
        mk.bottom.equalTo(self.view.mas_bottom);
        mk.top.equalTo(btn.mas_bottom).offset(20);

    }];
}

- (void)BtnPressed {
    static int i = 0;
    i++;
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    if (i % 2) {
        url = [NSURL URLWithString:@"http://www.qq.com"];
    }

    [self.wbView loadRequest:[NSURLRequest requestWithURL:url]];
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
