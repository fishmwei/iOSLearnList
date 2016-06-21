//
//  myTableViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/18.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "myTableViewController.h"

@interface myTableViewController ()

@end

@implementation myTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.navigationItem setTitle:@"myTableViewController"];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(xie)];
    
//   self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action: @selector(xie)];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(xie)];
    
    self.navigationItem.leftBarButtonItem = item;
    
    
    // Do any additional setup after loading the view.
}

-(void)xie
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        
    }
//    cell.backgroundColor = [UIColor blueColor];
    cell.textLabel.text = [self stringOfFloat:43.100001f withDecimal:3];
    
    
    return cell;
}


+ (NSString *)stringOfFloat:(CGFloat)value withDecimal:(NSUInteger)num
{
    //
    if (fmod(value, 1.0f) < 0.000001)
    {
        return [NSString stringWithFormat:@"%.0f",value];
    }
    
    NSString *format = [NSString stringWithFormat:@"%%0.%df", num];
    
    NSString *lastStr = [NSString stringWithFormat:format, value];
    
    NSString *endStr = [lastStr substringFromIndex:[lastStr length] - 1];
    while ([endStr isEqualToString:@"0"]) {
        endStr = [lastStr substringToIndex:[lastStr length] - 1];
        endStr = [lastStr substringFromIndex:[lastStr length] - 1];
    }
    
    return lastStr;
}



-(NSString *)formatFloatNum:(float )value
{
    if(fmodf(value, 1.0f) < 0.000001)//小数位数为0
    {
        return [NSString stringWithFormat:@"%.0f",value];
    }
    else if(fmodf(value*10, 1) < 0.000001)//小数位数为1
    {
        return [NSString stringWithFormat:@"%.1f",value];
    }
    else//小数位数大于等于2
    {
        return [NSString stringWithFormat:@"%.2f",value];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(NSString *)stringWithoutEndZeroFromFloat:(CGFloat)value{
    NSString *string = nil;
    
    NSInteger intValue = (NSInteger)value;
    CGFloat decimalValue = value - intValue;
    
    if (decimalValue > -0.000001 && decimalValue < 0.000001) {
        //如果小数部分为0，则只返回整数部分
        string = [NSString stringWithFormat:@"%ld", (long)intValue];
    }
    else {
        string = [NSString stringWithFormat:@"%f", value];
        
        NSString *endStr = [string substringFromIndex:[string length] - 1];
        while ([endStr isEqualToString:@"0"]) {
            string = [string substringToIndex:[string length] - 1];
            endStr = [string substringFromIndex:[string length] - 1];
        }
    }
    
    
    return string;
}

- (NSString *)stringOfFloat:(CGFloat)value withDecimal:(NSUInteger)num
{
    NSString *format = [NSString stringWithFormat:@"%%0.%df", num];
    NSString *originalStr = [NSString stringWithFormat:format, value];
    
    return [self stringWithoutEndZeroFromFloat:[originalStr doubleValue]];
}



@end
