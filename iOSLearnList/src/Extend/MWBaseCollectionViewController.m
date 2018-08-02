//
//  MWBaseCollectionViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/26.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseCollectionViewController.h"


@interface MWBaseCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    CGFloat cellWidth;
}


@end


@implementation MWBaseCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _section0Array = [NSMutableArray array];
    for (NSUInteger i = 0; i < 50; i++) {
        [_section0Array addObject:@(i)];
    }


    self.view.backgroundColor = [UIColor whiteColor];
    cellWidth = 50;
    [self setupMyCollectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupMyCollectionView
{
    _customLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_customLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];

    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId"];
}
#pragma mark---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _section0Array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];

    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        if (headerView == nil) {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];

        return headerView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerId" forIndexPath:indexPath];
        if (footerView == nil) {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];

        return footerView;
    }

    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
}


#pragma mark---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){cellWidth, cellWidth};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){CGRectGetWidth([UIScreen mainScreen].bounds), 44};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){CGRectGetWidth([UIScreen mainScreen].bounds), 22};
}


#pragma mark---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        return YES;
    }

    return NO;
}

//
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        //        NSLog(@"-------------执行拷贝-------------");
        [_collectionView performBatchUpdates:^{
            [_section0Array removeObjectAtIndex:indexPath.row];
            [_collectionView deleteItemsAtIndexPaths:@[ indexPath ]];
        } completion:nil];
    } else if ([NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        NSLog(@"-------------执行粘贴-------------");
    }
}

@end
