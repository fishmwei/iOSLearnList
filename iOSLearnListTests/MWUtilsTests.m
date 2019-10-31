//
//  MWUtilsTests.m
//  iOSLearnListTests
//
//  Created by huangmingwei on 2019/10/22.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MWUtils.h"

@interface MWUtilsTests : XCTestCase

@end

@implementation MWUtilsTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testExample {
    XCTAssertTrue([@"121" isPalindrome]);
    XCTAssertTrue([@"a" isPalindrome]);
    XCTAssertTrue([@"aa" isPalindrome]);
    XCTAssertTrue([@"" isPalindrome]);
    XCTAssertFalse([@"112" isPalindrome]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
