//
//  ObjectStubATests.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ObjectStubA.h"


@interface ObjectStubATests : XCTestCase
{
    ObjectStubA *a;
    ObjectStubA *b;
}

@end


@implementation ObjectStubATests

- (void)setUp {
    [super setUp];

    a = [[ObjectStubA alloc] initWithName:@"a"];
    b = [[ObjectStubA alloc] initWithName:@"b"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    id stubAMock = OCMClassMock([ObjectStubA class]);
    ObjectStubA *stub = [[ObjectStubA alloc] initWithName:@"stub"];

    OCMStub([stubAMock stubA:[OCMArg any]]).andReturn(stub);

    ObjectStubA *test = [ObjectStubA stubA:@"test"];
    [test showName];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
