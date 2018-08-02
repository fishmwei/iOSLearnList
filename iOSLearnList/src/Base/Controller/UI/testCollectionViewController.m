//
//  testCollectionViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/26.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "testCollectionViewController.h"


@interface testCollectionViewController ()

@end


@implementation testCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"test"];
    UIBarButtonItem *btnItem0 = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(addItemBtnClick:)];
    UIBarButtonItem *btnItem1 = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(addItemBtnClick:)];

    //    self.navigationItem.rightBarButtonItem = btnItem;

    self.navigationItem.rightBarButtonItems = @[ btnItem0 ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addItemBtnClick:(id)sender
{
    [self.collectionView performBatchUpdates:^{
        // 构造一个indexPath
        NSIndexPath *indePath = [NSIndexPath indexPathForItem:self.section0Array.count inSection:0];
        [self.collectionView insertItemsAtIndexPaths:@[ indePath ]]; // 然后在此indexPath处插入给collectionView插入一个item
        [self.section0Array addObject:@"x"];                         // 保持collectionView的item和数据源一致
    } completion:nil];
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
