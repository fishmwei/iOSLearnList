//
//  iAdViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/9/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface iAdViewController : UIViewController <ADBannerViewDelegate> {
    ADBannerView *bannerView;
}

@end
