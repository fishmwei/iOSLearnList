//
//  UINavigationController+Rotate.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/8.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "UINavigationController+Rotate.h"

#import <AppKit/AppKit.h>


@implementation UINavigationController (Rotate)

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

@end
