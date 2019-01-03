//
//  CAMediaTimingVC.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "CAMediaTimingVC.h"
#import <Masonry/Masonry.h>


@interface CAMediaTimingVC ()
@property (nonatomic, retain) UIView *opView;
@property (nonatomic, retain) UITextField *durationField;
@property (nonatomic, retain) UITextField *countField;
@property (nonatomic, retain) UIButton *startButton;


@end


@implementation CAMediaTimingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _opView = [[UIView alloc] init];
    _opView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_opView];
    _opView.backgroundColor = [UIColor orangeColor];
    [_opView mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.center.mas_equalTo(self.view);
        mk.width.mas_equalTo(100);
        mk.height.mas_equalTo(200);
    }];

    _durationField = [[UITextField alloc] init];
    [_durationField setPlaceholder:@"duration"];
    _durationField.layer.borderWidth = 1;
    _durationField.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:_durationField];
    [_durationField mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.left.mas_equalTo(20);
        mk.right.equalTo(self.view.mas_centerX).mas_offset(-5);
        mk.top.mas_equalTo(_opView.mas_bottom).with.mas_offset(10);
        //        mk.width.mas_offset(100);
        mk.height.mas_offset(20);
    }];


    _countField = [[UITextField alloc] init];
    [_countField setPlaceholder:@"repeat"];
    _countField.layer.borderWidth = 1;
    _countField.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:_countField];
    [_countField mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.left.equalTo(self.view.mas_centerX).mas_offset(5);
        mk.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        mk.top.equalTo(_durationField.mas_top);
        mk.bottom.equalTo(_durationField.mas_bottom);
    }];


    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn mas_makeConstraints:^(MASConstraintMaker *mk) {
        mk.centerX.mas_equalTo(self.view.mas_centerX);
        mk.top.mas_equalTo(_countField.mas_bottom).mas_offset(20);
        mk.width.mas_equalTo(100);
        mk.height.mas_equalTo(20);
    }];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    _startButton = btn;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ResignTextField)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)start {
    CFTimeInterval duration = [self.durationField.text doubleValue];
    float repeat = [self.countField.text floatValue];

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = duration;
    animation.repeatCount = repeat;
    //    animation.repeatDuration = 10; //连续执行 这么久 s
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    //    animation.speed;

    //    animation.autoreverses = YES;
    //    _opView.layer.doubleSided = NO;
    _opView.layer.speed = 0.5;
    [_opView.layer addAnimation:animation forKey:@"rotation"];
    [self setControlsEnabled:NO];
}


- (void)ResignTextField {
    [self.view endEditing:YES];
}

- (void)setControlsEnabled:(BOOL)enabled {
    for (UIControl *control in @[ self.durationField, self.countField, self.startButton ]) {
        control.enabled = enabled;
        control.alpha = enabled ? 1.0f : 0.25f;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self setControlsEnabled:YES];
}

@end
