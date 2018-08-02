//
//  ReversibleString.h
//  iOSLearnList
//
//  Created by mingwei on 16/5/9.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ReversibleString : NSObject
{
    NSString *content;
}

- (id)initWithString:(NSString *)string;

- (id)reversedString;

@end
