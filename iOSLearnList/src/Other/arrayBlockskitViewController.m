//
//  arrayBlockskitViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "arrayBlockskitViewController.h"
#import <BlocksKit/NSArray+BlocksKit.h>

@implementation arrayBlockskitViewController
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    NSArray *numArray = @[@1, @2, @3];
    NSArray *strArray = @[@"1", @"2", @"3"];
    
    [numArray bk_each:^(id obj){
        NSLog(@"obj %@", obj);
    }];
    
    BOOL allGreate0 = [numArray bk_all:^BOOL(id obj){
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [obj integerValue] > 0;
        }
        
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *s = obj;
            return [s integerValue] > 0;
//            return [obj num]
        }
        
        return NO;
    }];
    
    NSLog(@"allGreate0 :%@", @(allGreate0));
    
    
    [strArray bk_apply:^(id obj){
        NSLog(@"bk_apply %@", obj);
    }];
    
    
    
}

- (void)setupUI {
     
}

@end
