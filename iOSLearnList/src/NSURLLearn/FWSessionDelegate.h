//
//  FWSessionDelegate.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/11.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^CompletionHandlerType)();


@interface FWSessionDelegate : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property NSURLSession *backgroundSession;
@property NSURLSession *defaultSession;
@property NSURLSession *ephemeralSession;

#if TARGET_OS_IPHONE
@property NSMutableDictionary *completionHandlerDictionary;
#endif

- (void) addCompletionHandler: (CompletionHandlerType) handler forSession: (NSString *)identifier;
- (void) callCompletionHandlerForSession: (NSString *)identifier;



@end
