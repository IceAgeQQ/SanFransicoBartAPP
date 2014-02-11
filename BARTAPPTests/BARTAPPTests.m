//
//  BARTAPPTests.m
//  BARTAPPTests
//
//  Created by Chao Xu on 14-1-4.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SchedueInformationViewController.h"
@interface BARTAPPTests : XCTestCase

@end

@implementation BARTAPPTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{

    SchedueInformationViewController *sce = [[SchedueInformationViewController alloc] init];
   // XCTAssertEqual(sce.test, helloworl, @"it is equal");
    XCTAssert([sce.test isEqualToString:@"helloworld"], @"it is equal");
    XCTAssertNotEqual(sce.test, @"helloworld", @"it is not equal");
}

@end
