//
//  PresentingPopoverViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/10.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "PresentingPopoverViewController.h"

@interface PresentingPopoverViewController () <UIPopoverPresentationControllerDelegate>
@property (nonatomic, retain) UIViewController *popViewController;
@property (nonatomic, retain) UIButton *btn;
@end
@implementation PresentingPopoverViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.btn];
    self.btn.backgroundColor = [UIColor orangeColor];
    self.btn.frame = CGRectMake(0, 64, 200, 44);
//    self.btn.center = self.view.center;
    [self.btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnPressed {
//    UIViewController *myPopoverViewController = [[UIViewController alloc] init];
//    myPopoverViewController.preferredContentSize = CGSizeMake(100, 200);
////    myPopoverViewController.view.backgroundColor = [UIColor blueColor];
//    
//    // Present the view controller using the popover style.
//    myPopoverViewController.modalPresentationStyle = UIModalPresentationPopover;
//    
//    
//    // Get the popover presentation controller and configure it.
//    UIPopoverPresentationController *presentationController =
//    [myPopoverViewController popoverPresentationController];
//    presentationController.delegate = self;
//    presentationController.backgroundColor = [UIColor whiteColor];
//    presentationController.permittedArrowDirections =
//    UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
//    presentationController.sourceView = self.btn;
//    presentationController.sourceRect = self.btn.bounds;
//    
//    [self presentViewController:myPopoverViewController animated: YES completion: nil];
    
    
    UIViewController *firstVC = [[UIViewController alloc] init];
    firstVC.modalPresentationStyle = UIModalPresentationPopover;
    firstVC.popoverPresentationController.sourceView = self.btn;  //rect参数是以view的左上角为坐标原点（0，0）
    firstVC.popoverPresentationController.sourceRect = self.btn.bounds; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    firstVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp; //箭头方向
    firstVC.popoverPresentationController.delegate = self;
    firstVC.preferredContentSize = CGSizeMake(100, 200);
    [self presentViewController:firstVC animated:YES completion:nil];
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}



@end
