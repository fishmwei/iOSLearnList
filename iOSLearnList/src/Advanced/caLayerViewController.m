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
    self.shadowView.layer.shadowOffset = CGSizeMake(5.0f, -15.0f);
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
    
    
    self.maskBtn.backgroundColor = [UIColor clearColor];
    CALayer *bLayer = [CALayer layer];
    bLayer.frame = self.maskBtn.bounds;
    [self.maskBtn.layer addSublayer:bLayer];
    bLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(10, 10, 60, 60);
    maskLayer.masksToBounds = YES;
    maskLayer.cornerRadius = 30;
    maskLayer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9f].CGColor;
    bLayer.mask = maskLayer;
    
//    self.maskBtn.layer.mask = maskLayer;
    self.maskBtn.layer.shadowOpacity = 0.5;
    self.maskBtn.layer.shadowOffset = CGSizeMake(5, -5);
    self.maskBtn.layer.shadowColor = [UIColor redColor].CGColor;
    
    //affineTransform 2D变换
    self.maskBtn.layer.affineTransform = CGAffineTransformMakeRotation(M_PI_4);
    
    CGAffineTransform t = CGAffineTransformIdentity;
    t = CGAffineTransformRotate(t, M_PI_4);
    self.maskBtn.layer.affineTransform = t;
    
    
    t = CGAffineTransformScale(t, 0.5, 0.5f);
    t = CGAffineTransformTranslate(t, 0, 50);
    self.shadowPathView.layer.affineTransform = t;
    
    
    
    //3D 变换
    
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1.0/500;
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    trans = CATransform3DRotate(trans, M_PI_4, 0, 1, 0);
//    self.D3View.layer.transform = trans;
    self.D3View.layer.shadowOpacity = 0.5;
    self.D3View.layer.shadowColor = [UIColor redColor].CGColor;
    self.D3View.layer.shadowOffset = CGSizeMake(10, 10);
    
    self.D3View.layer.affineTransform = CGAffineTransformMakeShear(1.5, 1);
    
    
    //IBOutletCollection
    
    UIView *v = self.faces[0];
    v.backgroundColor = [UIColor blueColor];
}

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)maskBtnPressed:(id)sender {
    UIAlertView *lv = [[UIAlertView alloc] initWithTitle:nil message:@"Click" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [lv show];
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
