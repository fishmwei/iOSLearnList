//
//  defaultNSURLSessionController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/11.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "defaultNSURLSessionController.h"

@implementation defaultNSURLSessionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _pressedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64+5, self.view.frame.size.width, 44)];
    [_pressedBtn setTitle:@"Request" forState:UIControlStateNormal];
    [_pressedBtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    _pressedBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_pressedBtn];
    
    
    _responseView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pressedBtn.frame) + 5, self.view.frame.size.width, self.view.frame.size.height - 54)];
    
    _responseView.text = @"Response";
    [self.view addSubview:_responseView];
    
    
}

-(void) requestData
{
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:cfg];
    
    NSURLSessionTask *tsk = [defaultSession dataTaskWithURL:[NSURL URLWithString:@"http://www.baidu.com"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
         {
             NSString *resp = @"Response:\n";
             resp = [resp stringByAppendingString:[NSString stringWithFormat:@"Got response %@ with error %@.\n", response, error]];
                     
//             NSLog(@"Got response %@ with error %@.\n", response, error);
             
             resp = [resp stringByAppendingString:[NSString stringWithFormat:@"DATA:\n%@\nEND DATA\n",
                                                   [[NSString alloc] initWithData: data
                      encoding: NSUTF8StringEncoding]]];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 _responseView.text = resp;
             });
             
             
         }];
    
    [tsk resume];
    
}


@end
