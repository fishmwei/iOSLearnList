//
//  AppDelegate.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/7.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "AppDelegate.h"
#import "ExtendMainController.h"
#import "BBLaunchAdMonitor.h"
#import "myBundleFrame.h"
#import <DoraemonKit/DoraemonKit.h>
#import <Bugly/Bugly.h>
#import "MWOrientation.h"
#import <CocoaLumberjack/CocoaLumberjack.h>


static DDLogLevel ddLogLevel = DDLogLevelAll;

#define NSLog(frmt, ...)  DDLogInfo(frmt, ##__VA_ARGS__)

@interface AppDelegate ()
@property (nonatomic, retain) NSString *b;
@end


@interface NSObject (A)
- (void)seta;
@end


@implementation NSObject (A)

- (void)seta {
}

@end


@interface NSObject (B)
- (void)seta;
@end


@implementation NSObject (B)

- (void)seta {
}

@end


@implementation AppDelegate

+ (void)initialize {
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

- (void)setAppearence {
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[ [UISearchBar class] ]] setTitle:@"取消"];

}

//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//
//    
//    return [MWOrientation getOrientation];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setAppearence];
 
    [Bugly startWithAppId:@"83b91fa7fe"];
    
    NSString *componentID = nil;
    NSString *st = componentID ?: @"public";
    DDLogInfo(@"%@", st);

    NSNumber *isAlreadyRunning = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAlreadyRunning"];
    if (isAlreadyRunning) {
        NSLog(@"isAlreadyRunning YES");
    } else {
        NSLog(@"isAlreadyRunning NO");
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"isAlreadyRunning"];
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"app_Version %@", app_Version);


    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];


    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ExtendMainController alloc] init];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];

#ifdef TEST_ENV
    NSString *t = @"aaaaa";
    self.b = t;
    t = @"ccc";

    NSLog(@"%@", self.b);

    [self testShowIdClass:self.window.rootViewController];
#endif

    //    //AD
    //    {
    //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdDetail:) name:BBLaunchAdDetailDisplayNotification object:nil];
    //        NSString *path = @"http://mg.soupingguo.com/bizhi/big/10/258/043/10258043.jpg";
    //        [BBLaunchAdMonitor showAdAtPath:path
    //                                 onView:self.window.rootViewController.view
    //                           timeInterval:5.
    //                       detailParameters:@{@"carId":@(12345), @"name":@"奥迪-品质生活"}];
    //    }

    if ([launchOptions objectForKey:@"UIApplicationLaunchOptionsShortcutItemKey"]) {
        //        return NO;
    } else {
        [self addDynamicShortCutItems];
    }
 
   
    
//#ifdef DEBUG
//    [[DoraemonManager shareInstance] addH5DoorBlock:^(NSString *h5Url) {
//        //使用自己的H5容器打开这个链接
//    }];
//
//    [[DoraemonManager shareInstance] install];
//#endif
    
    return YES;
}

//获取界面最上层的控制器
- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
//一层一层的进行查找判断
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    UIViewController *topVc = [self topViewController];
    if (topVc) {
        return [topVc supportedInterfaceOrientations];
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 后台session下载 完成
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(nonnull NSString *)identifier completionHandler:(nonnull void (^)())completionHandler {
    NSURLSessionConfiguration *backgroundConfigObject = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];

    backgroundConfigObject.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;


    //    NSURLSession *backgroundSession = [NSURLSession sessionWithConfiguration: backgroundConfigObject delegate: self.mySessionDelegate delegateQueue: [NSOperationQueue mainQueue]];
    //
    //    NSLog(@"Rejoining session %@\n", identifier);
    //
    //    [ self.mySessionDelegate addCompletionHandler: completionHandler forSession: identifier];
}

#pragma mark AD
- (void)showAdDetail:(NSNotification *)noti {
    NSLog(@"detail parameters:%@", noti.object);
}

- (void)addDynamicShortCutItems {
    NSMutableArray<UIApplicationShortcutItem *> *appShortCutItems = [NSMutableArray arrayWithArray:[[UIApplication sharedApplication] shortcutItems]];
    if (!appShortCutItems.count) {
        appShortCutItems = [NSMutableArray array];
    }

    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"Base" localizedTitle:NSLocalizedStringFromTable(@"Base", @"myLanguage", nil) localizedSubtitle:NSLocalizedStringFromTable(@"Base", @"myLanguage", nil) icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
    [self addSpecialItem:item toMultableArray:appShortCutItems];


    item = [[UIApplicationShortcutItem alloc] initWithType:@"Advance" localizedTitle:NSLocalizedStringFromTable(@"Advance", @"myLanguage", nil) localizedSubtitle:NSLocalizedStringFromTable(@"Advance", @"myLanguage", nil) icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
    [self addSpecialItem:item toMultableArray:appShortCutItems];

    item = [[UIApplicationShortcutItem alloc] initWithType:@"More" localizedTitle:@"More" localizedSubtitle:@"More" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
    [self addSpecialItem:item toMultableArray:appShortCutItems];

    [[UIApplication sharedApplication] setShortcutItems:appShortCutItems];
}


- (void)addSpecialItem:(UIApplicationShortcutItem *)item toMultableArray:(NSMutableArray *)arr {
    for (UIApplicationShortcutItem *i in arr) {
        if ([i.type isEqualToString:item.type]) {
            return;
        }
    }

    [arr addObject:item];
}

- (void)removeDynamicShortCutItems {
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [[NSUserDefaults standardUserDefaults] setObject:shortcutItem.type forKey:@"ShortCut"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MWShortCutClick" object:shortcutItem.type];
}


#pragma test Method
- (void)testShowIdClass:(id)testId {
    NSLog(@"%@ showClass:%@", NSStringFromSelector(_cmd), [(id)testId class]);
}

@end
