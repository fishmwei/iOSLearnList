//
//  YTKKeyValueStoreViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/26.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "YTKKeyValueStoreViewController.h"
#import "MWTextButtonCell.h"
#import <BlocksKit/UIView+BlocksKit.h>
#import <libextobjc/EXTScope.h>

#import <YTKKeyValueStore/YTKKeyValueStore.h>


@interface YTKKeyValueStoreViewController () <MWTextButtonCell_Delegate>
{
    YTKKeyValueStore *store;
}

@end


@implementation YTKKeyValueStoreViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    @weakify(self);
    [self.tableView bk_whenTapped:^{
        @strongify(self);
        [self.view endEditing:YES];
    }];
    [self.tableView registerClass:[MWTextButtonCell class] forCellReuseIdentifier:@"MWTextButtonCell"];

    store = [[YTKKeyValueStore alloc] initDBWithName:@"test.db"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MWTextButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWTextButtonCell" forIndexPath:indexPath];
    [cell settitle:@"x" btnTitle:@"Press"];
    cell.cellDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (void)btnPressed:(NSString *)content {
    if (content.length) {
        [store createTableWithName:[NSString stringWithFormat:@"'%@'", content]];
        [store putString:[NSString stringWithFormat:@"'%@'", content] withId:[NSString stringWithFormat:@"'%@'", content] intoTable:[NSString stringWithFormat:@"'%@'", content]];
        NSLog(@"get value:%@", [store getStringById:[NSString stringWithFormat:@"'%@'", content] fromTable:[NSString stringWithFormat:@"'%@'", content]]);
    }
}

@end
