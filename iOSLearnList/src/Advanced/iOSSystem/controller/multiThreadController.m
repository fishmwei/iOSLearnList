//
//  multiThreadController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/16.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "multiThreadController.h"


@interface multiThreadController()
{
    NSUInteger totalCount;
    UILabel *showLabel;
}
@end

@implementation multiThreadController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 200, 30)];
//    btn.center = self.view.center;
    [btn setTitle:@"newThread" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(createThread) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    
    showLabel = [[UILabel alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+5, self.view.frame.size.width, 200)];
    showLabel.numberOfLines = 0;
    [self.view addSubview:showLabel];
    showLabel.layer.borderWidth = 1;
    showLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    showLabel.layer.masksToBounds = YES;
    showLabel.layer.cornerRadius = 2;
}

- (void)createThread
{
    [NSThread detachNewThreadSelector:@selector(threadWithMaxNumber:) toTarget:self withObject:@(100)];
}


-(void)threadWithMaxNumber:(id)maxNumber
{
    for (;totalCount < [maxNumber unsignedIntegerValue];) {
        totalCount++;
        NSString *threadInfo = [NSString stringWithFormat:@"currentThread:%@", [NSThread currentThread]];
        
        [NSThread sleepForTimeInterval:1];
        [self performSelectorOnMainThread:@selector(printInfo:) withObject:threadInfo waitUntilDone:YES];
    }
    
    NSLog(@"thread exit");
}

- (void)printInfo:(id)object
{
    NSString *showStr = [NSString stringWithFormat:@"total:%ld, %@", totalCount, object];
    
    NSLog(@"%@", showStr);
    
    showLabel.text = showStr;
    
}

@end
