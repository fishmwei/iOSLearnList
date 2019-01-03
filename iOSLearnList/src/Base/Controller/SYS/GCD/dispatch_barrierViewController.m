//
//  dispatch_barrierViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "dispatch_barrierViewController.h"


@interface dispatch_barrierViewController ()
{
    dispatch_queue_t seralQueue;
    dispatch_queue_t concurrentQueue;
    dispatch_group_t dispatchGroup;
    UITextView *showView;
}
@end


@implementation dispatch_barrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupData];

    [self setupUI];
}

- (void)setupData {
    seralQueue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_SERIAL);
    concurrentQueue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_CONCURRENT);
}

- (void)setupUI {
    showView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    [self.view addSubview:showView];
    showView.layer.borderWidth = 1;
    showView.layer.borderColor = [UIColor blueColor].CGColor;
    showView.text = @"Wait sem!";

    dispatch_sync(seralQueue, ^{
        NSLog(@"excute in serial Queue");

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            for (int i = 0; i < 1; i++) {
                NSLog(@"global BACKGROUND");
            }

        });

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

            NSLog(@"global DISPATCH_QUEUE_PRIORITY_LOW");

        });

        dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSLog(@"global HIGH, barrier");
        });

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

            NSLog(@"global DISPATCH_QUEUE_PRIORITY_HIGH");


        });

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            NSLog(@"global DISPATCH_QUEUE_PRIORITY_DEFAULT");


        });

        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSLog(@"global start =========================================");
        });


        dispatch_async(concurrentQueue, ^{

            NSLog(@"concurrentQueue  0");


        });

        dispatch_async(concurrentQueue, ^{

            NSLog(@"concurrentQueue  1");


        });

        dispatch_barrier_async(concurrentQueue, ^{
            NSLog(@"concurrentQueue barrier");
        });


        dispatch_async(concurrentQueue, ^{

            NSLog(@"concurrentQueue  2");


        });

        dispatch_async(concurrentQueue, ^{

            NSLog(@"concurrentQueue  3");


        });

        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSLog(@"concurrentQueue start =========================================");
        });

    });

    NSLog(@"excute in main Queue");
}

- (void)showAppend:(NSString *)str {
    NSString *text = showView.text;
    showView.text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", str]];
}
@end
