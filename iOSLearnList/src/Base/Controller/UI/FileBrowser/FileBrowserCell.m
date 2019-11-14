//
//  FileBrowserCell.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/11/14.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "FileBrowserCell.h"
#import "FileBrowserInfo.h"

#import <Masonry/Masonry.h>

@interface FileBrowserCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
@end

@implementation FileBrowserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initBaseUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseUI];
    }
    
    return self;
}

- (void)initBaseUI {
    
    self.icon = [UIImageView new];
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *maker) {
                maker.top.equalTo(self.mas_top).offset(10);
                maker.height.width.equalTo(@(30));
                maker.left.equalTo(self.mas_left).offset(5);
    }];
    
    
    self.label = [UILabel new];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.top.equalTo(self.mas_top).offset(15);
        maker.height.equalTo(@(20));
        maker.left.equalTo(self.icon.mas_right).offset(15);
        maker.right.equalTo(self.mas_right);
    }];
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.textColor = [UIColor colorWithRed:0x33/255.0f green:0x33/255.0f blue:0x33/255.0f alpha:1];
}

- (void)fillWithInfo:(FileBrowserInfo *)info {
    if (info.isFolder) {
        [self.imageView setImage:[UIImage imageNamed:@"clouddisk_icon_folder"]];
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"clouddisk_icon_txt"]];
    }
    
    self.label.text = info.fileName;
}

@end
