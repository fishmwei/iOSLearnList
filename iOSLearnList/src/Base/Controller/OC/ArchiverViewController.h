//
//  ArchiverViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/5.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseViewController.h"

@interface ArchiverViewController : MWBaseViewController

@property (nonatomic, weak) IBOutlet UITextView *showView;
@property (nonatomic, weak) IBOutlet UITextView *inputView;
@property (nonatomic, weak) IBOutlet UIButton *addBtn;
@property (nonatomic, weak) IBOutlet UIButton *saveBtn;


-(IBAction)addBtnPressed:(id)sender;
-(IBAction)saveBtnPressed:(id)sender;

@end
