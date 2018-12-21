//
//  RotateTestViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2018/12/21.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import "RotateTestViewController.h"

@interface RotateTestViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *tipView;


@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign) CGFloat circleAngle;



@end

@implementation RotateTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _bgView = [UIView new];
    [self.view addSubview:_bgView];
    _bgView.frame = CGRectMake(0, 0, width-50,width-50);
    _bgView.center = self.view.center;
    _bgView.backgroundColor  = [UIColor grayColor];
    self.view.backgroundColor = [UIColor whiteColor];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = (width-50.0f)/2.0f;
    
    //添加文字
    NSArray *_prizeArray = @[@"谢谢参与",@"一等奖",@"谢谢参与",@"二等奖",@"谢谢参与",@"三等奖",@"谢谢参与",@"特等奖"];
    
    for (int i = 0; i < 8; i ++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(_bgView.frame)/8,CGRectGetHeight(_bgView.frame)*3/5)];
        label.layer.anchorPoint = CGPointMake(0.5, 1.0);
        label.center = CGPointMake(CGRectGetHeight(_bgView.frame)/2, CGRectGetHeight(_bgView.frame)/2);
        label.text = [NSString stringWithFormat:@"%@", _prizeArray[i]];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:14];
        CGFloat angle = M_PI*2/8 * i;
        label.transform = CGAffineTransformMakeRotation(angle);
        [_bgView addSubview:label];
        
    }
    
    self.clickBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.clickBtn.frame = CGRectMake(0, 0, 200, 50);
    [self.view addSubview:self.clickBtn];
    self.clickBtn.center = self.view.center;
    
    [self.clickBtn setTitle:@"Go" forState:UIControlStateNormal];
    [self.clickBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.clickBtn addTarget:self action:@selector(clickBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 50)];
    [self.view addSubview:self.tipView];
    self.tipView.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.tipView.center = self.view.center;
    self.tipView.backgroundColor = [UIColor redColor];
    self.tipView.userInteractionEnabled = NO;
    // Do any additional setup after loading the view.
}

- (void)clickBtnPressed {
    NSLog(@"点击Go");
    
    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    
    //控制概率[0,80)
    NSInteger lotteryPro = arc4random()%80;
    //设置转圈的圈数
    NSInteger circleNum = 6;
    
    if (lotteryPro < 10) {
        _circleAngle = 0;
    }else if (lotteryPro < 20){
        _circleAngle = 45;
    }else if (lotteryPro < 30){
        _circleAngle = 90;
    }else if (lotteryPro < 40){
        _circleAngle = 135;
    }else if (lotteryPro < 50){
        _circleAngle = 180;
    }else if (lotteryPro < 60){
        _circleAngle = 225;
    }else if (lotteryPro < 70){
        _circleAngle = 270;
    }else if (lotteryPro < 80){
        _circleAngle = 315;
    }
    
    CGFloat perAngle = M_PI/180.0;
    
    NSLog(@"turnAngle = %ld",(long)_circleAngle);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:_circleAngle * perAngle + 360 * perAngle * circleNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_bgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"动画停止");
    NSString *title;
    if (_circleAngle == 0) {
        title = @"谢谢参与!";
    }else if (_circleAngle == 45){
        title = @"恭喜你，获得特等奖！";
    }else if (_circleAngle == 90){
        title = @"谢谢参与!";
    }else if (_circleAngle == 135){
        title = @"恭喜你，获得三等奖！";
    }else if (_circleAngle == 180){
        title = @"谢谢参与!";
    }else if (_circleAngle == 225){
        title = @"恭喜你，获得二等奖！";
    }else if (_circleAngle == 270){
        title = @"谢谢参与!";
    }else if (_circleAngle == 315){
        title = @"恭喜你，获得一等奖！";
    }
    
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];//UIAlertControllerStyleAlert视图在中央
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_bgView.layer removeAllAnimations];
        self.isAnimation = NO;
        
        // reset
        
//        NSString *str = [NSString stringWithFormat:
//                         @"https://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];//https在iTunes中找，这里的事件是前往手机端App store下载微信
//    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
//
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
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
