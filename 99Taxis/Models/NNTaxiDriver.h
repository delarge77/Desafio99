//
//  NNTaxiDriver.h
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NNTaxiDriver : MTLModel <MTLJSONSerializing, MKAnnotation>

@property (nonatomic, readonly, getter=isAVailable) BOOL driverAvailable;
@property (nonatomic, copy, readonly) NSNumber *driverId;
@property (nonatomic, readonly) float latitude;
@property (nonatomic, readonly) float longitude;

- (NSString *)title;

@end
