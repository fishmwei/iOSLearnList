//
//  NSString+MWUtils.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/9/4.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "NSString+MWUtils.h"

@implementation NSString (MWUtils)

//- (NSString *)stringByApplyingTransform:(NSStringTransform)transform reverse:(BOOL)reverse
- (BOOL)isPalindrome {
    
    if (self.length == 0 || self.length == 1) {
        return YES;
    }
    
    const char *content = self.UTF8String;
    NSInteger reachIndex = self.length / 2 - 1;
    NSInteger leftIndex = 0;
    NSInteger rightIndex = self.length - 1;
    
    BOOL result = YES;
    while (leftIndex <= reachIndex) {
        if (content[leftIndex] != content[rightIndex]) {
            result = NO;
            break;
        }
        
        leftIndex++;
        rightIndex--;
    }
    
    return result;
}

- (BOOL)isPalindromeI {
    NSString *backup = [self uppercaseString];
    return [backup isPalindrome];
}
@end
