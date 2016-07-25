//
//  caLayerViewController.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBaseViewController.h"

@interface caLayerViewController : MWBaseViewController

@property (nonatomic, weak) IBOutlet UIView *layerView1;
@property (nonatomic, weak) IBOutlet UIView *layerView2;
@property (nonatomic, weak) IBOutlet UIView *shadowView;

@property (nonatomic, weak) IBOutlet UIView *shadowPathView;

@property (nonatomic, weak) IBOutlet UIButton *maskBtn;

@property (nonatomic, weak) IBOutlet UIView *D3View;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *faces;


@property (nonatomic, weak) IBOutlet UIView *shapeView;

- (IBAction)maskBtnPressed:(id)sender;

@end
