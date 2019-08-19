//
//  ParentViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/14.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "ParentViewController.h"
#import "ChildViewController.h"

@interface ParentViewController ()
@property (nonatomic, strong) ChildViewController *child;

@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 60, 100, 30);
    [btn setTitle:@"Add" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addChildVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(110, 60, 200, 30);
    [btn setTitle:@"Remove" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removeChildVC) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *prefix = @"com.nd.sdp.plugin";
    NSString *path = @"baidu.com";
    
    path = [prefix stringByAppendingPathExtension:path];
    NSLog(@"%@", path);
    
    
    
    NSArray *unsortData = @[@(9),  @(20), @(10), @(8), @(7), @(20), @(20)];
    
    NSArray *sortedData = [unsortData sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2){
//        return [obj2 compare:obj1];
        
//        return [obj1 integerValue] < obj2.integerValue;
        
        if ([obj2 integerValue] < obj1.integerValue) {
            return NSOrderedAscending;
        } else if (obj2.integerValue > obj1.integerValue) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    NSLog(@"%@", sortedData);
    
    [self addChildVC];
}


- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
}

- (ChildViewController *)child {
    
    if (!_child) {
       _child = [ChildViewController new];
    }
    return _child;
}

- (void)addChildVC {
    
    
    [self addChildViewController:self.child];
    [self.view addSubview:self.child.view];
    [self.child didMoveToParentViewController:self];
    
    // contraint
    self.child.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // masConstraint ??
    [self.view addConstraints: @[
                                  [NSLayoutConstraint constraintWithItem:self.child.view
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:100],
                                  [NSLayoutConstraint constraintWithItem:self.child.view
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1
                                                                constant:0],
                                  [NSLayoutConstraint constraintWithItem:self.child.view
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1
                                                                constant:0],
                                  [NSLayoutConstraint constraintWithItem:self.child.view
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1
                                                                constant:0],

                                  ]];
}

- (void)removeChildVC {
    
    [self.child removeFromParentViewController];
    [self.child.view removeFromSuperview];
}



@end
