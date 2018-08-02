//
//  TimerObject.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/9/13.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "TimerObject.h"


@implementation TimerObject
- (void)dealloc
{
    [self cleanTimer];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(timerDoAction:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timerDoAction:(id)sender
{
    NSLog(@"timerDoAction ...");
}

- (void)cleanTimer
{
    [_timer invalidate];
    _timer = nil;
}


@end
