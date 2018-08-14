//
//  methodSelectorViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/3.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "methodSelectorViewController.h"
#import "MWMethodSelector.h"


@implementation methodSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *target = [NSMutableArray array];
    for (NSUInteger i = 0; i < 1000; i++) {
        MWMethodSelector *oo = [[MWMethodSelector alloc] init];

        [target addObject:oo];
    }


    void (*setter)(id, SEL, NSString *);

    NSUInteger t = 0;
    for (MWMethodSelector *oo in target) {
        //        [oo setTagStr:[NSString stringWithFormat:@"%@", @(t++)]];
        setter = (void (*)(id, SEL, NSString *))[oo methodForSelector:@selector(setTagStr:)];
        setter(oo, @selector(setTagStr:), [NSString stringWithFormat:@"%@", @(t++)]);
    }


    void (*print)(id, SEL);

    for (MWMethodSelector *oo in target) {
        print = (void (*)(id, SEL))[oo methodForSelector:@selector(printTag)];
        print(oo, @selector(printTag));
    }
}
@end
