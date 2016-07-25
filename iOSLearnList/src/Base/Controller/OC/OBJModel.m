//
//  OBJModel.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "OBJModel.h"

@implementation OBJModel


- (void)mehtod1Test {
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

//
//-(NSInteger)mehtod2Test
//
//{
//    
//    NSLog(@"OBJModel method2Test");
//    
//    return 1;
//    
//}
//
//-(id)method3Test:(NSString*)str {
//    
//    NSLog(@"OBJModel 参数:%@",str);
//    
//    return self.ctl;
//    
//}

- (void)unknown {
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

@end
