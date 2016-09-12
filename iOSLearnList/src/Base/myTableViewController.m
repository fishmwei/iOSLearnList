//
//  myTableViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/18.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "myTableViewController.h"
#import <MWObjTools/MWNumberTools.h>
#import <MWMarqueeView/MWMarqueeView.h>

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

    
    MWMarqueeView *systemNoticeView = [[MWMarqueeView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    //        systemNoticeView.backgroundColor = ColorWithHexValue(0xfff8ca, 0.94f);
    [cell addSubview:systemNoticeView];
    
    systemNoticeView.autoScrollLabel.alwaysScroll = NO;
    systemNoticeView.autoScrollLabel.scrollSpeed = 30;
    //        systemNoticeView.marqueeViewDelegate = self;
    
    [systemNoticeView setFont:[UIFont systemFontOfSize:14]];
            systemNoticeView.autoScrollLabel.textColor = [UIColor redColor];
    
    //    self.systemNoticeView.hidden = YES;
    
    systemNoticeView.autoScrollLabel.text = @"Hello, every body! This is a marquee Demo, Just to use it. It's my pleasure! The animation will stop when you drag the view, resume when you drag end";
    
    cell.textLabel.text = [MWNumberTools stringOfFloat:43.102901f withDecimal:3];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
