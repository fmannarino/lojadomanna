//
//  NavigationViewControllerTests.m
//  lojadomanna
//
//  Created by Felipe Mannarino on 5/9/16.
//  Copyright © 2016 Felipe Mannarino. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NavigationViewController.h"
#import "JSONKit.h"

@interface NavigationViewControllerTests : XCTestCase

@end

@implementation NavigationViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckUser {
    NavigationViewController *navigation = [[NavigationViewController alloc] init];
    XCTAssertTrue([navigation checkUser], @"Logado");
}

@end
