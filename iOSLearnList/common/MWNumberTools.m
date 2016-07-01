//
//  MWNumberTools.m
//  iOSLearnList
//
//  Created by mingwei on 16/7/1.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWNumberTools.h"

@implementation MWNumberTools

+ (NSString *)stringOfFloat:(CGFloat)value withDecimal:(NSUInteger)num {
    
    if(fmodf(value, 1.0f) < 0.000001) {//小数位数为0
        return [NSString stringWithFormat:@"%0.0f", value];
    }
    
    NSString *fmt = [NSString stringWithFormat:@"%%0.%ldf", num];
    NSString *strValue = [NSString stringWithFormat:fmt, value];
    
    
    NSString *endStr = [strValue substringFromIndex:[strValue length] - 1];
    while ([endStr isEqualToString:@"0"]) {
        strValue = [strValue substringToIndex:[strValue length] - 1];
        endStr = [strValue substringFromIndex:[strValue length] - 1];
    }
    
    return strValue;
}


@end
