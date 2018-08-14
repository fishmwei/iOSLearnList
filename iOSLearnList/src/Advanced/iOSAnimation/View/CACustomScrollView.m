//
//  CACustomScrollView.m
//  iOSLearnList
//
//  Created by mingwei on 16/8/4.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "CACustomScrollView.h"


@implementation CACustomScrollView
+ (Class)layerClass
{
    return [CAScrollLayer class];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }

    return self;
}

- (void)awakeFromNib
{
    [self setup];
}


- (void)setup
{
    self.layer.masksToBounds = YES;

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanMove:)];

    [self addGestureRecognizer:pan];
}

- (void)PanMove:(UIPanGestureRecognizer *)pan
{
    CGPoint offset = self.bounds.origin;
    offset.x -= [pan translationInView:self].x;
    offset.y -= [pan translationInView:self].y;


    [(CAScrollLayer *)self.layer scrollPoint:offset];
    [pan setTranslation:CGPointZero inView:self];
}

@end
