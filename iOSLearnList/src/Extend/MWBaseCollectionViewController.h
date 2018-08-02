//
//  MWBaseCollectionViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/26.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseViewController.h"


@interface MWBaseCollectionViewController : MWBaseViewController


@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *customLayout;
@property (nonatomic, retain) NSMutableArray *section0Array;


@end
