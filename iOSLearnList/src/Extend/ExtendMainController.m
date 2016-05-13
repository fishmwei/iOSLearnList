//
//  ExtendMainController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/13.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "ExtendMainController.h"

@interface ExtendMainController ()
@property (nonatomic, retain) NSArray *bottomItems;
@end

@implementation ExtendMainController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createData];
    [self createView];
    
}

- (void)createView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.bottomItems = @[@"UIViewController",
                         @"UIViewController",
                         @"UIViewController"];
    
    NSMutableArray *bottomControllers = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.bottomItems.count; i++) {
        NSString *str = [self.bottomItems objectAtIndex:i];
        Class cls = NSClassFromString(str);
        if (cls) {
            id vc = [[cls alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.tabBarItem.image = [[UIImage imageNamed:@"weibo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"weibo_touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [vc setTitle:str];
            nav.title = @"aaa";
//            [vc setTitle:str];
            [bottomControllers addObject:nav];
        }
    }
    
    self.viewControllers = bottomControllers;
    
    
    [self.navigationController.navigationBar setHidden:YES];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 20, 20)];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.tabBar setTintColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)createData
{
    
}


-(void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
