//
//  ReversibleString.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/9.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "ReversibleString.h"


@implementation ReversibleString
- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        content = string;
    }

    return self;
}

- (id)reversedString
{
    return [NSString stringWithFormat:@"Revere-%@", content];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = [anInvocation selector];
    if ([content respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:content];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }

    if ([self methodSignatureForSelector:aSelector] != (IMP)NULL) {
        return YES;
    }

    if ([content respondsToSelector:aSelector]) {
        return YES;
    }

    return NO;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }

    return [content methodSignatureForSelector:aSelector];
}


@end
