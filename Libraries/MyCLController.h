//
//  MyCLController.h
//  rawr
//
//  Created by Justin Huang on 6/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol MyCLControllerDelegate 
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end


@interface MyCLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
    __unsafe_unretained id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;  
@property (nonatomic, assign) id  delegate;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

@end
