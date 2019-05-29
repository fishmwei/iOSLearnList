//
//  SkyLabViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/5/29.
//  Copyright © 2019年 fishmwei. All rights reserved.
//

#import "SkyLabViewController.h"
#import <SkyLab/SkyLab.h>
#import <Masonry/Masonry.h>

@interface SkyLabViewController ()
@property (nonatomic, strong) UISwitch *oneS;
@property (nonatomic, strong) UISwitch *twoS;
@property (nonatomic, strong) UISwitch *threeS;

@end

@implementation SkyLabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [UILabel new];
    [self.navigationItem setTitleView:label];
    label.text = NSStringFromClass([self class]);
    
    [SkyLab splitTestWithName:@"titleColor" conditions:@{
                                                       @"Red" : @(0.15),
                                                       @"Green" : @(0.10),
                                                       @"Blue" : @(0.50),
                                                       @"Purple" : @(0.25)
                                                       } block:^(id choice) {
                                                           
                                                           UIColor *titleColor = [UIColor blackColor];
                                                           
                                                           if ([choice isEqualToString:@"Red"]) {
                                                               titleColor = [UIColor redColor];
                                                           } else if ([choice isEqualToString:@"Green"]) {
                                                               titleColor = [UIColor greenColor];
                                                           } else if ([choice isEqualToString:@"Blue"]) {
                                                               titleColor = [UIColor blueColor];
                                                           } else if ([choice isEqualToString:@"Purple"]) {
                                                               titleColor = [UIColor purpleColor];
                                                           }
                                                           
                                                           label.textColor = titleColor;
                                                       }];
    
    
    
    self.oneS = [UISwitch new];
    [self.view addSubview:self.oneS];
    [self.oneS mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.top.mas_equalTo(@(100));
        maker.height.mas_equalTo(@(20));
        maker.width.mas_equalTo(@(100));
        maker.left.mas_equalTo(@(16));
    }];
    
    self.twoS = [UISwitch new];
    [self.view addSubview:self.twoS];
    [self.twoS mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.top.mas_equalTo(@(130));
        maker.height.mas_equalTo(@(20));
        maker.width.mas_equalTo(@(100));
        maker.left.mas_equalTo(@(16));
    }];
    
    self.threeS = [UISwitch new];
    [self.view addSubview:self.threeS];
    [self.threeS mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.top.mas_equalTo(@(160));
        maker.height.mas_equalTo(@(20));
        maker.width.mas_equalTo(@(100));
        maker.left.mas_equalTo(@(16));
    }];
    
    
    [SkyLab multivariateTestWithName:@"Switches" variables:@{
                                                             @"Left" : @(0.5),
                                                             @"Center" : @(0.5),
                                                             @"Right" : @(0.5)
                                                             } block:^(NSSet *activeVariables) {
                                                                 self.oneS.on = [activeVariables containsObject:@"Left"];
                                                                 self.twoS.on = [activeVariables containsObject:@"Center"];
                                                                 self.threeS.on = [activeVariables containsObject:@"Right"];
                                                             }];
    
    
}

//- (UISwitch *)


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
