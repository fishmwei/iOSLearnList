//
//  InvocationBlockViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/10/11.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "InvocationBlockViewController.h"


typedef void (^_testBlock)(NSString *fullStr);


@interface TestBlock : NSObject

- (void)appendHeaderToString:(NSString *)content completeBlock:(_testBlock)block;


@end

@implementation TestBlock
- (void)appendHeaderToString:(NSString *)content completeBlock:(_testBlock)block {
    NSString *fullStr = [@"Header : " stringByAppendingString:content];
    block(fullStr);
}

@end

@interface InvocationBlockViewController ()
@property (nonatomic, strong) TestBlock *blockObj;
@end

@implementation InvocationBlockViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.blockObj = [TestBlock new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addButton:@"Click" selector:@selector(onClick) react:CGRectMake(0, 100, 200, 50)];
    
}

- (void)onClick {
    SEL method = @selector(appendHeaderToString:completeBlock:);
    NSMethodSignature *methodSignature = [self.blockObj methodSignatureForSelector:method];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = self.blockObj;
    invocation.selector = method;
    
    NSString *content = @"I'am content";
    _testBlock block = ^(NSString *str) {
        NSLog(@"str %@", str);
    };
    
    [invocation setArgument:&content atIndex:2];
    
    [invocation setArgument:&block atIndex:3];
    
    [invocation invoke];
    
}

- (void)addButton:(NSString *)title selector:(SEL)selector react:(CGRect)react{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = react;
    
    [self.view addSubview:btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}



@end
