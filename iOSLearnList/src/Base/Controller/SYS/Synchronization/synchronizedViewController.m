//
//  synchronizedViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/11/1.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "synchronizedViewController.h"

@interface synchronizedViewController ()
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, retain) NSThread *readShow;
@property (nonatomic, retain) NSThread *readShow1;

@property (nonatomic, retain) UILabel *showLabel;
@end

@implementation synchronizedViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.readShow cancel];
    [self.readShow1 cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 0;
    self.readShow = [[NSThread alloc] initWithTarget:self selector:@selector(showCountThread) object:nil];
    [self.readShow start];
    
    
    self.readShow1 = [[NSThread alloc] initWithTarget:self selector:@selector(showCountThread) object:nil];
    [self.readShow1 start];
    
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 30)];
    [self.view addSubview:self.showLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 200, 100, 30);
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ShowCount) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setExclusiveTouch:YES];
}

//不可重入代码
- (void)showCountThread {
    while (true) {
        @synchronized (self) {
            [NSThread sleepForTimeInterval:1];
            NSString *t = [NSString stringWithFormat:@"%@ count is %lu",[NSThread currentThread], self.count++];
            NSLog(@"%@",t);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.showLabel.text = t;
            });
        }
        
        if ([[NSThread currentThread] isCancelled]) {
            NSLog(@"thread break");
            break;
        }
    }
}

- (void)ShowCount {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            [NSThread sleepForTimeInterval:3];
            NSLog(@"count is %lu", self.count++);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.showLabel.text = [@(self.count) stringValue];
            });
        }
        
    });
    
}
@end
