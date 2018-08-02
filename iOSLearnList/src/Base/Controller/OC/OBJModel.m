//
//  OBJModel.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "OBJModel.h"
#import <objc/runtime.h>


@implementation OBJModel

+ (void)initialize
{
    [[self class] swMethod];
}

- (void)mehtod1Test
{
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


- (void)unknown
{
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)methodSw
{
    //    [self methodSw];
    NSLog(@"call methodSw:%@ %@", [self class], NSStringFromSelector(_cmd));

    [[self class] swMethod];
}

- (void)methodReplace
{
    NSLog(@"call methodReplace:%@ %@", [self class], NSStringFromSelector(_cmd));
    [[self class] swMethod];
}


+ (void)swMethod
{
    Method Origin = class_getInstanceMethod([self class], @selector(methodSw));
    Method Swap = class_getInstanceMethod([self class], @selector(methodReplace));

    //    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    method_exchangeImplementations(Origin, Swap);
}
@end
