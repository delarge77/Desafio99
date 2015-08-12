//
//  ViewController.m
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/11/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import "NNTTaxisViewController.h"
#import "NNTaxisConnectionController.h"
#import "NNTaxiDriver.h"
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+NNTaxis.h"

@interface NNTTaxisViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation * currentLocation;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic) NSMutableArray *locations;

@end

@implementation NNTTaxisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self showLoadingMessage:NSLocalizedString(@"Carregando Taxistas ...", nil)];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];

    [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(updateTaxisLocation) userInfo:nil repeats:YES];
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = (CLLocation *)[locations lastObject];
    
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.currentLocation.coordinate.latitude;
    region.center.longitude = self.currentLocation.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [self.mapView setRegion:region animated:YES];
    
    [self.locationManager stopUpdatingLocation];
    
}

#pragma mark - MKMapView Delegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]){
    
        MKAnnotationView *userPin= [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"userPin"];
        userPin.image = [UIImage imageNamed:@"user-pin"];
        return userPin;
    } else {
    
        MKAnnotationView *taxiPin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"taxiPin"];
        NNTaxiDriver *taxi = (NNTaxiDriver *)annotation;
        NSString *taxiImage = [taxi isAVailable] ? @"green-car":@"red-car";
        taxiPin.image = [UIImage imageNamed:taxiImage];
        taxiPin.canShowCallout = YES;
        taxiPin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return taxiPin;
    }
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NNTaxiDriver *taxi = (NNTaxiDriver *)view.annotation;
    
    NSString *txt = [NSString stringWithFormat:@"Driver id : %@ \n Latitude: %f \n Longitude: %f \n Driver is Available %d"
                     , taxi.driverId, taxi.latitude, taxi.longitude, taxi.isAVailable];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Taxista Detalhes" message:txt
                                                   delegate:self cancelButtonTitle:nil
                                          otherButtonTitles:@"ok", nil];
    [alert show];
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self updateTaxisLocation];
}

#pragma mark - Action Methods

- (IBAction)showUserLocation:(id)sender {

    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

#pragma mark - Private Methods

- (void) updateTaxisLocation {

    CLLocationCoordinate2D northEast = CLNorthEastCoordinateFromRegion(self.mapView.region);
    CLLocationCoordinate2D southWest = CLSouthWestCoordinateFromRegion(self.mapView.region);
    
    __block NNTTaxisViewController *weakSelf = self;
    
    [NNTaxisConnectionController loadTaxisWithNorthEast:northEast southWest:southWest withCompletionHandler:^(NSArray *array, NSError *error) {
        [weakSelf dismissHud];
        if (error) {
            [weakSelf presentError:error inView:self.view];
            return;
        }
        
        [weakSelf createMultipleLocationsWithArray:array];
    }];
}

- (void) createMultipleLocationsWithArray:(NSArray *) taxis {
    
    self.locations = [NSMutableArray arrayWithArray:taxis];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.locations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
