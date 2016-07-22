//
//  MasonryViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/22.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MasonryViewController.h"
#import <Masonry/Masonry.h>

@interface MasonryViewController ()
@property (nonatomic, retain) UIView *v1;
@property (nonatomic, retain) UILabel *lab1;
@property (nonatomic, retain) UIImageView *img1;


@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _v1 = [[UIView alloc] init];
    [self.view addSubview:_v1];
    _v1.backgroundColor = [UIColor lightGrayColor];
    [_v1 mas_makeConstraints:^(MASConstraintMaker *maker) {
//        maker.width.equalTo(self.view);
        maker.height.equalTo(@100);
        maker.topMargin.equalTo(self.view.mas_top).with.offset(80);
        maker.leftMargin.equalTo(self.view.mas_left).with.offset(20);
        maker.rightMargin.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    _lab1 = [[UILabel alloc] init];
    _lab1.backgroundColor = [UIColor orangeColor];
    _lab1.textColor = [UIColor whiteColor];
    [self.view addSubview:_lab1];
    _lab1.text = @"label";
    _lab1.textAlignment = NSTextAlignmentCenter;
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(_v1);
        maker.right.equalTo(_v1);
        maker.top.equalTo(_v1.mas_bottom).with.offset(5);
        maker.height.equalTo(@50);
    }];
    
    _img1 = [[UIImageView alloc] init];
    [self.view addSubview:_img1];
    _img1.backgroundColor = [UIColor darkGrayColor];
    [_img1 mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.top.equalTo(_lab1.mas_bottom);
        maker.leftMargin.equalTo(self.view.mas_left).with.offset(20);
//        maker.width.equalTo(self.view.mas_width);
        maker.width.equalTo(_v1);
        maker.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
