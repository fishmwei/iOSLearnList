//
//  NSURLParseViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/11/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "NSURLParseViewController.h"

@interface NSURLParseViewController () <UITextFieldDelegate>

@property (nonatomic, retain) UITextField *urlField;
@property (nonatomic, retain) UILabel *schemeLabel;
@property (nonatomic, retain) UILabel *hosteLabel;
@property (nonatomic, retain) UILabel *portLabel;
@property (nonatomic, retain) UILabel *pathLabel;
@property (nonatomic, retain) UILabel *lastComponentLabel;
@property (nonatomic, retain) UILabel *queryLabel;
@end

@implementation NSURLParseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
}

- (void)setupData {
    
}

- (void)setupUI {
    CGFloat offsetX = 0;
    CGFloat offsetY = 100;
    
    _urlField = [[UITextField alloc] initWithFrame:CGRectMake(offsetX, offsetY, screenWidth, 30)];
    [self.view addSubview:_urlField];
    _urlField.placeholder = @"place holder";
    _urlField.delegate = self;
    _urlField.returnKeyType = UIReturnKeyDone;
    _urlField.autocorrectionType = UITextAutocorrectionTypeNo;
    _urlField.layer.borderWidth = 1;
    _urlField.layer.borderColor = [UIColor orangeColor].CGColor;
    offsetY += 30;
    
    _schemeLabel = [self labelWithFrame:CGRectMake(offsetX, offsetY, screenWidth, 20)];
    offsetY += 20;
    _hosteLabel = [self labelWithFrame:CGRectMake(offsetX, offsetY, screenWidth, 20)];
    offsetY += 20;
    _portLabel = [self labelWithFrame:CGRectMake(offsetX, offsetY, screenWidth, 20)];
    offsetY += 20;
    _pathLabel = [self labelWithFrame:CGRectMake(offsetX, offsetY, screenWidth, 20)];
    offsetY += 20;
    _lastComponentLabel = [self labelWithFrame:CGRectMake(offsetX, offsetY, screenWidth, 20)];
    offsetY += 20;
    _queryLabel = [self labelWithFrame:CGRectMake(offsetX, offsetY, screenWidth, 20)];
    offsetY += 20;
    
}

- (UILabel *)labelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:label];
    
    return label;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self fillData:textField.text];
}

- (void)fillData:(NSString *)text {
    if (!text.length) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:text];
    _schemeLabel.text = [NSString stringWithFormat:@"scheme: %@", url.scheme];
    _hosteLabel.text = [NSString stringWithFormat:@"host: %@", url.host];
    _portLabel.text = [NSString stringWithFormat:@"port: %@", url.port];
    _pathLabel.text = [NSString stringWithFormat:@"path: %@", url.path];
    _lastComponentLabel.text = [NSString stringWithFormat:@"lastComponent: %@", url.lastPathComponent];
    _queryLabel.text = [NSString stringWithFormat:@"query: %@", url.query];
    
    
}

@end
