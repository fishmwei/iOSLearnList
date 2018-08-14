//
//  MWTextButtonCell.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/10/26.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MWTextButtonCell_Delegate <NSObject>

- (void)btnPressed:(NSString *)content;

@end


@interface MWTextButtonCell : UITableViewCell

@property (nonatomic, weak) id<MWTextButtonCell_Delegate> cellDelegate;

- (void)settitle:(NSString *)title btnTitle:(NSString *)btnTitle;

@end
