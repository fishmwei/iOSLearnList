//
//  UIViewController+MWUtils.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/10/31.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "UIViewController+MWUtils.h"
#import <objc/runtime.h>

@implementation UIViewController (MWUtils)

- (void)setPreviousNavigationBarHidden:(BOOL)previousNavigationBarHidden {
    NSNumber *number = [NSNumber numberWithBool:previousNavigationBarHidden];
    objc_setAssociatedObject(self, @selector(previousNavigationBarHidden), number, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)previousNavigationBarHidden {
    NSNumber *number = objc_getAssociatedObject(self, @selector(previousNavigationBarHidden));
    return [number boolValue];
}

@end
