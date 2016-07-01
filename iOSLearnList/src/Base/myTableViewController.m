//
//  myTableViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/18.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "myTableViewController.h"
#import <MWObjTools/MWNumberTools.h>

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

    cell.textLabel.text = [MWNumberTools stringOfFloat:43.102901f withDecimal:3];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
