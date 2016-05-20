//
//  downloadController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/12.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "downloadController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface downloadController() <NSURLSessionDownloadDelegate>
{
    UILabel *label;
    UIImageView *showImageView;
    NSURLSessionDownloadTask *downloadTask;
}


@property (nonatomic, retain) NSURLSession *downloadSession;

@end

@implementation downloadController

- (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

- (void)dealloc
{
    [self.downloadSession invalidateAndCancel];
    self.downloadSession = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    [self createData];
}

- (void)createView
{
    _systemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64+5, 200, 44)];
    [_systemBtn setTitle:@"Request" forState:UIControlStateNormal];
    [_systemBtn addTarget:self action:@selector(startDownloadFile:) forControlEvents:UIControlEventTouchUpInside];
    _systemBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_systemBtn];
    
    
//    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 64+5, 100, 44)];
//    [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
//    [_cancelBtn addTarget:self action:@selector(cancelDownloadFile:) forControlEvents:UIControlEventTouchUpInside];
//    _cancelBtn.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:_cancelBtn];
    
    
    
    
    _responseView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_systemBtn.frame) + 5, self.view.frame.size.width, 100)];
    
    _responseView.text = @"Response";
    [self.view addSubview:_responseView];
    
    _responseView.layer.borderWidth = 2;
    _responseView.layer.borderColor = [UIColor orangeColor].CGColor;
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_responseView.frame), _responseView.frame.size.width, 20)];
    label.text = @"Image:";
    [self.view addSubview:label];
    
    showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), label.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(label.frame))];
    showImageView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:showImageView];
    
}

- (void)createData
{
    //Create Session
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:[self uuidString]];
    cfg.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    self.downloadSession = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:nil];//[NSOperationQueue mainQueue]
    
    
   //http://img4.imgtn.bdimg.com/it/u=4236942158,2307642402&fm=21&gp=0.jpg
    
}


-(void)cancelDownloadFile:(id)sender
{
    if (downloadTask) {
        [downloadTask cancel];
        downloadTask = nil;
    }
    
}


-(void)startDownloadFile:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.enabled = NO;
    btn.userInteractionEnabled = NO;
    [_systemBtn setTitle:@"Requesting..." forState:UIControlStateNormal];
    label.text = [NSString stringWithFormat:@"Image:%%%.0f", 0.0f];
    //http://img3.imgtn.bdimg.com/it/u=1574888272,1644461093&fm=21&gp=0.jpg
//    NSURL *url = [NSURL URLWithString:@"http://img4.imgtn.bdimg.com/it/u=4236942158,2307642402&fm=21&gp=0.jpg"];
    NSURL *url = [NSURL URLWithString:@"http://bizhi.33lc.com/uploadfile/2013/1204/20131204100548645.jpg"];
    
    downloadTask = [self.downloadSession downloadTaskWithURL:url];
    [downloadTask resume];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

#pragma  mark j- NSURLSessionDownloadDelegate

#pragma mark 下载完成
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


#pragma mark 下载成功
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)task
didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"Session %@ download task %@ finished downloading to URL %@\n",
          session, task, location);
 
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *URLs = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    NSURL *documentsDirectory = URLs[0];
    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
    
    
    //Copy file
    NSError *error;
    [fm removeItemAtURL:destinationPath error:NULL];
    
    BOOL success = [fm copyItemAtURL:location toURL:destinationPath error:&error];
    
    if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            showImageView.image =  [UIImage imageWithContentsOfFile:[destinationPath path]];

            _responseView.text = [NSString stringWithFormat:@"%@", destinationPath];
            
            _systemBtn.enabled = YES;
            _systemBtn.userInteractionEnabled = YES;
            [_systemBtn setTitle:@"Request" forState:UIControlStateNormal];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        
        downloadTask = nil;
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            showImageView.image =  nil;
            
            _responseView.text = [NSString stringWithFormat:@"Failed to copy %@", location];
            
            _systemBtn.enabled = YES;
            _systemBtn.userInteractionEnabled = YES;
            [_systemBtn setTitle:@"Request" forState:UIControlStateNormal];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
    }
    
    
//    
//    
//#if 0
//    /* Workaround */
//    [self callCompletionHandlerForSession:session.configuration.identifier];
//#endif
//    
//    
//#define READ_THE_FILE 1
//#if READ_THE_FILE
//    /* Open the newly downloaded file for reading. */
//    NSError *err = nil;
//    NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:location
//                                                           error: &err];
//    
//    
//    if (fh == nil) {
//        NSLog(@"errors");
//    }
//    /* Store this file handle somewhere, and read data from it. */
//    // ...
//    
//#else
//    NSError *err = nil;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *cacheDir = [[NSHomeDirectory()
//                           stringByAppendingPathComponent:@"Library"]
//                          stringByAppendingPathComponent:@"Caches"];
//    NSURL *cacheDirURL = [NSURL fileURLWithPath:cacheDir];
//    if ([fileManager moveItemAtURL:location
//                             toURL:cacheDirURL
//                             error: &err]) {
//        
//        /* Store some reference to the new URL */
//    } else {
//        /* Handle the error. */
//    }
//#endif
    
    
    
    
    
//    dispatch_async(dispatch_get_main_queue(), ^{
////        showImageView.image = [UIImage imageWithContentsOfFile:[location absoluteString]];
//        
//        
//        _responseView.text = [NSString stringWithFormat:@"%@", location];
//        
//        _systemBtn.enabled = YES;
//        _systemBtn.userInteractionEnabled = YES;
//        [_systemBtn setTitle:@"Request" forState:UIControlStateNormal];
//    });
}


#pragma mark - 下载进度
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double  currentProgress = totalBytesWritten / ( double )totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        self.progressIndicator.hidden = NO;
//        self.progressIndicator.progress = currentProgress;
        label.text = [NSString stringWithFormat:@"Image:%%%.0f", currentProgress*100];
    });
        
        
    NSLog(@"Session %@ download task %@ wrote an additional %lld bytes (total %lld bytes) out of an expected %lld bytes.\n",
          session, downloadTask, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}

#pragma  mark - 恢复下载
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"Session %@ download task %@ resumed at offset %lld bytes out of an expected %lld bytes.\n",
          session, downloadTask, fileOffset, expectedTotalBytes);
}

//Session 后台下载完成 事件

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    NSLog(@"Background URL session %@ finished events.\n", session);
    
//    if (session.configuration.identifier)
//        [self callCompletionHandlerForSession: session.configuration.identifier];
}

//- (void) addCompletionHandler: (CompletionHandlerType) handler forSession: (NSString *)identifier
//{
//    if ([ self.completionHandlerDictionary objectForKey: identifier]) {
//        NSLog(@"Error: Got multiple handlers for a single session identifier.  This should not happen.\n");
//    }
//    
//    [ self.completionHandlerDictionary setObject:handler forKey: identifier];
//}
//
//- (void) callCompletionHandlerForSession: (NSString *)identifier
//{
//    CompletionHandlerType handler = [self.completionHandlerDictionary objectForKey: identifier];
//    
//    if (handler) {
//        [self.completionHandlerDictionary removeObjectForKey: identifier];
//        NSLog(@"Calling completion handler.\n");
//        
//        handler();
//    }
//}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
        downloadTask = nil;
}


@end
