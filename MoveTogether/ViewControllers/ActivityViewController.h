//
//  ActivityViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 5/1/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MoveDateButton.h"
#import "MapButton.h"
@interface ActivityViewController : UIViewController<MKMapViewDelegate>{
    UIButton *profile;
    UILabel *name;
    UILabel *location;
    MKMapView *mapView;
    MoveDateButton *start;
    MoveDateButton *end;
}

@property(nonatomic, strong) MoveDateButton *start;
@property(nonatomic, strong) MoveDateButton *end;

@property(nonatomic, strong) UIButton *profile;
@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UILabel *location;
-(void)setupNavBar;
-(void)setupTopProfile;
-(void)initDateButtons;
-(void)initMapView;
@end
