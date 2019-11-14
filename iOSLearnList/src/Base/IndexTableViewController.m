//
//  IndexTableViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/12.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "IndexTableViewController.h"


@implementation IndexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    
    if (!self.title && !self.navigationItem.title) {
        if ([[self class] respondsToSelector:@selector(cellTitle)]) {
            self.navigationItem.title =  [[self class] performSelector:@selector(cellTitle)];
        } else {
            self.navigationItem.title = NSStringFromClass([self class]);
        }
    }
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
 
}

- (void)viewSafeAreaInsetsDidChange {
}

- (void)backBtnPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *vcClassName = [self.showData objectAtIndex:indexPath.row];
    Class vcClass = NSClassFromString(vcClassName);
    
    
    if (vcClass && [vcClass respondsToSelector:@selector(cellTitle)]) {
        cell.textLabel.text = [vcClass performSelector:@selector(cellTitle)];
    } else {
        cell.textLabel.text = vcClassName;
    }
    


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self.showData objectAtIndex:indexPath.row];
    if ([className isKindOfClass:[NSString class]]) {
        Class cls = NSClassFromString(className);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cls) {
                UIViewController *vc = [[cls alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        });
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [UIViewController attemptRotationToDeviceOrientation];
//    if (![self shouldAutorotate])
//    {
//        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//
//        if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
//            [[UIDevice currentDevice] setValue:@(UIDeviceOrientationUnknown) forKey:@"orientation"];
//            [UIViewController attemptRotationToDeviceOrientation];
//
//            [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
//            [UIViewController attemptRotationToDeviceOrientation];
//        }
//    }
}

@end
