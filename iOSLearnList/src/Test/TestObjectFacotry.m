//
//  TestObjectFacotry.m
//  iOSLearnList
//
//  Created by huangmingwei on 17/10/13.
//  Copyright © 2017年 fishmwei. All rights reserved.
//

#import "TestObjectFacotry.h"
#import "ObjectSaveProtocol.h"

@interface TestObjectFacotry () <ObjectSaveProtocol>

@property (nonatomic, strong) NSMutableArray *objectPool;
@property (nonatomic, strong) NSMutableArray *listeners;
@property (nonatomic, strong) NSMutableArray *rawObjectPool;
@property (nonatomic, assign) NSInteger number;

@end

@implementation TestObjectFacotry


+ (instancetype)sharedInstance {
    static TestObjectFacotry *_sharedPerformance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPerformance = [[TestObjectFacotry alloc] init];
    });
    
    return _sharedPerformance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.objectPool = [NSMutableArray array];
        self.rawObjectPool = [NSMutableArray array];
        self.listeners = [NSMutableArray array];
        self.number = 0;
        
        //create first object
        [self createTestObject];
    }
    
    return self;
}

- (void)createTestObject {
    NSLog(@"==== init ======");
    TestObject *testObject = [[TestObject alloc] initWithConsumer:self];
    testObject.number = self.number++;
    [self.rawObjectPool addObject:testObject];
    NSLog(@"==== %ld raw object, add ======", self.rawObjectPool.count);
}

- (void)addListener:(id<TestObjectSellerProtocol>)listener {
    NSLog(@"==== require ======");
    if (self.objectPool.count > 0) {
        id testObject = self.objectPool[0];
        [self.objectPool removeObject:testObject];
        NSLog(@"==== %ld object consume ======", self.objectPool.count);
        NSLog(@"==== consumer imediate ======");
        [listener receiveObject:testObject];
        
        
        return;
    }
    
    NSLog(@"==== wait ======");
    [self.listeners addObject:listener];
    
    // goto create object
    [self createTestObject];
}

- (void)saveObject:(id)object {
    [self.rawObjectPool removeObject:object];
    NSLog(@"==== %ld raw object, remove ======", self.rawObjectPool.count);
    
    if (self.listeners.count > 0) {
        id listener = self.listeners[0];
        [self.listeners removeObject:listener];
        NSLog(@"==== consumer ======");
        [listener receiveObject:object];
        
        return;
    }
    
    NSLog(@"==== %ld object save ======", self.objectPool.count);
    [self.objectPool addObject:object];
}


@end
