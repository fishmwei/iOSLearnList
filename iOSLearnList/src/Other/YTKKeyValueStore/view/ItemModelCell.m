//
//  ItemModelCell.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/27.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "ItemModelCell.h"
#import <Masonry/Masonry.h>
#import "ItemModel.h"

@interface ItemModelCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *positionLabel;

@end

@implementation ItemModelCell

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
    
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *maker) {
        //        maker.height.equalTo(self.mas_height);
        maker.top.equalTo(self.mas_top).offset(15);
        maker.height.equalTo(@(20));
        maker.left.equalTo(self.mas_right).offset(-15);
        maker.left.equalTo(self.mas_left).offset(15);
    }];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = [UIColor colorWithRed:0x33/255.0f green:0x33/255.0f blue:0x33/255.0f alpha:1];
    
    self.positionLabel = [UILabel new];
    [self addSubview:self.positionLabel];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        maker.height.equalTo(@(20));
        maker.left.equalTo(self.mas_right).offset(-15);
        maker.left.equalTo(self.mas_left).offset(15);
    }];
    self.positionLabel.font = [UIFont systemFontOfSize:15];
    self.positionLabel.textColor = [UIColor colorWithRed:0x33/255.0f green:0x33/255.0f blue:0x33/255.0f alpha:1];

}

- (void)fillWithInfo:(id)info {
    ItemModel *model = (ItemModel *)info;
    self.nameLabel.text = [NSString stringWithFormat:@"姓名: %@", model.name];
    self.positionLabel.text = [NSString stringWithFormat:@"职位: %@", model.position];
}


@end
