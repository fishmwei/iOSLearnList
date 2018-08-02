//
//  MW_AB.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MW_AB.h"
#import <objc/runtime.h>


@implementation MW_AB

+ (void)load
{
    [[self class] swMethod];
}

- (void)ABprintClassName
{
    NSLog(@"class name in MW_AB %@ in %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

+ (void)swMethod
{
    Method Origin = class_getInstanceMethod([self class], @selector(printClassName));
    Method Swap = class_getInstanceMethod([self class], @selector(ABprintClassName));

    BOOL add = class_addMethod([self class], @selector(printClassName), method_getImplementation(Swap), method_getTypeEncoding(Swap));
    if (add) {
        //        class_replaceMethod([self class], @selector(ABprintClassName), method_getImplementation(Origin), method_getTypeEncoding(Origin));
    } else {
        method_exchangeImplementations(Origin, Swap);
    }
}


@end
