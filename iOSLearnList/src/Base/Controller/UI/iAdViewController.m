//
//  iAdViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/9/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "iAdViewController.h"


@implementation iAdViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    bannerView = [[ADBannerView alloc] initWithFrame:
                                           CGRectMake(0, 64, 320, 50)];
    // Optional to set background color to clear color
    [bannerView setBackgroundColor:[UIColor orangeColor]];
    [bannerView setDelegate:self];
    [self.view addSubview:bannerView];
}

#pragma mark - AdViewDelegates

- (void)bannerView:(ADBannerView *)banner
    didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Error loading");
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSLog(@"Ad loaded");
}
- (void)bannerViewWillLoadAd:(ADBannerView *)banner {
    NSLog(@"Ad will load");
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"Ad did finish");
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    return YES;
}


@end
