//
//  PalindromeViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/9/4.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "PalindromeViewController.h"
#import <Masonry/Masonry.h>
#import "NSString+MWUtils.h"

@interface PalindromeViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *contenField;


@end

@implementation PalindromeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.contenField = [[UITextField alloc] init];
    self.contenField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.contenField.backgroundColor = [UIColor lightGrayColor];
    self.contenField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:self.contenField];
    
    [self.contenField mas_makeConstraints:^(MASConstraintMaker *maker) {
 
        maker.top.equalTo(self.view.mas_top).offset(100);
        maker.height.equalTo(@40);
        maker.left.equalTo(self.view.mas_left).offset(15);
        maker.right.equalTo(self.view.mas_right).offset(-15);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPress) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Check" forState:UIControlStateNormal];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *maker) {
        
        maker.top.equalTo(self.contenField.mas_top).offset(50);
        maker.width.mas_equalTo(self.contenField);
        maker.height.equalTo(@40);
        maker.centerX.mas_equalTo(self.contenField);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    
}

- (void)onTap {
    [self.view endEditing:YES];
}

- (void)onPress {
    NSString *text = [self.contenField.text isPalindromeI] ? @"Is palindrome":@"Is not palindrome";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:text preferredStyle:UIAlertControllerStyleAlert];
    
    //取消按钮
    UIAlertAction *CancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:CancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
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
