//
//  PickLocationViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 4/26/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "GDataXMLNode.h"
#import "MyCLController.h"
@interface PickLocationViewController : UIViewController<MKMapViewDelegate,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    MKMapView *mapView;
    UITableView *locTable;
    NSString *keyword;
    UITextField *searchField;
    NSMutableArray *searchData;
    NSMutableArray *placesOutputArray;
    GDataXMLDocument *xmlDocument;
    MyCLController *locationController;
}
@property (nonatomic, strong) GDataXMLDocument *xmlDocument;
@property (nonatomic, strong) UITableView *locTable;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) NSMutableArray *placesOutputArray;
@property (nonatomic) MKMapView *mapView;
@property (nonatomic, strong) NSString *keyword;

- (void)setupView;
-(void)save:(id)sender;
- (void)grabURLInBackground:(id)sender;

@end
