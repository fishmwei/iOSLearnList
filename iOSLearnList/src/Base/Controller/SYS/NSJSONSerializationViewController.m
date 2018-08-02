//
//  NSJSONSerializationViewController.m
//  iOSLearnList
//
//  Created by mingwei on 2016/10/24.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "NSJSONSerializationViewController.h"


@interface NSJSONSerializationViewController ()
{
    dispatch_queue_t dispatchQueue;
    UITextView *showView;
}
@end


@implementation NSJSONSerializationViewController
- (void)viewDidLoad
{
    [super viewDidLoad];


    [self setupData];
    [self setupUI];
}

- (void)setupData
{
    dispatchQueue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_CONCURRENT);
}

- (void)setupUI
{
    showView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    [self.view addSubview:showView];

    dispatch_async(dispatchQueue, ^{
        NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/subject/25881786"];
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
            NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            dispatch_async(dispatch_get_main_queue(), ^{

                showView.text = [NSString stringWithFormat:@"%@", resp];
            });

        }];
        [task resume];
    });
}

- (void)showAppend:(NSString *)str
{
    NSString *text = showView.text;
    showView.text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", str]];
}
@end
