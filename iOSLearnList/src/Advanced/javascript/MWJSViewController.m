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

@interface MWJSViewController () {
    JSContext *context;
    UILabel *showLabel;
}

@end

@implementation MWJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    context = [[JSContext alloc] init];
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
    [context evaluateScript:@"var arr = [21, 7 , 'iderzheng.com'];"];
    JSValue *jsArr = context[@"arr"]; // Get array from JSContext
    
    NSLog(@"JS Array: %@;    Length: %@", jsArr, jsArr[@"length"]);
    jsArr[1] = @"blog"; // Use JSValue as array
    jsArr[7] = @7;
    
    NSLog(@"JS Array: %@;    Length: %d", jsArr, [jsArr[@"length"] toInt32]);
    
    NSArray *nsArr = [jsArr toArray];
    NSLog(@"NSArray: %@", nsArr);
}

- (void)printJSObject {
    [context evaluateScript:@"var oo = {a:9}; \
                            oo.b = 10;\
     "];
    JSValue *v = context[@"oo"];
    NSLog(@"oo is %@", [v toDictionary]);
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
    
}




@end
