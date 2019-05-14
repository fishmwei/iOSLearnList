//
//  main.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/7.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <fishhook/fishhook.h>


//函数指针，用来保存原始的函数地址
static void (*old_nslog)(NSString *format, ...);

//新的NSLog
void myMethod(NSString *format, ...)
{
    //    va_list params;//定义一个指向个数可变的参数列表指针
    //    va_start(params, format);//va_start 得到第一个可变参数地址
    //    NSString *arg;
    //    NSMutableArray *args = [NSMutableArray array];
    //
    //    if (format) {
    //        //将第一个参数添加到array
    //        id prev = format;
    //        [args addObject:prev];
    //    }
    //    va_end(params);

    va_list va;
    va_start(va, format);
    NSString *fmt = [NSString stringWithFormat:@"Hooked: %@", format];
    NSLogv(fmt, va);
    va_end(va);
    //再调用原来的
    //    old_nslog(@"挂住了 %@", args);
}

void hookLog()
{
    struct rebinding nslogBind;
    //函数的名称
    nslogBind.name = "NSLog";
    //新的函数地址
    nslogBind.replacement = myMethod;
    //保存原始函数地址变量的指针
    nslogBind.replaced = (void *)&old_nslog;

    //定义数组
    struct rebinding rebs[] = {nslogBind};

    /**
     arg1: 存放rebinding结构体的数组
     arg2: 数组的长度
     */
    rebind_symbols(rebs, 1);
}

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        hookLog();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
