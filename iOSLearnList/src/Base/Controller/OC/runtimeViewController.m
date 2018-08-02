//
//  runtimeViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "runtimeViewController.h"
#import <objc/runtime.h>


@interface runtimeViewController ()
{
    Class myView;
    UIView *vv;
}
@end


@implementation runtimeViewController

- (void)dealloc
{
    [vv removeFromSuperview];
    vv = nil;
    //    objc_disposeClassPair(myView);
}

void showAllMetaClass(id self, SEL _cmd)
{
    Class currentClass = [self class];

    while (![NSStringFromClass(currentClass) isEqualToString:NSStringFromClass([NSObject class])]) {
        NSLog(@"currentClass %@", NSStringFromClass(currentClass));
        currentClass = class_getSuperclass(currentClass);
        //        currentClass = object_getClass(currentClass);
    }
}

void customFrame(id self, SEL _cmd, id value)
{
    CGRect rect = [value CGRectValue];
    //    [self performSelectorOnMainThread:@selector(setFrame:) withObject:rect waitUntilDone:YES];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self setFrame:rect];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myView = [self createAView];

    //创建新view
    //    Class myView = [self createAView];
    vv = [[myView alloc] init];
    //    [vv setFrame:CGRectMake(100, 100, 100, 100)];
    //    [vv setBackgroundColor:[UIColor redColor ]];
    //    [vv performSelectorOnMainThread: @selector(setFrame:) withObject:[NSValue valueWithCGRect:CGRectMake(100, 100, 100, 100)] waitUntilDone:YES];
    [vv performSelectorOnMainThread:@selector(setBackgroundColor:) withObject:[UIColor redColor] waitUntilDone:YES];

    [vv performSelector:@selector(showAllMetaClass)];
    [vv performSelector:@selector(customFrame:) withObject:[NSValue valueWithCGRect:CGRectMake(100, 100, 100, 100)]];

    [self.view addSubview:vv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Class)createAView
{
    if (NSClassFromString(@"mwCustomView")) {
        return NSClassFromString(@"mwCustomView");
    }

    Class newClass = objc_allocateClassPair([UIView class], "mwCustomView", 0);
    class_addMethod(newClass, @selector(showAllMetaClass), (IMP)showAllMetaClass, "v@:");
    class_addMethod(newClass, @selector(customFrame:), (IMP)customFrame, "v@:");


    objc_registerClassPair(newClass);

    return newClass;
}


@end
