//
//  MantleObjectModelViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MantleObjectModelViewController.h"
#import "MWMtlObject.h"


@implementation MantleObjectModelViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    MWMtlObject *mw = [[MWMtlObject alloc] init];
    mw.name = @"fishmwei";
    mw.age = @(25);
    mw.saveTime = [NSDate date];

    NSDictionary *dict = [MTLJSONAdapter JSONDictionaryFromModel:mw error:nil];
    NSLog(@"dict : %@", dict);

    MWMtlObject *obj = [MTLJSONAdapter modelOfClass:[MWMtlObject class] fromJSONDictionary:dict error:nil];
    NSLog(@"name: %@, age :%@ saveTime %@", obj.name, obj.age, obj.saveTime);
}

@end
