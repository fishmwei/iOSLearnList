//
//  MWScrollView.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/9.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWScrollView.h"


@implementation MWScrollView

+ (Class)layerClass {
    return [CAScrollLayer class];
}

- (void)setUp {
    self.layer.masksToBounds = YES;

    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}


- (id)initWithFrame:(CGRect)frame {
    //this is called when view is created in code
    if ((self = [super initWithFrame:frame])) {
        [self setUp];
    }

    return self;
}

- (void)awakeFromNib {
    //this is called when view is created from a nib
    [self setUp];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
    CGPoint offset = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    //scroll the layer
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self];
}

@end
