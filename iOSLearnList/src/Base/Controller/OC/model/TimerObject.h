//
//  TimerObject.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/9/13.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerObject : NSObject
@property (nonatomic, retain) NSTimer *timer;

- (void)cleanTimer;

@end
