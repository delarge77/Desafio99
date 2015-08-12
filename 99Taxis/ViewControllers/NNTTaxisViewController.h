//
//  ViewController.h
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNBaseViewController.h"
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NNTTaxisViewController : NNBaseViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

