//
//  MWBasePresentViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/6/21.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWBasePresentViewController.h"
#import "MWPresentAnimation.h"

@interface MWBasePresentViewController () <UIViewControllerTransitioningDelegate> {
    UILabel *titleLabel;
    UIView *bottomView;
}

@property (nonatomic, retain) MWPresentAnimation *presentAnimation;
@end

@implementation MWBasePresentViewController

#pragma mark - UI
#pragma mark  Autorotate
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0) {
    return UIInterfaceOrientationMaskPortrait;
    //UIInterfaceOrientationMaskPortrait
}

-(BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0) {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMyData];
//    [self setupMyUI];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 10;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 20)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"Btn" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    if (self) {
        self.presentAnimation = [[MWPresentAnimation alloc] init];
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.showRect = CGRectZero;
    }
    
    return self;
}


#pragma mark -Data
- (void)setupMyData
{
    if (CGRectEqualToRect(self.showRect, CGRectZero))
    {
        self.showRect = self.view.bounds;
    }
    
    
    
    
    
    
}


#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.presentAnimation.type = MWAnimationPresent;
    self.presentAnimation.modalFrame = self.showRect;
    
    return self.presentAnimation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presentAnimation.type = MWAnimationDismiss;
    self.presentAnimation.modalFrame = self.showRect;
    
    return self.presentAnimation;
}


- (void)btnPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
