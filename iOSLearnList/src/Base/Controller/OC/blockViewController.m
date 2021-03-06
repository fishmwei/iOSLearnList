//
//  blockViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/11/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "blockViewController.h"
#import "blockObject.h"
#import <pthread/pthread.h>

@interface blockViewController ()
@property (nonatomic, retain) blockObject *bObj;

@end


@implementation blockViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;

    [btn setTitle:@"Press" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnPressed {
    blockObject *obj = [[blockObject alloc] init];
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    NSLog(@"1");
    [self testCallBack:^{
        NSLog(@"5");
        obj.a = 9999;
        NSLog(@"6");
        dispatch_semaphore_signal(sem);
    }];
    
    NSLog(@"7");
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"obj.a = %ld", obj.a);
    NSLog(@"8");
    
    
    __uint64_t threadId=0;
    
    if (pthread_threadid_np(0, &threadId)) {
        threadId = pthread_mach_thread_np(pthread_self());
    }
    
    NSLog(@"%ld:%llu",(long)getpid(),threadId);
}

- (void)testCallBack:(void (^)())test {
    NSLog(@"2");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"4");
        test();

    });
    NSLog(@"3");
}

@end
