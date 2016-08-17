//
//  MWJSViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWJSViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>


#import "MWJSPerson.h"

@protocol MWJSUILabelExport <JSExport>

@property (nonatomic) NSString *text;

@end

@interface MWJSViewController () <UIWebViewDelegate> {
    JSContext *context;
    UILabel *showLabel;
    
    JSManagedValue *vTemp;//防止对象被释放 无法访问
}
@property (nonatomic, retain) UIWebView *wbView;
@end

@implementation MWJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wbView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_wbView];
    _wbView.delegate = self;
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [_wbView loadRequest:req];
    
    context = [[JSContext alloc] init];
    [context evaluateScript:@"'use strict'"];
    context[@"log"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSLog(@"log:%@", [obj toDictionary]);
            } else {
                NSLog(@"log:%@", obj);
            }
        }
    };
    
    [self calculate];
    [self printJSArray];
    [self printJSObject];
    
    [self callOCFunc];
    [self callJSFunc];
    
    [self JSCallException];
    
    [self arraytoJSArray];
    
    
    [self callOCOBJFunc];
    
    
    [self addProtocolToLabel];
    
    [self factorial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)calculate {
    JSValue *v = [context evaluateScript:@"1+1"];
    int iv = [v toInt32];
    
    NSLog(@"javalue %@, int: %d", v, iv);
    
}

- (void)printJSArray {
    [context evaluateScript:@"var arr = [21, 7 , 'iderzheng.com']; \
     log(arr.toString())"];
    
    JSValue *jsArr = context[@"arr"]; // Get array from JSContext
    
    NSLog(@"JS Array: %@;    Length: %@", jsArr, jsArr[@"length"]);
    jsArr[1] = @"blog"; // Use JSValue as array
    jsArr[7] = @7;
    
    NSLog(@"JS Array: %@;    Length: %d", jsArr, [jsArr[@"length"] toInt32]);
    
    NSArray *nsArr = [jsArr toArray];
    NSLog(@"NSArray: %@", nsArr);
}

- (void)printJSObject {
//    [context evaluateScript:@"var oo = {a:9}; \
                            oo.b = 10;\
     "];
    
    [context evaluateScript:@"var oo = Object.create({a:9, b:10});\
     log(oo.toJSON())"];
    JSValue *v = context[@"oo"];
    NSLog(@"oo is %@", [v toDictionary]);
    
    
    //prototype运行属性
}


- (void)callOCFunc {
    context[@"logg"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
    };
    
    [context evaluateScript:@"logg('ider', [7, 21], { hello:'world', js:100 });"];
}

- (void)callJSFunc {
    [context evaluateScript:@"function add (a, b) {return a+b;}"];
    
    JSValue *add = context[@"add"];
    JSValue *sum = [add callWithArguments:@[@2, @3]];
    NSLog(@"sum is %@", sum);
    
    
}

- (void)JSCallException {
    context.exceptionHandler = ^(JSContext *txt, JSValue *exception) {
        NSLog(@"recv exception %@", exception);
        txt.exception = exception;
    };
    
    [context evaluateScript:@"log(11, 2, 3, 4, 5)"];
}

- (void)arraytoJSArray {
    NSArray *arr = @[@11, @22, @32, @4222];
    context[@"arr2"] = arr;
    [context evaluateScript:@"log(arr2); \
                for (i = 0; i < arr2.length; i++) {\
                    log(arr2[i]); \
     }\
     "];
}


- (void)callOCOBJFunc {
    MWJSPerson *p = [[MWJSPerson alloc] init];
    context[@"p"] = p;
    p.firstName = @"huang";
    p.lastName = @"mingwei";
    p.urls = @{@"ss": @"1010.com"};
    
    
    [context evaluateScript:@"log(p.fullName())"];
    [context evaluateScript:@"log(p)"];
//    [context evaluateScript:@"log(p.getFirstName(), p.lastName)"];
    [context evaluateScript:@"p.urls={ss:999};  log(p.urls.ss)"];
    
    
    [context evaluateScript:@"p.setFirstNameLastName('first ', 'last'); log(p.fullName())"];
     [context evaluateScript:@"p.setPersonFullName('first ', 'last'); log(p.fullName())"];
    //setPersonFullName
}

-(void)addProtocolToLabel {
    showLabel = [[UILabel alloc] init];
    showLabel.frame = CGRectMake(0, 100, 100, 30);
    [self.view addSubview:showLabel];
    showLabel.text = @"3";
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.backgroundColor = [UIColor orangeColor];
    showLabel.textColor = [UIColor whiteColor];
    class_addProtocol([UILabel class], @protocol(MWJSUILabelExport));
    context[@"label"] = showLabel;
    [context evaluateScript:@"label.text = 100"];
    
    
    [context evaluateScript:@"log(p.urls.ss)"];
    
    
    NSDate *nn = [NSDate date];
    context[@"nn"] = nn;
    [context evaluateScript:@"log(nn)"];
    
}

- (void)factorial  {
    [context evaluateScript:@"function factorial(n) {\
        if (n < 0) {\
            return 0;\
        }\
        if (n == 0) {\
            return 1; \
        } \
        \
        return n * factorial(n-1);\
     }"];
//    JSValue *t = nil;
    @autoreleasepool {
        JSValue *f = context[@"factorial"];
        JSValue *t = [f callWithArguments:@[@2]];
        
         vTemp = [JSManagedValue managedValueWithValue:t];
        [context.virtualMachine addManagedReference:vTemp withOwner:self];
    }
    NSLog(@"%lu", [[vTemp value] toUInt32]);
    
    [context.virtualMachine removeManagedReference:vTemp withOwner:self];
    
//    [context evaluateScript:@"alert(2222);"];
    
    [context evaluateScript:@"log('new date:', new Date())"];
    
    
    

}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *xx=[webView valueForKeyPath: @"documentView.webView.mainFrame.javaScriptContext"];
    NSString *alertJS=@"alert('超哥你好，大河向东流')"; //准备执行的js代码
    [xx evaluateScript:alertJS];//通过oc方法调用js的alert
}

@end
