//
//  RunTimeViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2018/6/5.
//  Copyright © 2018年 fishmwei. All rights reserved.
//

#import "RunTimeViewController.h"
#import <objc/runtime.h>
#import <CSNotificationView/CSNotificationView.h>

@interface RunTimeViewController ()

@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *sV = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 60)];
    [sV setTitle:@"ShowMessage" forState:UIControlStateNormal];
    [sV setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:sV];
    [sV addTarget:self action:@selector(ShowMessage) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}


void PrintLogIMP(id self, SEL _cmd) {
    
    [CSNotificationView showInViewController:self
                                       style:CSNotificationViewStyleSuccess
                                     message:@"I am the message."];
    
 
}

+ (BOOL)resolveInstanceMethod:(SEL)aSEL
{
    if (aSEL == @selector(ShowMessage)) {
        class_addMethod([self class], aSEL, (IMP) PrintLogIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
