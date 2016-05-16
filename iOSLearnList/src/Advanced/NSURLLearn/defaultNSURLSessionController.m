//
//  defaultNSURLSessionController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/11.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "defaultNSURLSessionController.h"

@interface defaultNSURLSessionController ()
{
    NSMutableDictionary *taskDataDict;
}
@end

@implementation defaultNSURLSessionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    taskDataDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _systemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64+5, self.view.frame.size.width/2, 44)];
    [_systemBtn setTitle:@"system" forState:UIControlStateNormal];
    [_systemBtn addTarget:self action:@selector(requestSystemDelegateData) forControlEvents:UIControlEventTouchUpInside];
    _systemBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_systemBtn];
    
    _customBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 64+5, self.view.frame.size.width/2, 44)];
    [_customBtn setTitle:@"custom" forState:UIControlStateNormal];
    [_customBtn addTarget:self action:@selector(requestCustomDelegateData) forControlEvents:UIControlEventTouchUpInside];
    _customBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_customBtn];
    
    
    _responseView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_systemBtn.frame) + 5, self.view.frame.size.width, self.view.frame.size.height - 54)];
    
    _responseView.text = @"Response";
    [self.view addSubview:_responseView];
    
    
}

-(void)requestSystemDelegateData
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


-(void)requestCustomDelegateData
{
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    NSURLSession *customSession = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    
    NSURLSessionTask *tsk = [customSession dataTaskWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
                             
    [tsk resume];
    

    
}


#pragma mark - NSURLSessionDataDelegate

#pragma mark 接收组装数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSString *identifier = [NSString stringWithFormat:@"%@", dataTask.originalRequest];
    NSData *tskData = [taskDataDict objectForKey:identifier];
    
    if (tskData == nil) {
        [taskDataDict setObject:data forKey:identifier ];
    }
    else
    {
        NSMutableData *dd = [[NSMutableData alloc] init];
        [dd appendData:tskData];
        [dd appendData:data];
        
        [taskDataDict setObject:dd forKey:identifier ];
    }
    
 }

#pragma mark  完成接收数据
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    NSString *identifier = [NSString stringWithFormat:@"%@", task.originalRequest];
    NSData *data = [taskDataDict objectForKey:identifier];
    
    NSString *resp = @"complete Response:\n";
    resp = [resp stringByAppendingString:[NSString stringWithFormat:@"DATA:\n%@\nEND DATA\n",
                                           [[NSString alloc] initWithData: data
                                                                 encoding: NSUTF8StringEncoding]]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _responseView.text = resp;
    });
}


#pragma mark 处理重定向, 如果没有实现 默认允许重定向
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler
{
    NSURLRequest *newRequest = request;
    if (response) {
        newRequest = nil;
    }
    
    completionHandler(newRequest);
}

-(void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        newCredential = [NSURLCredential credentialWithUser:@"userName"
                                                   password:@"password"
                                                persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // inform the user that the user name and password
        // in the preferences are incorrect
//        [self showPreferencesCredentialsAreIncorrectPanel:self];
    }
}



@end
