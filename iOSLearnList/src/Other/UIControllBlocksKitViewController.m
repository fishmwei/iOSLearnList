//
//  UIControllBlocksKitViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "UIControllBlocksKitViewController.h"
#import <BlocksKit/UIControl+BlocksKit.h>
#import <BlocksKit/UIAlertView+BlocksKit.h>


@implementation UIControllBlocksKitViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor grayColor];
    [btn bk_addEventHandler:^(id sender) {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tip" message:@"btn pressed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];

        [UIAlertView bk_showAlertViewWithTitle:@"tip" message:@"btn pressed" cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];

    } forControlEvents:UIControlEventTouchUpInside];

    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(0, 200, 100, 30)];
    [self.view addSubview:sw];
    [sw bk_addEventHandler:^(id sender) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tip" message:@"switch value changed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } forControlEvents:UIControlEventValueChanged];
}

@end
