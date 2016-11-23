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
    
    id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
    OCMStub([userDefaultsMock stringForKey:@"MyAppURLKey"]).andReturn(@"http://testurl");
    OCMStub([userDefaultsMock stringForKey:[OCMArg any]]).andReturn(@"http://testurl");
    OCMStub([userDefaultsMock standardUserDefaults]).andReturn(userDefaultsMock);
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"key"];
    XCTAssertTrue([value isEqualToString:@"http://testurl"]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
