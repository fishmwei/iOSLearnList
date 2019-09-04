//
//  NSString+MWUtils.h
//  iOSLearnList
//
//  Created by huangmingwei on 2019/9/4.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MWUtils)

// 是否回文
- (BOOL)isPalindrome;

// 是否回文, 忽略大小写
- (BOOL)isPalindromeI;

@end

NS_ASSUME_NONNULL_END
