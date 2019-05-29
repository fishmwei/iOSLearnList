//
//  LottieViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/5/28.
//  Copyright © 2019年 fishmwei. All rights reserved.
//

#import "LottieViewController.h"
#import <Lottie/Lottie.h>

@interface LottieViewController ()

@end

@implementation LottieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LOTAnimationView *v = [LOTAnimationView animationNamed:@"data"];
    [self.view addSubview:v];
    
    [v playWithCompletion:^(BOOL animationFinished) {
//        [displayLink invalidate];
//        [self resetButton:button highlighted:NO];
    }];
}


- (void)palyAnimation: (LOTAnimationView *)v {
    [v playWithCompletion:^(BOOL finished) {
        [self palyAnimation:v];
    }];
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
