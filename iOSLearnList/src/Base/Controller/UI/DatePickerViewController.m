//
//  DatePickerViewController.m
//  iOSLearnList
//
//  Created by mingwei on 2016/10/16.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "DatePickerViewController.h"
#import <Masonry/Masonry.h>


@interface DatePickerViewController ()
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UIDatePicker *timePicker;
@end


@implementation DatePickerViewController
- (void)dealloc
{
    NSDate *date = self.datePicker.date;
    NSDate *time = self.timePicker.date;

    NSLog(@"date:%@", date);
    NSLog(@"time:%@", time);
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupData];
    [self setupUI];
}

- (void)setupData
{
}

- (void)setupUI
{
    UILabel *l0 = [[UILabel alloc] init];
    [self.view addSubview:l0];
    l0.frame = CGRectMake(0, 64, 200, 20);
    l0.text = @"请选择日期";
    l0.textAlignment = NSTextAlignmentCenter;
    l0.font = [UIFont boldSystemFontOfSize:18];
    [l0 mas_makeConstraints:^(MASConstraintMaker *maker) {

        maker.height.equalTo(@18);
        maker.top.equalTo(self.view.mas_top).with.offset(64);
        maker.left.equalTo(self.view.mas_left).with.offset(20);
        maker.right.equalTo(self.view.mas_right).with.offset(-20);
    }];


    [self.view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *maker) {

        maker.height.equalTo(@100);
        maker.top.equalTo(l0.mas_bottom).with.offset(10);
        maker.left.equalTo(self.view.mas_left).with.offset(20);
        maker.right.equalTo(self.view.mas_right).with.offset(-20);
    }];

    UILabel *l1 = [[UILabel alloc] init];
    [self.view addSubview:l1];
    l1.text = @"请选择时间";
    l1.textAlignment = NSTextAlignmentCenter;
    l1.font = [UIFont boldSystemFontOfSize:18];
    [l1 mas_makeConstraints:^(MASConstraintMaker *maker) {

        maker.height.equalTo(@18);
        maker.top.equalTo(self.datePicker.mas_bottom).with.offset(10);
        maker.left.equalTo(self.view.mas_left).with.offset(20);
        maker.right.equalTo(self.view.mas_right).with.offset(-20);
    }];


    [self.view addSubview:self.timePicker];
    [self.timePicker mas_makeConstraints:^(MASConstraintMaker *maker) {

        maker.height.equalTo(@100);
        maker.top.equalTo(l1.mas_bottom).with.offset(20);
        maker.left.equalTo(self.view.mas_left).with.offset(20);
        maker.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
    }

    return _datePicker;
}

- (UIDatePicker *)timePicker
{
    if (!_timePicker) {
        _timePicker = [[UIDatePicker alloc] init];
        _timePicker.datePickerMode = UIDatePickerModeTime;
        _timePicker.minuteInterval = 5;
        [_timePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
    }

    return _timePicker;
}

- (void)dateValueChanged:(id)sender
{
    if ([self.datePicker isEqual:sender]) {
        self.timePicker.date = self.datePicker.date;
    } else {
        self.datePicker.date = self.timePicker.date;
    }
}
@end
