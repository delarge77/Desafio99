//
//  NNTaxisConnectionControllerTests.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/12/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NNTaxisConnectionController.h"
#import "OHHTTPStubs.h"
#import <CoreLocation/CoreLocation.h>

@interface NNTaxisConnectionControllerTests : XCTestCase

@end

@implementation NNTaxisConnectionControllerTests

- (void)testShouldReturnConnectionErrorWhenURLErrorDomainIsReturned {
    
    CLLocationCoordinate2D  northEast = CLLocationCoordinate2DMake(-23.612474, -46.702746);
    CLLocationCoordinate2D  southWest = CLLocationCoordinate2DMake(-23.589548, -46.673392);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should return connection error when not connected"];
    
    NSURLSessionTask *task = [NNTaxisConnectionController loadTaxisWithNorthEast:northEast southWest:southWest withCompletionHandler:^(NSArray *array, NSError *error) {
        
        XCTAssertNil(array);
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.userInfo[NSLocalizedDescriptionKey], NSLocalizedString(@"Parece que você está sem internet! Por favor, verifique a sua conexão e tente novamente.", nil));
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        [task cancel];
    }];
    
}

@end
