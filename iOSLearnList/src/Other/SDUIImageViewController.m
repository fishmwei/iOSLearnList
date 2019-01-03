//
//  SDUIImageViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/15.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "SDUIImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface SDUIImageViewController () <UITextFieldDelegate>
@property (nonatomic, retain) UITextField *urlField;
@property (nonatomic, retain) UIImageView *showImgView;

@end


@implementation SDUIImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createView {
    self.view.backgroundColor = [UIColor lightGrayColor];

    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;


    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    label.text = @"ImageUrl:";
    [self.view addSubview:label];

    _urlField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), self.view.frame.size.width, 20)];
    [self.view addSubview:_urlField];
    _urlField.delegate = self;
    _urlField.layer.borderWidth = 1;
    _urlField.layer.borderColor = [UIColor orangeColor].CGColor;
    _urlField.text = @"http://img1.imgtn.bdimg.com/it/u=2262120209,4171578012&fm=21&gp=0.jpg";

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_urlField.frame), self.view.frame.size.width, 20)];
    btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"Press Me" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];


    _showImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), self.view.frame.size.width, self.view.frame.size.height - 70 - 64)];
    [self.view addSubview:_showImgView];
    _showImgView.image = [MWCommon imageNamed:@"wait"];
}


#pragma mark Action
- (void)clickView {
    [self.view endEditing:YES];
}

- (void)showImage {
    NSURL *url = [[NSURL alloc] initWithString:_urlField.text];

    [_showImgView sd_setImageWithURL:url placeholderImage:[MWCommon imageNamed:@"wait"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _showImgView.image = image;
    }];
}


#pragma mark delegate
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder]; //查一下resign这个单词的意思就明白这个方法了
    return YES;
}
@end
