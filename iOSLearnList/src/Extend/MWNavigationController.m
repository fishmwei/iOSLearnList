//
//  MWNavigationController.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/4/12.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "MWNavigationController.h"
#import "AutorotateViewController.h"
#import "MWNavigationProtocol.h"
#import "UIViewController+MWUtils.h"

@interface MWNavigationController () <UIGestureRecognizerDelegate>

@end


@implementation MWNavigationController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.enabled = YES;
    //    self.interactivePopGestureRecognizer.delegate = self;

    //    id target = self.interactivePopGestureRecognizer.delegate;
    //
    //    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    //    pan.delegate = self;
    //    [self.view addGestureRecognizer:pan];
    //    self.interactivePopGestureRecognizer.enabled = NO;

    // Do any additional setup after loading the view.
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
- (BOOL)shouldAutorotate {
    if (self.viewControllers && [self.viewControllers count] > 0) {
        return [self.topViewController shouldAutorotate];
    }

    return [super shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.viewControllers && [self.viewControllers count] > 0) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    
    return [super supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (self.viewControllers && [self.viewControllers count] > 0) {
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    
    return [super preferredInterfaceOrientationForPresentation];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0 && self.topViewController) {
        if ([self.topViewController conformsToProtocol:@protocol(MWNavigationProtocol)]) {
            id <MWNavigationProtocol> vc = (id <MWNavigationProtocol>)self.topViewController;
            [vc processOrientationWhenPushViewController:viewController];
        }
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    viewController.previousNavigationBarHidden = self.navigationBarHidden;
    
    [super pushViewController:viewController animated:animated];
}


- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {

    if (self.viewControllers.count > 0 && self.topViewController) {
        if ([self.topViewController conformsToProtocol:@protocol(MWNavigationProtocol)]) {
            id <MWNavigationProtocol> vc = (id <MWNavigationProtocol>)self.topViewController;
            [vc processOrientationWhenPopViewController];
        }
    }

    return  [super popViewControllerAnimated:animated];

}

@end
