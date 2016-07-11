//
//  caLayerViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "caLayerViewController.h"

@interface caLayerViewController ()

@end

@implementation caLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set the corner radius on our layers
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    //add a border to our layers
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    
    //add a shadow to layerView1
    self.layerView1.layer.shadowOpacity = 0.5f;
    self.layerView1.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layerView1.layer.shadowRadius = 5.0f;
    
    
    //add same shadow to shadowView (not layerView2)
    self.shadowView.layer.shadowOpacity = 0.5f;
    self.shadowView.layer.shadowOffset = CGSizeMake(5.0f, -5.0f);
    self.shadowView.layer.shadowRadius = 5.0f;
    self.shadowView.backgroundColor = [UIColor clearColor];
//    self.shadowView.layer.masksToBounds = YES;
    
    //enable clipping on the second layer
    self.layerView2.layer.masksToBounds = YES;
    
    CGMutablePathRef circlepath = CGPathCreateMutable();
//    CGPathAddEllipseInRect(circlepath, NULL, self.shadowPathView.bounds);
    CGPathAddRect(circlepath, NULL, self.shadowPathView.bounds);
    self.shadowPathView.layer.shadowPath = circlepath;
    self.shadowPathView.layer.shadowOpacity = 0.5;
    self.shadowPathView.layer.shadowOffset = CGSizeMake(0.0f, -15.0f);
    self.shadowPathView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2f];
    CGPathRelease(circlepath);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
