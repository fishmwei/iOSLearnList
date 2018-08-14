//
//  iOSLearnListTests.m
//  iOSLearnListTests
//
//  Created by huangmingwei on 17/1/25.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "myBundleFrame.h"


@interface iOSLearnListTests : XCTestCase
{
    myBundleFrame *test;
}
@end


@implementation iOSLearnListTests

- (void)setUp
{
    [super setUp];

    test = [[myBundleFrame alloc] init];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    id mock = OCMPartialMock(test);
    OCMStub([mock showBundleframe]).andDo(^(NSInvocation *invocation) {
        NSLog(@"OCMostub showbundleframe");
    });


    [test showBundleframe];
}

- (void)testPerformanceExample
{
    [test showBundleframe];

    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
