//
//  NNTaxisConnectionController.h
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^NNTaxisCompletionHandler)(NSArray *array, NSError *error);

@interface NNTaxisConnectionController : NSObject

+ (NSURLSessionTask *) loadTaxisWithNorthEast:(CLLocationCoordinate2D)northEast southWest:(CLLocationCoordinate2D)southWest withCompletionHandler
                          :(NNTaxisCompletionHandler) completionHandler;

@end
