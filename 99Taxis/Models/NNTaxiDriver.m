//
//  NNTaxiDriver.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import "NNTaxiDriver.h"
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation NNTaxiDriver

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{@"driverAvailable":@"driverAvailable",
             @"driverId":@"driverId",
             @"latitude":@"latitude",
             @"longitude":@"longitude"};
}


- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (NSString *)title {

    return [NSString stringWithFormat:@"Taxista id:%@", self.driverId];
}

@end
