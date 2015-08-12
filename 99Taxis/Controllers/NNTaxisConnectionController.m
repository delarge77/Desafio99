//
//  NNTaxisConnectionController.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import "NNTaxisConnectionController.h"
#import "NNTaxisConnectionClient.h"
#import "MTLJSONAdapter.h"
#import "NNTaxiDriver.h"

@implementation NNTaxisConnectionController

+ (NSURLSessionTask *) loadTaxisWithNorthEast:(CLLocationCoordinate2D)northEast southWest:(CLLocationCoordinate2D)southWest withCompletionHandler
                               :(NNTaxisCompletionHandler) completionHandler {
    
    [[[NNTaxisConnectionClient sharedClient] operationQueue] cancelAllOperations];
    
    NSString *locationString = [NSString stringWithFormat:@"lastLocations?ne=%f,%f&sw=%f,%f", northEast.latitude,northEast.longitude,southWest.latitude,southWest.longitude];
    
    return [[NNTaxisConnectionClient sharedClient] GET:locationString
                            parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   
                                   NSError *error = nil;
                                   NSArray *result = [MTLJSONAdapter modelsOfClass:[NNTaxiDriver class]
                                                                     fromJSONArray:responseObject
                                                                             error:&error];
                                   completionHandler(result, nil);
                                   
                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   error = [self buildConnectionProblemError];
                                   completionHandler(nil, error);
                               }];

}

+ (NSError *)buildConnectionProblemError {
    NSDictionary *userInfo =
    @{NSLocalizedDescriptionKey : NSLocalizedString(@"Parece que você está sem internet! Por favor, verifique a sua conexão e tente novamente.", nil)};
    
    return [NSError errorWithDomain:@"br.com.99taxis:NNTaxisConnectionControllerErrorDomain"
                               code:404
                           userInfo:userInfo];
}

@end
