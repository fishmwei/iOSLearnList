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
//        maker.topMargin.equalTo(self.view.mas_top).with.offset(80);
//        maker.leftMargin.equalTo(self.view.mas_left).with.offset(20);
//        maker.rightMargin.equalTo(self.view.mas_right).with.offset(-20);
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
//        maker.leftMargin.equalTo(self.view.mas_left).with.offset(20);
//        maker.width.equalTo(self.view.mas_width);
        maker.width.equalTo(_v1);
        maker.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:centerView];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *maker) {
//        maker.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 100)]);
        maker.size.mas_equalTo(CGSizeMake(300, 300));
        maker.center.equalTo(self.view);
    }];
    
    
    UIView *sv1 = [UIView new];
    sv1.backgroundColor = [UIColor redColor];
    [centerView addSubview:sv1];
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(centerView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
     
    
    UIView *sv = centerView;
    
    int padding1 = 10;
    
    UIView *sv2 = [UIView new];
    sv2.backgroundColor = [UIColor blackColor];
    UIView *sv3 = [UIView new];
    sv3.backgroundColor = [UIColor blackColor];
    
    [sv addSubview:sv2];
    [sv addSubview:sv3];
    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sv.mas_centerY);
        make.left.equalTo(sv.mas_left).with.offset(padding1);
        make.right.equalTo(sv3.mas_left).with.offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(sv3);
    }];
    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sv.mas_centerY);
        make.left.equalTo(sv2.mas_right).with.offset(padding1);
        make.right.equalTo(sv.mas_right).with.offset(-padding1);
        make.height.mas_equalTo(150);
        make.width.equalTo(sv2);
    }];
    
    {
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.backgroundColor = [UIColor whiteColor];
        [sv addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5,5,5,5));
        }];
        UIView *container = [UIView new];
        [scrollView addSubview:container];
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.width.equalTo(scrollView);
        }];
        int count = 10;
        UIView *lastView = nil;
        for ( int i = 1 ; i <= count ; ++i )
        {
            UIView *subv = [UIView new];
            [container addSubview:subv];
            subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                              saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                              brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                   alpha:1];
            
            [subv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(container);
                make.height.mas_equalTo(@(20*i));
                
                if ( lastView )
                {
                    make.top.mas_equalTo(lastView.mas_bottom);
                }
                else
                {
                    make.top.mas_equalTo(container.mas_top);
                }
            }];
            
            lastView = subv;
        }
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.mas_bottom);
        }];
    }
    
    
    
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
