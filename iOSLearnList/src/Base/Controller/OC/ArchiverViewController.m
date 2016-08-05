//
//  ArchiverViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/5.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "ArchiverViewController.h"

@interface ArchiverViewController ()
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSString *filepath;
@end

@implementation ArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init status
    {
        self.inputView.keyboardType = UIKeyboardTypeDecimalPad;//数字键盘
    }
    
    [self setupData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData {
    self.data = [NSMutableArray array];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _filepath = [documentsDirectory stringByAppendingPathComponent:@"archiverData"];
    
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:_filepath]) {
        [fm createFileAtPath:_filepath contents:nil attributes:nil];
        
    }
    [self.data addObjectsFromArray:[NSArray arrayWithContentsOfFile:_filepath]];
    
    NSString *ss = @"";
    for (NSNumber *t in self.data) {
        ss = [ss stringByAppendingString:[NSString stringWithFormat:@"%@\n", t]];
    }
    self.showView.text = ss;
}


-(IBAction)addBtnPressed:(id)sender {
    NSNumber *number = @([self.inputView.text integerValue]);
    [self.data addObject:number];
    
    
    self.inputView.text = nil;
    [self.view endEditing:YES];
    
    
    NSString *ss = self.showView.text;
    ss = [ss stringByAppendingString:[NSString stringWithFormat:@"%@\n", number]];

    self.showView.text = ss;
}

-(IBAction)saveBtnPressed:(id)sender {
    BOOL ret = [self.data writeToFile:_filepath atomically:YES];
    if (ret) {
        NSLog(@"write success");
    }
}



@end
