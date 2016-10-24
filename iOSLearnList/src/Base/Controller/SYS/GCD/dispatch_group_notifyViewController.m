//
//  dispatchGroupAsynViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "dispatch_group_notifyViewController.h"

@interface dispatch_group_notifyViewController () {
    dispatch_queue_t dispatchQueue;
    dispatch_group_t dispatchGroup;
    UITextView *showView;
}
@end

@implementation dispatch_group_notifyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupUI];

}

- (void)setupData {
    dispatchQueue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_CONCURRENT);
    dispatchGroup = dispatch_group_create();
}

- (void)setupUI {
    
    showView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    [self.view addSubview:showView];
//    showView.backgroundColor = [UIColor blueColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
           
            NSLog(@"dispatch-1");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAppend:@"dispatch-1"];
            });
        });
        
        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
            NSLog(@"dispatch-2");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAppend:@"dispatch-2"];
            });
            
        });
        
        dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
            NSLog(@"end");
                [self showAppend:@"end"];
            
        });
        
    });
    
}

- (void)showAppend:(NSString *)str {
    NSString *text = showView.text;
    showView.text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", str]];
    
}

@end
