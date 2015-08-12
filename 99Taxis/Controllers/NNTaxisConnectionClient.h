//
//  NNTaxisConnectionClient.h
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import "AFHTTPSessionManager.h"

extern NSString *NNTaxisClientURL;

@interface NNTaxisConnectionClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
