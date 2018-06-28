//
//  iOSLearnListTests.m
//  iOSLearnListTests
//
//  Created by mingwei on 16/5/7.
//  Copyright © 2016年 mingwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
 // TODO: http://ocmock.org/
@interface iOSLearnListTests : XCTestCase

@end

@implementation iOSLearnListTests

- (void)setUp {
    [super setUp];
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
    OCMStub([userDefaultsMock stringForKey:@"MyAppURLKey"]).andReturn(@"http://testurl");
    OCMStub([userDefaultsMock stringForKey:[OCMArg any]]).andReturn(@"http://testurl");
    OCMStub([userDefaultsMock standardUserDefaults]).andReturn(userDefaultsMock);
    
    NSLog(@"value is %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"a"]);
    
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"key"];
    XCTAssertTrue([value isEqualToString:@"http://testurl"]);
    [userDefaultsMock stopMocking];
}

- (void)testExampleReference {
    id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
    NSString *key= @"hello";
//    OCMStub([userDefaultsMock stringForKey:[OCMArg setTo:@"hello"]]);
    
    
    
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    XCTAssertTrue([value isEqualToString:@"http://testurl"]);
    
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
