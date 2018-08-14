//
//  dispatch_semaphoreViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "dispatch_semaphoreViewController.h"


@interface dispatch_semaphoreViewController ()
{
    dispatch_queue_t dispatchQueue;
    dispatch_group_t dispatchGroup;
    UITextView *showView;
}
@end


@implementation dispatch_semaphoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupData];

    [self setupUI];
}

- (void)setupData
{
    dispatchQueue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_CONCURRENT);
    dispatchGroup = dispatch_group_create();
}

- (void)setupUI
{
    showView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    [self.view addSubview:showView];
    showView.layer.borderWidth = 1;
    showView.layer.borderColor = [UIColor blueColor].CGColor;
    showView.text = @"Wait sem!";

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        __block int count = 0;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatchQueue, ^{
            count = 9;
            dispatch_semaphore_signal(sem);
        });

        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            showView.text = [NSString stringWithFormat:@"Wait come, Count == %d", count];
        });

    });
}

- (void)showAppend:(NSString *)str
{
    NSString *text = showView.text;
    showView.text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", str]];
}
@end
