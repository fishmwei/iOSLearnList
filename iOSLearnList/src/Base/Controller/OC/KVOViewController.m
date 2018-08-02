//
//  KVOViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "KVOViewController.h"
#import <Masonry/Masonry.h>


@interface KVOViewController ()
{
    UILabel *ll;
}

@property (nonatomic, retain) UILabel *lab;


@end


@implementation KVOViewController

@synthesize lab = ll;

- (void)dealloc
{
    //    [ll removeObserver:self forKeyPath:@"text"];
    [self removeObserver:self forKeyPath:@"lab.text"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];


    ll = [[UILabel alloc] init];
    [self.view addSubview:ll];
    ll.backgroundColor = [UIColor blueColor];
    ll.textColor = [UIColor whiteColor];

    [ll mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.width.mas_equalTo(self.view);
        mk.height.mas_equalTo(20);
        mk.top.mas_equalTo(20);
    }];


    [self addObserver:self forKeyPath:@"lab.text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    //    [ll addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];


    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [btn mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.top.mas_equalTo(ll.mas_bottom).mas_offset(20);
        mk.width.mas_equalTo(ll).mas_offset(-100);
        mk.centerX.mas_equalTo(self.view);
        mk.height.mas_equalTo(30);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnPressed
{
    ll.text = @"hello";
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *, id> *)change context:(void *)context
{
    if ([object isEqual:ll]) {
        [self showTextTips:@"change ll"];
    } else if ([keyPath isEqualToString:@"lab.text"]) {
        [self showTextTips:@"change self.lab.text"];
    }
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
