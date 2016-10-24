//
//  dispatch_queueViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "dispatch_queueViewController.h"



@interface dispatch_queueViewController () {
    dispatch_queue_t seralQueue;
    dispatch_queue_t concurrentQueue;
    dispatch_group_t dispatchGroup;
    UITextView *showView;
}
@end

@implementation dispatch_queueViewController

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
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        for (int i = 0; i < 500; i++) {
//            dispatch_async(seralQueue, ^{
//                NSLog(@"serial %d %@", i, [NSThread currentThread]);
//            });
//        }
//        
//        dispatch_async(seralQueue, ^{
//            for (int j = 0; j < 500; j++) {
//                dispatch_async(concurrentQueue, ^{
//                    NSLog(@"concurrent %d %@", j, [NSThread currentThread]);
//                });
//            }
//        });
//        
//    });
    
    dispatch_async(seralQueue, ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            for (int i = 0; i < 1; i++) {
                NSLog(@"global BACKGROUND");
            }
        
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

                NSLog(@"global DISPATCH_QUEUE_PRIORITY_LOW");
            
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
        
    });
}

- (void)showAppend:(NSString *)str {
    NSString *text = showView.text;
    showView.text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", str]];
    
}
@end
