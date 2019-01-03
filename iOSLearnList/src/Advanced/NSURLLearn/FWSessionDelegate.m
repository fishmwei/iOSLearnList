//
//  FWSessionDelegate.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/11.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "FWSessionDelegate.h"


@implementation FWSessionDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createData];
    }

    return self;
}


- (void)createData {
#if TARGET_OS_IPHONE
    self.completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
#endif

    /* Create some configuration objects. */
    NSURLSessionConfiguration *backgroundConfigObject = [NSURLSessionConfiguration backgroundSessionConfiguration:@"myBackgroundSessionIdentifier"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSessionConfiguration *ephemeralConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];

    ephemeralConfigObject.allowsCellularAccess = NO; //不允许访问数据流量
/* Configure caching behavior for the default session.
     Note that iOS requires the cache path to be a path relative
     to the ~/Library/Caches directory, but OS X expects an
     absolute path.
     */
#if TARGET_OS_IPHONE
    NSString *cachePath = @"/MyCacheDirectory";

    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *myPath = [myPathList objectAtIndex:0];

    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

    NSString *fullCachePath = [[myPath stringByAppendingPathComponent:bundleIdentifier] stringByAppendingPathComponent:cachePath];
    NSLog(@"Cache path: %@\n", fullCachePath);
#else
    NSString *cachePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"/nsurlsessiondemo.cache"];

    NSLog(@"Cache path: %@\n", cachePath);
#endif


    NSURLCache *myCache = [[NSURLCache alloc] initWithMemoryCapacity:16384 diskCapacity:268435456 diskPath:cachePath];
    defaultConfigObject.URLCache = myCache;
    defaultConfigObject.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;

    /* Create a session for each configurations. */
    self.defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.backgroundSession = [NSURLSession sessionWithConfiguration:backgroundConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.ephemeralSession = [NSURLSession sessionWithConfiguration:ephemeralConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
}


@end
