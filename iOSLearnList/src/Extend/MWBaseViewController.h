//
//  MWBaseViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MWBaseViewController : UIViewController

- (void)showTextTips:(NSString *)tips;

- (void)showLoadingTips;

- (void)dismissLoadingTips;

@end
