//
//  configViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/5/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "configViewController.h"

@interface configViewController ()

@end

@implementation configViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 1000; i++) {
        [array addObject:@(i)];
    }
    
    for (id toDel in [array reverseObjectEnumerator]) {
        if ([toDel integerValue] % 3 == 0) {
            [array removeObject:toDel];
        }
    }
    
    NSLog(@"%@", array);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
