//
//  NSConditionLockViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/11/1.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "NSConditionLockViewController.h"

@interface NSConditionLockViewController ()
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, retain) NSConditionLock *countLock;
@property (nonatomic, retain) NSThread *readShow;

@property (nonatomic, retain) UILabel *showLabel;
@end

@implementation NSConditionLockViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 0;
    self.countLock = [[NSConditionLock alloc] initWithCondition:0];
    self.readShow = [[NSThread alloc] initWithTarget:self selector:@selector(showCountThread) object:nil];
    [self.readShow start];
    
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

- (void)showCountThread {
    while (true) {
        [self.countLock lockWhenCondition:1];
        [NSThread sleepForTimeInterval:3];
        NSLog(@"count is %lu", self.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showLabel.text = [@(self.count) stringValue];
        });
        [self.countLock unlockWithCondition:0];
    }
}

- (void)ShowCount {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.countLock lockWhenCondition:0];
        self.count++;
        [self.countLock unlockWithCondition:1];
    });
    
}
@end
