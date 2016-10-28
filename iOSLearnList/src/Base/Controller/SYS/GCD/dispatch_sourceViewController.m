//
//  dispatch_sourceViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "dispatch_sourceViewController.h"

@interface dispatch_sourceViewController () {
    dispatch_source_t timer;
    dispatch_source_t textSender;
    NSInteger count;
    NSTimer *countTimer;
    
    UITextField *textField;
    UIButton *btn;
    BOOL isRunning;
}
@property (nonatomic, retain) dispatch_queue_t concurrentQueue;
@end

//例子  http://blog.csdn.net/nogodoss/article/details/31346207

@implementation dispatch_sourceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    countTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addCount) userInfo:nil repeats:YES];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [countTimer invalidate];
    countTimer = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self setupUI];
    
}

- (void)addCount {
    count++;
}

- (void)setupData {
    
    self.concurrentQueue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_CONCURRENT);
  
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,  self.concurrentQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0.5 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
//        [NSThread sleepForTimeInterval:3];

        NSLog(@"count %ld", count);
    });
    dispatch_resume(timer);
    isRunning = YES;
    
    textSender = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, 0, 0, self.concurrentQueue);
    dispatch_source_set_event_handler(textSender, ^{
        size_t estimated = dispatch_source_get_data(textSender);
        
        
        
    });
    dispatch_resume(textSender);
}

- (void)setupUI {
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    textField.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:textField];
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 300, 200, 44);
    [btn setTitle:@"ToSuspend" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnPressed {
    if (isRunning) {
        dispatch_suspend(timer);
        [btn setTitle:@"ToResume" forState:UIControlStateNormal];
    } else {
        dispatch_resume(timer);
        [btn setTitle:@"ToSuspend" forState:UIControlStateNormal];
    }
    isRunning = !isRunning;
}

@end
