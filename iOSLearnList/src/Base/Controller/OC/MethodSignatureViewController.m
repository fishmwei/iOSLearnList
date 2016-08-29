//
//  MethodSignatureViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MethodSignatureViewController.h"
#import "OBJModel.h"
#import <objc/runtime.h>


#import "MW_AB.h"
#import "MW_AC.h"

@interface MethodSignatureViewController () {
    OBJModel *om;
}

@end

@implementation MethodSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    om = [[OBJModel alloc] init];
    om.ctl = self;
    [om methodSw];//test metondSW
    
    
    [self performSelector:@selector(mehtod1Test)];
    [self performSelector:@selector(mehtod2Test)];
    
    [self performSelector:@selector(mehtod1111Test)];
//    [self mehtod1Test];
    
    
    
    
    
    MW_AB *ab = [[MW_AB alloc] init];
    [ab printClassName];
    [ab ABprintClassName];
    
    MW_AC *ac = [[MW_AC alloc] init];
    [ac printClassName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//-(BOOL)respondsToSelector:(SEL)aSelector
//{
//    return NO;
////    if ([super respondsToSelector:aSelector]) {
////        return YES;
////    }
////    
////    unsigned int mothCout_f =0;
////    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
////    for (NSUInteger i = 0; i < mothCout_f; i++) {
////        SEL SS = method_getName(mothList_f[i]);
////        if (SS == aSelector) {
////            free(mothList_f);
////            return YES;
////        }
////    }
////    free(mothList_f);
////    
////    
////    return [om respondsToSelector:aSelector];
//}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *sign =  [[self class] instanceMethodSignatureForSelector:aSelector];
    if (sign) {
        return sign;
    }
    
    sign = [OBJModel instanceMethodSignatureForSelector:aSelector];
    if (sign) {
        return sign;
    }
    
    return [OBJModel instanceMethodSignatureForSelector:@selector(unknown)];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = [anInvocation selector];
//    if ([self methodSignatureForSelector:sel]) {
//        return [super forwardInvocation:anInvocation];
//    }
    
    
    if ([OBJModel instancesRespondToSelector:sel]) {
        [anInvocation setTarget:om];
        [anInvocation invoke];
        return ;
    }
    
    [anInvocation setSelector:@selector(unknown)];
    [anInvocation invokeWithTarget:om];
}




//- (void)mehtod1Test {
//    NSLog(@"perform   %@", NSStringFromSelector(_cmd));
//}

-(NSInteger)mehtod2Test

{
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
    return 1;
    
}

//-(id)method3Test:(NSString*)str {
//    
//    NSLog(@"  参数:%@",str);
//    
//    return self.ctl;
//    
//}




/* 获取对象的所有方法 */
-(void)getAllMethods
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0; i<mothCout_f; i++)
    {
        Method temp_f = mothList_f[i];
        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}



@end
