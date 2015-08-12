//
//  NNTaxisConnectionClient.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import "NNTaxisConnectionClient.h"
#import "AFNetworkActivityIndicatorManager.h"

NSString *NNTaxisClientURL = @"https://api.99taxis.com/";

@implementation NNTaxisConnectionClient

+ (instancetype)sharedClient {
    static NNTaxisConnectionClient * _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NNTaxisConnectionClient alloc] initWithBaseURL:[NSURL URLWithString:NNTaxisClientURL]];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    }
    
    return self;
}

@end
