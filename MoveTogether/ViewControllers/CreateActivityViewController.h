//
//  CreateActivityViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PickDateViewController.h"
#import "MoveDateButton.h"
@interface CreateActivityViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, DateDelegate>{
    UITextField *name;
    MKMapView *_mapView;
    UILabel *count;
    int groupCount;
    NSDate *startDate;
    NSDate *endDate;
    MoveDateButton *start;
    MoveDateButton *end;
}
@property (nonatomic, retain) MoveDateButton *start;
@property (nonatomic, retain) MoveDateButton *end;

@property (nonatomic, retain) UITextField *name;
@property (nonatomic) MKMapView *_mapView;
@property (nonatomic) int groupCount;
@property (nonatomic, retain) UILabel *count;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *startDate;

-(id) initView;
-(void)initNameField;
-(void)initDateButtons;
-(void)initMapView;
-(void)initRecommended;
-(void)initMaxGroup;
-(void)pullLocations;
-(void)showDatePicker:(id)sender;

- (void)cancel:(id)sender;

@end
