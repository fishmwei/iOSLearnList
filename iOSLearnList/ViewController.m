//
//  ViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/7.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "ViewController.h"
#import "IndexTableViewController.h"

#import "ExtendMainController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableview;
@property (nonatomic, retain) NSArray *showData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setTitle:@"分类"];
    [self.navigationItem setTitle:@"分类"];
    [self createData];
    [self createView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    self.showData = @[@"NSURLLearn", @"iOSSystem", @"ObjRelative"];
    
}

-(void)createView
{
    self.tabBarController.tabBar.hidden = NO;
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    //    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //没有数据不显示分割线
    [self.tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.view addSubview:self.tableview];
}


#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *subject = [self.showData objectAtIndex:indexPath.row];
    cell.textLabel.text = subject;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *subject = [self.showData objectAtIndex:indexPath.row];
    
    NSString *selectorStr = [@"goto" stringByAppendingString:subject];
    SEL selector = NSSelectorFromString(selectorStr);
    if ([self respondsToSelector:selector]) {
        [self performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma  mark - goto Function

-(void)gotoNSURLLearn
{
    IndexTableViewController *vc = [[IndexTableViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.showData = @[@"defaultNSURLSessionController", @"downloadController", @"NSURLConnectionController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)gotoiOSSystem
{
    IndexTableViewController *vc = [[IndexTableViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.showData = @[@"Timer_NotificationViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoObjRelative
{
    IndexTableViewController *vc = [[IndexTableViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.showData = @[@"undoRedoViewController", @"unRecognizeViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)gotoExtendMainController
//{
//    ExtendMainController *vc = [[ExtendMainController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}





@end
