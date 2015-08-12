//
//  CLLocation+NNTaxis.h
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKGeometry.h>

@interface CLLocation (NNTaxis)

extern const CLLocationCoordinate2D CLNorthWestCoordinateFromRegion(MKCoordinateRegion region);
extern const CLLocationCoordinate2D CLSouthWestCoordinateFromRegion(MKCoordinateRegion region);
extern const CLLocationCoordinate2D CLSouthEastCoordinateFromRegion(MKCoordinateRegion region);
extern const CLLocationCoordinate2D CLNorthEastCoordinateFromRegion(MKCoordinateRegion region);

@end
