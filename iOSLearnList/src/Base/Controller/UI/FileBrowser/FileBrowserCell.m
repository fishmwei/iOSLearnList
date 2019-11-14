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
    
    
//    self.nameLabel = [UILabel new];
//    [self addSubview:self.nameLabel];
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *maker) {
//        //        maker.height.equalTo(self.mas_height);
//        maker.top.equalTo(self.mas_top).offset(15);
//        maker.height.equalTo(@(20));
//        maker.left.equalTo(self.mas_right).offset(-15);
//        maker.left.equalTo(self.mas_left).offset(15);
//    }];
//    self.nameLabel.font = [UIFont systemFontOfSize:15];
//    self.nameLabel.textColor = [UIColor colorWithRed:0x33/255.0f green:0x33/255.0f blue:0x33/255.0f alpha:1];
//
//    self.positionLabel = [UILabel new];
//    [self addSubview:self.positionLabel];
//    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *maker) {
//        maker.top.equalTo(self.nameLabel.mas_bottom).offset(5);
//        maker.height.equalTo(@(20));
//        maker.left.equalTo(self.mas_right).offset(-15);
//        maker.left.equalTo(self.mas_left).offset(15);
//    }];
//    self.positionLabel.font = [UIFont systemFontOfSize:15];
//    self.positionLabel.textColor = [UIColor colorWithRed:0x33/255.0f green:0x33/255.0f blue:0x33/255.0f alpha:1];
    
}

- (void)fillWithInfo:(FileBrowserInfo *)info {
    
}



@end
