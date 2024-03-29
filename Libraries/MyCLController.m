//
//  MyCLController.m
//  rawr
//
//  Created by Justin Huang on 6/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "MyCLController.h"


@implementation MyCLController

@synthesize locationManager;
@synthesize delegate;
- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self; // send loc updates to myself
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self.delegate locationUpdate:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self.delegate locationError:error];
}


@end