//
//  MWNumberTools.h
//  iOSLearnList
//
//  Created by mingwei on 16/7/1.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MWNumberTools : NSObject

/**
 *  最多保留几位小数
 *
 *  @param value <#value description#>
 *  @param num   <#num description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringOfFloat:(CGFloat)value withDecimal:(NSUInteger)num;

@end
