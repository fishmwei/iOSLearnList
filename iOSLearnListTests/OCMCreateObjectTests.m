//
//  OCMCreateObjectTests.m
//  iOSLearnList
//
//  Created by mingwei on 2017/2/4.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ocmA.h"
#import "ocmB.h"

@interface OCMCreateObjectTests : XCTestCase

@end

@implementation OCMCreateObjectTests

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {
    
    [super tearDown];
}

- (void)testExample {
    ocmA *a = [[ocmA alloc] init];
    
    id stubB = OCMClassMock([ocmB class]);
    a.b = stubB;
    OCMStub([stubB name]).andReturn(@"test stub name");
    
    NSString *ret = [a name];
    XCTAssertTrue([ret isEqualToString:@"test stub name"]);
    [stubB stopMocking];
//    ret = [a name];
//    XCTAssertFalse([ret isEqualToString:@"test stub name"]);
}

- (void)testVerify {
    ocmA *a = [[ocmA alloc] init];
    
    //整个类的name返回都是test stub name
    id stubB = OCMClassMock([ocmB class]);
    OCMStub([stubB name]).andReturn(@"test stub name");
    
    
    a.b = stubB;
    NSString *ret = [a name];
    XCTAssertTrue([ret isEqualToString:@"test stub name"]);
    
    //停止
    [stubB stopMocking];
    
    ocmB *realB = [[ocmB alloc] init];
    stubB = OCMPartialMock(realB);
    a.b = realB;
    OCMStub([stubB name]).andReturn(@"test stub name");
    ret = [a name];
    XCTAssertTrue([ret isEqualToString:@"test stub name"]); //打桩返回打桩的
    OCMVerify([stubB name]);
    [stubB stopMocking];
    ret = [a name];
    XCTAssertFalse([ret isEqualToString:@"test stub name"]); //不打桩了 正常
 
}


- (void)testVerifyExpect {
    ocmA *a = [[ocmA alloc] init];
    
    //整个类的name返回都是test stub name
    id stubB = OCMClassMock([ocmB class]);
    OCMExpect([stubB name]).andReturn(@"haha");
    a.b = stubB;
    
    [a name];
    OCMVerifyAll(stubB);
    OCMVerify([stubB name]);
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
