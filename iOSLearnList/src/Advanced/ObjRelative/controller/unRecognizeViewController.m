//
//  unRecognizeViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/9.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "unRecognizeViewController.h"
#import "ReversibleString.h"


@interface fellow : NSObject
- (void)pressed;
@end


@implementation fellow

- (void)pressed:(id)a {
    NSLog(@"pressed stub");
}
@end


@interface unRecognizeViewController ()
@property (nonatomic, strong) fellow *forwardObject;
@end


@implementation unRecognizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.forwardObject = [fellow new];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"按钮1" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 200, 100, 30);
    [self.view addSubview:btn];

    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];

    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"按钮2" forState:UIControlStateNormal];
    btn.frame = CGRectMake(120, 200, 100, 30);
    [self.view addSubview:btn];
    
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(pressed2:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(pressed:)) {
        return YES;
    }

    return [super respondsToSelector:aSelector];
}


#pragma mark - rewrite method

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = [anInvocation selector];
    if ([self.forwardObject respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self.forwardObject];
    } else {
        [super forwardInvocation:anInvocation];
    }
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }


    return [self.forwardObject methodSignatureForSelector:aSelector];
}

//-(void)pressed:(id)sender
//{
//
//    ReversibleString *a = [[ReversibleString alloc] initWithString:@"hello"
//                           ];
//
//
//    NSLog(@"a revertstring:%@", [a reversedString]);
//
//
//
////    a = [a reversedString]
//    //    [self doesNotRecognizeSelector:_cmd];  //disable super method
//}

@end
