//
//  NSRecursiveLockViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/11/1.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "NSRecursiveLockViewController.h"


@interface NSRecursiveLockViewController ()

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, retain) NSRecursiveLock *countLock;
@property (nonatomic, retain) NSThread *readShow;
@property (nonatomic, retain) UILabel *showLabel;
@end


@implementation NSRecursiveLockViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.countLock = [[NSRecursiveLock alloc] init];

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


- (void)ShowCount {
    static NSInteger n = 0;
    n++;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.countLock lock];
        self.totalCount = 0;
        self.totalCount = [self calculateFromZeroTo:n];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showLabel.text = [NSString stringWithFormat:@"Sum from 1 to %lu is %@", n, [@(self.totalCount) stringValue]];
        });
        [self.countLock unlock];
    });
}

- (NSInteger)calculateFromZeroTo:(NSInteger)count {
    [self.countLock lock];
    if (count == 1) {
        [self.countLock unlock];
        return 1;
    }


    NSInteger ret = count + [self calculateFromZeroTo:count - 1];
    [self.countLock unlock];
    return ret;
}

@end
