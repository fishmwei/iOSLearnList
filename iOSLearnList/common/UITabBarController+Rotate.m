//
//  UITabBarController+Rotate.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/8.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "UITabBarController+Rotate.h"
 

@implementation UITabBarController (Rotate)

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
