//
//  undoRedoViewController.m
//  iOSLearnList
//
//  Created by mingwei on 16/5/10.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import "undoRedoViewController.h"


@interface undoRedoViewController ()
{
    NSUndoManager *undoMnt;
}

@property (nonatomic, retain) UILabel *showLabel;
@property (nonatomic, assign) NSInteger count;

@end


@implementation undoRedoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    undoMnt = [[NSUndoManager alloc] init];

    self.view.backgroundColor = [UIColor grayColor];


    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 20)];
    [self.view addSubview:self.showLabel];
    self.showLabel.backgroundColor = [UIColor whiteColor];
    self.showLabel.textAlignment = NSTextAlignmentCenter;


    [self updateShowLabel];


    CGFloat offsetX = 10;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, CGRectGetMaxY(self.showLabel.frame), 50, 20)];

    [btn setTitle:@"add" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];


    offsetX += 60;
    btn = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, CGRectGetMaxY(self.showLabel.frame), 50, 20)];

    [btn setTitle:@"del" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(del) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    offsetX += 60;
    btn = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, CGRectGetMaxY(self.showLabel.frame), 50, 20)];

    [btn setTitle:@"undo" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(undo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];


    offsetX += 60;
    btn = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, CGRectGetMaxY(self.showLabel.frame), 50, 20)];

    [btn setTitle:@"redo" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(redo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateShowLabel {
    self.showLabel.text = [NSString stringWithFormat:@"%ld", self.count];
}


- (void)add {
    self.count += 1;
    [self updateShowLabel];

    [undoMnt registerUndoWithTarget:self selector:@selector(del) object:nil];
}

- (void)del {
    self.count -= 1;
    [self updateShowLabel];
    [undoMnt registerUndoWithTarget:self selector:@selector(add) object:nil];
}


- (void)undo {
    [undoMnt undo];
}

- (void)redo {
    [undoMnt redo];
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
