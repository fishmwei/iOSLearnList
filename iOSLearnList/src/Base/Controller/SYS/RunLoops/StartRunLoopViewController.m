//
//  StartRunLoopViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/31.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "StartRunLoopViewController.h"

@interface StartRunLoopViewController ()
@property (nonatomic, retain) NSThread *thread;
@end

@implementation StartRunLoopViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 100, 100, 30);
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(createNewThread) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createNewThread {
    
    if (!self.thread || [self.thread isFinished]) {
        self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain) object:nil];
        [self.thread start];
    }
    
}

- (void)threadMain
{
    // The application uses garbage collection, so no autorelease pool is needed.
    NSRunLoop* myRunLoop = [NSRunLoop currentRunLoop];
    
    // Create a run loop observer and attach it to the run loop.
    CFRunLoopObserverContext  context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    CFRunLoopObserverRef    observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                               kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    
    if (observer)
    {
        CFRunLoopRef    cfLoop = [myRunLoop getCFRunLoop];
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }
    
    // Create and schedule the timer.
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                   selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showLoadingTips];
    });
    NSInteger    loopCount = 10;
    do
    {
        // Run the run loop 10 times to let the timer fire.
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        loopCount--;
    }
    while (loopCount);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTextTips:@"thread exit"];
    });
}

void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSLog(@"observer my runloop %lx", activity);
}

- (void)doFireTimer:(id)sender {
    NSLog(@"doFireTimer");
}
@end
