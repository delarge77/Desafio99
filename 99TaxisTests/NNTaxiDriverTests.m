//
//  NNTaxiDriverTests.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/12/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NNTaxiDriver.h"

@interface NNTaxiDriverTests : XCTestCase

@end

@implementation NNTaxiDriverTests

- (void)testsShouldFailWhenChildOfBaseModelDontOverrideJSONKeyPathsByPropertyKeyMethod {
    XCTAssert([NNTaxiDriver JSONKeyPathsByPropertyKey], @"Should fail when child class don't override JSONKeyPathsByPropertyKey");
}

@end
