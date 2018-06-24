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

- (BOOL)showStubForParam:(NSNumber *)param {
    return [param integerValue] < 100;
}

- (void)testExample {
    ocmA *a = [[ocmA alloc] init];
    
//    ocmB *b = [ocmB new];
 
    id stubB = OCMPartialMock(a.b);
    
//    id stubB = OCMClassMock([ocmB class]);
    OCMStub([stubB name]).andReturn(@"test stub name");
    OCMStub([stubB parseInt:100]).andReturn(@"value:100");
    OCMStub([stubB isValidNumber:[OCMArg checkWithSelector:@selector(showStubForParam:) onObject:self]]).andReturn(NO);
    
    
    NSString *ret = [a name];
    XCTAssertTrue([ret isEqualToString:@"test stub name"]);
    
    ret = [a.b parseInt:100]; // 只对100打桩
    XCTAssertTrue([ret isEqualToString:@"value:100"]);
    
    BOOL isValid = [a.b isValidNumber:@1];
    XCTAssertTrue(!isValid);
    
    [stubB stopMocking];
}

- (void)testClassMethod {
    id stubB = OCMClassMock([ocmB class]);
    OCMStub([stubB getEntryName]).andReturn(@"stub");
    
    NSString *ret = [ocmB getEntryName];
    XCTAssertTrue([@"stub" isEqualToString:ret]);
    [stubB stopMocking];
    
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
