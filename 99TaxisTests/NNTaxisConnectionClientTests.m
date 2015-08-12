//
//  NNTaxisConnectionClientTests.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/12/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NNTaxisConnectionClient.h"
#import <CoreLocation/CoreLocation.h>

@interface NNTaxisConnectionClientTests : XCTestCase

@end

@implementation NNTaxisConnectionClientTests

- (void)testAsynchronousURLConnection {
    
    CLLocationCoordinate2D  northEast = CLLocationCoordinate2DMake(-23.612474, -46.702746);
    CLLocationCoordinate2D  southWest = CLLocationCoordinate2DMake(-23.589548, -46.673392);

    NSString *locationString = [NSString stringWithFormat:@"lastLocations?ne=%f,%f&sw=%f,%f", northEast.latitude,northEast.longitude,southWest.latitude,southWest.longitude];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should be able to make requests"];
    NSString *path = locationString;
    NSURLSessionDataTask *task = [[NNTaxisConnectionClient sharedClient] GET:path
                                                         parameters:nil
                                                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                XCTAssertNotNil(responseObject, "Should not have nil response");
                                                                
                                                                NSURLResponse *response = task.response;
                                                                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                                    XCTAssertEqual(200, httpResponse.statusCode, @"Should have 200 status code response");
                                                                    
                                                                    NSString *url = httpResponse.URL.absoluteString;
                                                                    BOOL containsURLClient = [url rangeOfString:NNTaxisClientURL].location != NSNotFound;
                                                                    XCTAssertTrue(containsURLClient, @"Should request to the right URL");
                                                                    
                                                                    BOOL containsPath = [url rangeOfString:path].location != NSNotFound;
                                                                    XCTAssertTrue(containsPath, @"Should contains path when requesting");
                                                                    
                                                                    XCTAssertEqualObjects(httpResponse.MIMEType, @"application/json", @"Should have right MIMEType when requesting");
                                                                } else {
                                                                    XCTFail(@"Response was not NSHTTPURLResponse");
                                                                }
                                                                
                                                                [expectation fulfill];
                                                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                XCTFail(@"Should not fail when requesting");
                                                            }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        [task cancel];
    }];
}

@end
