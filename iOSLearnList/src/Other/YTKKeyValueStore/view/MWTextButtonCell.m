
//  MWTextButtonCell.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/26.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWTextButtonCell.h"
#import <Masonry/Masonry.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import <libextobjc/EXTScope.h>


@interface MWTextButtonCell ()
@property (nonatomic, retain) UITextField *textView;
@property (nonatomic, retain) UIButton *btn;

@end


@implementation MWTextButtonCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initBaseUI];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseUI];
    }

    return self;
}

- (void)initBaseUI
{
    self.textView = [[UITextField alloc] init];
    self.textView.backgroundColor = [UIColor orangeColor];

    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *maker) {
        //        maker.height.equalTo(self.mas_height);
        maker.top.equalTo(self.mas_top).offset(3);
        maker.bottom.equalTo(self.mas_bottom).offset(-3);
        maker.width.equalTo(@120);
        maker.left.equalTo(self.mas_left).offset(5);
    }];

    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.height.equalTo(self.mas_height);
        maker.top.equalTo(self.mas_top);
        maker.width.equalTo(@100);
        maker.right.equalTo(self.mas_right);
    }];

    @weakify(self);
    [self.btn bk_addEventHandler:^(id sender) {
        @strongify(self);

        [self.cellDelegate btnPressed:self.textView.text];

    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)settitle:(NSString *)title btnTitle:(NSString *)btnTitle
{
    [self.btn setTitle:btnTitle forState:UIControlStateNormal];
}


@end
