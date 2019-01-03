//
//  dispatch_group_waitViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "dispatch_group_waitViewController.h"


@implementation dispatch_group_waitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_queue_t dispatchQueue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(dispatchQueue, ^{
        [self setupData];
    });
}

- (void)setupData {
    dispatch_group_t dispatchGroup = dispatch_group_create();

    {
        dispatch_group_enter(dispatchGroup);

        NSLog(@"HELLO 0, %@", [NSThread currentThread]);

        dispatch_group_leave(dispatchGroup);
    }

    {
        dispatch_group_enter(dispatchGroup);

        long long sum = 0;
        for (NSInteger i = 0; i < 100000; i++) {
            sum += i;
        };
        NSLog(@"HELLO 1, %@, %llu", [NSThread currentThread], sum);

        //        dispatch_group_leave(dispatchGroup);
    }

    {
        dispatch_group_enter(dispatchGroup);

        long long sum = 0;
        for (NSInteger i = 0; i < 1600000; i++) {
            sum += i;
        }
        NSLog(@"HELLO 2, %@, %llu", [NSThread currentThread], sum);

        dispatch_group_leave(dispatchGroup);
    }


    //    dispatch_group_wait(dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC));
    dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);

    NSLog(@"end");
}

@end
