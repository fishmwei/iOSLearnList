//
//  TestCreateObjectAsync.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/10/13.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "TestCreateObjectAsync.h"
#import "TestObjectSellerProtocol.h"
#import "TestObjectFacotry.h"


@interface TestSeller : NSObject <TestObjectSellerProtocol>
{
    NSInteger seq;
}
@end


@implementation TestSeller

static NSInteger gseq = 0;
- (instancetype)init {
    self = [super init];
    if (self) {
        seq = gseq++;
    }

    return self;
}

- (void)receiveObject:(id)object {
    NSLog(@"======== seller %ld  Finish ========", seq);
}

@end


@interface TestCreateObjectAsync () <TestObjectSellerProtocol>
@property (nonatomic, strong) NSMutableArray *objectPool;


@end


@implementation TestCreateObjectAsync

- (void)viewDidLoad {
    [super viewDidLoad];

    self.objectPool = [NSMutableArray array];

    self.view.backgroundColor = [UIColor whiteColor];

    [self addButton:@"add" selector:@selector(add) react:CGRectMake(0, 100, 200, 50)];
}

- (void)addButton:(NSString *)title selector:(SEL)selector react:(CGRect)react {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = react;

    [self.view addSubview:btn];
}

- (void)add {
    for (int i = 0; i < 3; i++)
        [[TestObjectFacotry sharedInstance] addListener:[TestSeller new]];
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
