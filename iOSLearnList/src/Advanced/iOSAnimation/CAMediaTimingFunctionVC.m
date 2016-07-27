//
//  CAMediaTimingFunctionVC.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/27.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "CAMediaTimingFunctionVC.h"

@interface CAMediaTimingFunctionVC ()
@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer1;

@property (nonatomic, strong) CALayer *ballLayer;
@end

@implementation CAMediaTimingFunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //create a red layer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    
    _layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:_layerView];
    
    _colorLayer1 = [CALayer layer];
    
    self.colorLayer1.frame = CGRectMake(50.0f, 50.0f, 50.0f, 50.0f);
    self.colorLayer1.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer1];
    
    
    
    self.ballLayer = [CALayer layer];
    _ballLayer.frame = CGRectMake(200, 0, 100, 100);
    _ballLayer.cornerRadius = 50;
    _ballLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:_ballLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //configure the transaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25f];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //set the position
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    //commit transaction
    [CATransaction commit];
    [self changeColor];
    
//    [self animate];
    _ballLayer.position = self.colorLayer.position;
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    _ballLayer.position = point;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animate];
}

- (void)changeColor
{
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.timingFunctions = @[fn, fn, fn];
    //apply animation to layer
    [self.colorLayer1 addAnimation:animation forKey:nil];
}

//functionWithControlPoints
float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

-(id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    
    return (time < 0.5)? fromValue: toValue;

}

- (void)animate
{
    
    //create keyframe animation
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = 1.0;
//    animation.delegate = self;
//    animation.values = @[
//                         [NSValue valueWithCGPoint:CGPointMake(150, 50)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
//                         ];
//    animation.timingFunctions = @[
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
//                                  ];
//    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
//    //apply animation
//    _ballLayer.position = CGPointMake(150, 268);
//    [_ballLayer addAnimation:animation forKey:nil];
    
    
    NSValue *fromValue = [NSValue valueWithCGPoint:_ballLayer.position];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(_ballLayer.position.x, 300)];
    
    CFTimeInterval duration = 1.0;
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (NSUInteger i = 0; i < numFrames; i++) {
        float time = 1.0f/(float)numFrames * i;
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    
    
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = frames;
    //apply animation
    [self.ballLayer addAnimation:animation forKey:nil];
}



@end
