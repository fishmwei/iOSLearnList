//
//  NSURLConnectionController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/13.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "NSURLConnectionController.h"


@interface NSURLConnectionController () <NSURLConnectionDataDelegate>
@property (nonatomic, retain) NSMutableData *receiveData;
@property (nonatomic, retain) NSURLConnection *requestConnection;

@property (nonatomic, retain) UIButton *systemBtn;
@property (nonatomic, retain) UIButton *customBtn;
@property (nonatomic, retain) UITextView *responseView;

@property (nonatomic, assign) NSInteger dataLength;

@end


@implementation NSURLConnectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"Deprecated iOS9 or later"];
    [self createView];
}

- (void)createData
{
    // Create the request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];

    // Create the NSMutableData to hold the received data.
    // receivedData is an instance variable declared elsewhere.
    _receiveData = [NSMutableData dataWithCapacity:0];

    // create the connection with the request
    // and start loading the data
    _requestConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];

    if (!_requestConnection) {
        // Release the receivedData object.
        _receiveData = nil;

        // Inform the user that the connection failed.
    }

    [_requestConnection start];
}

- (void)createView
{
    _systemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64 + 5, self.view.frame.size.width / 2, 44)];
    [_systemBtn setTitle:@"system" forState:UIControlStateNormal];
    [_systemBtn addTarget:self action:@selector(requestSystemDelegateData) forControlEvents:UIControlEventTouchUpInside];
    _systemBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_systemBtn];

    _customBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 64 + 5, self.view.frame.size.width / 2, 44)];
    [_customBtn setTitle:@"custom" forState:UIControlStateNormal];
    [_customBtn addTarget:self action:@selector(requestCustomDelegateData) forControlEvents:UIControlEventTouchUpInside];
    _customBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_customBtn];


    _responseView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_systemBtn.frame) + 5, self.view.frame.size.width, self.view.frame.size.height - 54)];

    _responseView.text = @"Response";
    [self.view addSubview:_responseView];
}

- (void)requestSystemDelegateData
{
    [self createData];
}


- (void)requestCustomDelegateData
{
    [self createData];
}

#pragma mark - connection delegate

#pragma mark success finish
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
    // do something with the data
    // receivedData is declared as a property elsewhere
    NSLog(@"Succeeded! Received %ld bytes of data", [_receiveData length]);


    dispatch_async(dispatch_get_main_queue(), ^{
        _responseView.text = [[NSString alloc] initWithData:_receiveData encoding:NSUTF8StringEncoding];


        _requestConnection = nil;
        _receiveData = nil;
    });


    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
}

#pragma mark error
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //    NSLog(@"get error %@", error);
    _requestConnection = nil;
    _receiveData = nil;

    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}
#pragma mark 成功
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.

    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.

    // receivedData is an instance variable declared elsewhere.

    self.dataLength = [response expectedContentLength];
    [_receiveData setLength:0];
}

#pragma mark 分段接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [_receiveData appendData:data];


    NSLog(@"total length:%ld process : %ld", self.dataLength, 100 * _receiveData.length / self.dataLength);
}

@end
