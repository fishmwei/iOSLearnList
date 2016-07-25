//
//  defaultNSURLSessionController.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/11.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "MWBaseViewController.h"


@interface defaultNSURLSessionController : MWBaseViewController <NSURLSessionDataDelegate>
@property (nonatomic, retain) UIButton *systemBtn;
@property (nonatomic, retain) UIButton *customBtn;
@property (nonatomic, retain) UITextView *responseView;
@end
