//
//  CADisplayLinkViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "CADisplayLinkViewController.h"
#import "MWCommon.h"

#import <MWUITools/MWUITools.h>


@interface CADisplayLinkViewController ()

@property (nonatomic, retain) UIView *ballView;
@property (nonatomic, retain) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval timeOffset;
@property (nonatomic, assign) CFTimeInterval lastStep;
@property (nonatomic, retain) id fromValue;
@property (nonatomic, retain) id toValue;

@property (nonatomic, retain) UIButton *stopBtn;
@property (nonatomic, retain) MWRotationView *rotationView;


@end


@implementation CADisplayLinkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self setupBallView];
    [self setupRotationView];
    
    self.stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.stopBtn];
    self.stopBtn.frame = CGRectMake(10, 60, 50, 50);
    [self.stopBtn addTarget:self action:@selector(stopRotate) forControlEvents:UIControlEventTouchUpInside];
    
    [self.stopBtn setTitle:@"Stop" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupRotationView
{
    _rotationView = [[MWRotationView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:_rotationView];

    _rotationView.duration = 1;
        _rotationView.layer.contents = (__bridge id)[MWCommon imageNamed:@"lion"].CGImage;
//    _rotationView.layer.contents = (__bridge id)[UIImage imageNamed:@"common-PullDownRefresh"].CGImage;

    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    vv.backgroundColor = [UIColor blueColor];
    [_rotationView addSubview:vv];
    [_rotationView start];
}


- (void)setupBallView
{
    _ballView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:_ballView];
    _ballView.layer.cornerRadius = 50;
    _ballView.layer.masksToBounds = YES;
    _ballView.backgroundColor = [UIColor lightGrayColor];
    _ballView.center = self.view.center;
}

- (void)animateAction
{
    CGFloat toY = [_fromValue CGPointValue].y + 300;
    toY = toY > CGRectGetMaxY(self.view.bounds) ? CGRectGetMaxY(self.view.bounds) : toY;

    _toValue = [NSValue valueWithCGPoint:CGPointMake([_fromValue CGPointValue].x, toY)];

    //    _ballView.layer.speed = 0.1;
    self.duration = 1.0;
    self.timeOffset = 0;
    [self.timer invalidate];
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopRotate {
    if ([self.rotationView isStop]) {
        
        [self.rotationView start];
    } else {
        
        [self.rotationView stop];
    }
}

- (void)step:(CADisplayLink *)timer
{
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;

    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    float time = self.timeOffset / self.duration;
    time = [self bounceEaseOut:time];

    id position = [self interpolateFromValue:_fromValue toValue:_toValue time:time];

    self.ballView.center = [position CGPointValue];

    if (self.timeOffset >= self.duration) {
        self.timeOffset = 0;
        //        [self.timer invalidate];
        //        self.timer = nil;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.timer.paused) {
        CGPoint p = [[touches anyObject] locationInView:self.view];
        _ballView.center = p;
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.timer.paused) {
        CGPoint p = [[touches anyObject] locationInView:self.view];
        _ballView.center = p;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.timer.paused) {
        CGPoint p = [[touches anyObject] locationInView:self.view];
        _fromValue = [NSValue valueWithCGPoint:p];
        [self animateAction];
    }
}


- (float)interpolate:(float)from:(float)to:(float)time
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake([self interpolate:from.x:to.x:time], [self interpolate:from.y:to.y:time]);
            return [NSValue valueWithCGPoint:result];
        }
    }

    //provide safe default implementation
    return (time < 0.5) ? fromValue : toValue;
}

- (float)bounceEaseOut:(float)t
{
    if (t < 4 / 11.0) {
        return (121 * t * t) / 16.0;
    } else if (t < 8 / 11.0) {
        return (363 / 40.0 * t * t) - (99 / 10.0 * t) + 17 / 5.0;
    } else if (t < 9 / 10.0) {
        return (4356 / 361.0 * t * t) - (35442 / 1805.0 * t) + 16061 / 1805.0;
    }

    return (54 / 5.0 * t * t) - (513 / 25.0 * t) + 268 / 25.0;
}

@end
