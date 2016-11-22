//
//  display_applyViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "display_applyViewController.h"

@interface display_applyViewController () {
    dispatch_queue_t seralQueue;
    dispatch_queue_t concurrentQueue;
    dispatch_group_t dispatchGroup;
    UITextView *showView;
}
@end

@implementation display_applyViewController

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
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 10000; i++) {
        [array addObject:[NSString stringWithFormat:@"%ld", i]];
    }
//    NSArray *array = @[@"0", @"1", @"2", @"3", @"4"];
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"excute in serial Queue");
        
        dispatch_apply(array.count, concurrentQueue, ^(size_t t){
            NSLog(@"data is %@, thread %@", array[t], [NSThread currentThread]);
        });
        
        NSLog(@"excute in serial Queue Done");
    });
    
    NSLog(@"excute in main Queue");
}

- (void)showAppend:(NSString *)str {
    NSString *text = showView.text;
    showView.text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", str]];
    
}
@end
