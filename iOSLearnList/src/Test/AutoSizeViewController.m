//
//  AutoSizeViewController.m
//  iOSLearnList
//
//  Created by mingwei on 2017/12/17.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "AutoSizeViewController.h"
#import <Masonry/Masonry.h>


@interface AutoSizeViewController ()

@end


@implementation AutoSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *sV = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    sV.backgroundColor = [UIColor redColor];
    [self.view addSubview:sV];

    UIView *subV = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 200)];
    subV.backgroundColor = [UIColor yellowColor];

    [sV addSubview:subV];
    [subV mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.edges.equalTo(sV).insets(UIEdgeInsetsMake(0, 0, 0, 3));
    }];


    [sV sizeToFit];
    // Do any additional setup after loading the view.
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
