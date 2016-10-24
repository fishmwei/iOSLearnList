//
//  GCDViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "GCDViewController.h"

@implementation GCDViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showData = @[@"dispatch_barrierViewController",
                      @"dispatch_queueViewController",
                      @"dispatch_group_notifyViewController",
                      @"dispatch_group_waitViewController",
                      @"dispatch_semaphoreViewController"];
}
@end
