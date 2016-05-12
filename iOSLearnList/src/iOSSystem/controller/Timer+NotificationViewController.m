//
//  Timer+NotificationViewController.m
//  test
//
//  Created by mingwei on 16/5/7.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "Timer+NotificationViewController.h"

@interface Timer_NotificationViewController ()

@property(nonatomic, retain) UILabel *showLabel;
@property (nonatomic, retain) NSTimer *showTimer;

@end

@implementation Timer_NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 20)];
    self.showLabel.textColor = [UIColor blueColor];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.showLabel];
    
    
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(show:) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHello:) name:@"testMsg" object:nil];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, CGRectGetMaxY(self.showLabel.frame), 200, 20);
    
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view.
}



-(void)show:(NSTimer *)timer
{
    static NSUInteger i = 0;
    
    i++;
    self.showLabel.text = [NSString stringWithFormat:@"%ldS", i];
}

- (void)sendMsg
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:@"testMsg" object:nil];
}

-(void)showHello:(NSNotification *)notification
{
    
    UIAlertView *al = [[UIAlertView alloc]  initWithTitle:@"hello" message:@"recv msg" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [al show];
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
