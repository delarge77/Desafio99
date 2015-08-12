//
//  CLLocation+NNTaxis.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import "CLLocation+NNTaxis.h"

@implementation CLLocation (NNTaxis)

inline const CLLocationCoordinate2D CLNorthWestCoordinateFromRegion(MKCoordinateRegion region) {
    return CLLocationCoordinate2DMake(region.center.latitude + (region.span.latitudeDelta / 2.0), region.center.longitude - (region.span.longitudeDelta / 2.0));
}

inline const CLLocationCoordinate2D CLSouthEastCoordinateFromRegion(MKCoordinateRegion region) {
    return CLLocationCoordinate2DMake(region.center.latitude - (region.span.latitudeDelta / 2.0), region.center.longitude + (region.span.longitudeDelta / 2.0));
}

inline const CLLocationCoordinate2D CLNorthEastCoordinateFromRegion(MKCoordinateRegion region) {
    return CLLocationCoordinate2DMake(region.center.latitude + (region.span.latitudeDelta / 2.0), region.center.longitude + (region.span.longitudeDelta / 2.0));
}

inline const CLLocationCoordinate2D CLSouthWestCoordinateFromRegion(MKCoordinateRegion region) {
    return CLLocationCoordinate2DMake(region.center.latitude - (region.span.latitudeDelta / 2.0), region.center.longitude - (region.span.longitudeDelta / 2.0));
}

@end
