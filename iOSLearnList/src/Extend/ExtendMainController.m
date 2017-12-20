//
//  ExtendMainController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/13.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "ExtendMainController.h"
#import "IndexTableViewController.h"
#import "ConfigCommon.h"

#import "BaseMainViewController.h"
#import "AdvancedViewController.h"
#import "MWNavigationController.h"

@interface ExtendMainController ()
@property (nonatomic, retain) NSArray *bottomItems;


@property (nonatomic, retain) UIViewController *advanceCtl;
@property (nonatomic, retain) UIViewController *baseCtl;
@property (nonatomic, retain) UIViewController *otherCtl;
@property (nonatomic, retain) UIViewController *testCtl;

@end

@implementation ExtendMainController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self createData];
    [self createView];
    [self procShortItem:nil];
    
//    [self setSelectedIndex:1];
}


- (void)createViewControllers
{
    AdvancedViewController *vc = [[AdvancedViewController alloc] init];
    vc.hideNavigationbar = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.image = [[MWCommon imageNamed:@"weibo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[MWCommon imageNamed:@"weibo_touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [vc setTitle:@"分类"];
    nav.tabBarItem.title = NSLocalizedStringFromTable(@"Advance", @"myLanguage", nil);
    _advanceCtl = nav;
    
    
    IndexTableViewController *ivc = [[BaseMainViewController alloc] init];
//    ivc.showData = @[@"UIBaseViewController", @"SysBaseViewController", @"ObjBaseViewController"];
    
    
    nav = [[MWNavigationController alloc] initWithRootViewController:ivc];
    nav.tabBarItem.image = [[MWCommon imageNamed:@"weibo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[MWCommon imageNamed:@"weibo_touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.title = NSLocalizedStringFromTable(@"Base", @"myLanguage", nil);
    _baseCtl = nav;
    
    ivc = [[IndexTableViewController alloc] init];
    ivc.showData = @[@"SDWebImageViewExp",
                     @"MasonryExp",
                     @"BlocksKitExp",
                     @"libextobjcExp",
                     @"YTKKeyValueStoreExp",
                     @"MantleExp",
                     @"M13OrderedDictionaryExp"];
    nav = [[UINavigationController alloc] initWithRootViewController:ivc];
    nav.tabBarItem.image = [[MWCommon imageNamed:@"weibo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[MWCommon imageNamed:@"weibo_touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [ivc setTitle:[[ConfigCommon shareInstance] currentConfig]];
    _otherCtl = nav;
    
    ivc = [[IndexTableViewController alloc] init];
    ivc.showData = @[@"TestCreateObjectAsync", @"AdaptIOS11ViewController",
                     @"AutoSizeViewController"];
    
    nav = [[UINavigationController alloc] initWithRootViewController:ivc];
    nav.tabBarItem.image = [[MWCommon imageNamed:@"weibo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[MWCommon imageNamed:@"weibo_touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [ivc setTitle:@"Test"];
    _testCtl = nav;
    
}




- (void)createView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createViewControllers];
    
    self.bottomItems = @[_testCtl, _baseCtl, _advanceCtl, _otherCtl];
    
//    NSMutableArray *bottomControllers = [NSMutableArray array];
//    for (NSUInteger i = 0; i < self.bottomItems.count; i++) {
//        NSString *str = [self.bottomItems objectAtIndex:i];
//        Class cls = NSClassFromString(str);
//        if (cls) {
//            id vc = [[cls alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            nav.tabBarItem.image = [[UIImage imageNamed:@"weibo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"weibo_touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            
//            
//            
//            [vc setTitle:str];
//            nav.title = @"aaa";
////            [vc setTitle:str];
//            [bottomControllers addObject:nav];
//        }
//    }
    
    self.viewControllers = self.bottomItems ;
    
    
//    [self.navigationController.navigationBar setHidden:YES];
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 20, 20)];
//    [btn setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.tabBar setTintColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
    
//    [[NSUserDefaults standardUserDefaults] setObject:shortcutItem.type forKey:@"ShortCut"];
//    [self procShortItem];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)procShortItem : (NSNotification *)notification{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShortCut"];
    if (str.length) {
        if ([str isEqualToString:@"Base"]) {
            [self setSelectedIndex:0];
        } else if ([str isEqualToString:@"Advance"]) {
            [self setSelectedIndex:1];
        } else if ([str isEqualToString:@"More"]) {
            [self setSelectedIndex:2];
        }
    }
}

- (void)createData
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(procShortItem:) name:@"MWShortCutClick" object:nil];
}


-(void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
