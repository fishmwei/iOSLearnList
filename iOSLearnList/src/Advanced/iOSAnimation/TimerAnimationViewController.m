//
//  TimerAnimationViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/27.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "TimerAnimationViewController.h"


@interface TimerAnimationViewController ()

@property (nonatomic, retain) UIView *ballView;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, retain) id fromValue;
@property (nonatomic, retain) id toValue;


@end


@implementation TimerAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _ballView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _ballView.center = self.view.center;
    [self.view addSubview:_ballView];

    _ballView.clipsToBounds = YES;
    _ballView.layer.cornerRadius = 50;
    _ballView.backgroundColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateAction
{
    CGFloat toY = _ballView.center.y + 500;
    toY = toY > CGRectGetMaxX(self.view.bounds) ? CGRectGetMaxX(self.view.bounds) : toY;
    _toValue = [NSValue valueWithCGPoint:CGPointMake(_ballView.center.x, toY)];

    self.duration = 1.0f;
    self.timeOffset = 0;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 / 60.0 target:self selector:@selector(Step:) userInfo:nil repeats:YES];
}

- (void)Step:(NSTimer *)timer
{
    //update time offset
    self.timeOffset = MIN(self.timeOffset + 1 / (60.0 * self.duration), 1);
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;

    time = bounceEaseOut(time);
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    self.ballView.center = [position CGPointValue];

    //stop the timer if we've reached the end of the animation
    if (self.timeOffset >= 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    _ballView.center = p;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    _ballView.center = p;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _fromValue = [NSValue valueWithCGPoint:[[touches anyObject] locationInView:self.view]];
    [self animateAction];
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

float bounceEaseOut(float t)
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
