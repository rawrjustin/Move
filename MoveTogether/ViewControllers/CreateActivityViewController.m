//
//  CreateActivityViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "CreateActivityViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MapButton.h"
#import "RecButton.h"
#import "PickDateViewController.h"
#import "PickLocationViewController.h"
#define METERS_PER_MILE 1609.344

@interface CreateActivityViewController ()

@end

@implementation CreateActivityViewController
@synthesize name,_mapView, groupCount, count, startDate, endDate, start, end;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        groupCount = 10;
        NSDate *now = [NSDate date];
        startDate = now;
        NSLog(@"start: %@", startDate);
        NSTimeInterval secondsInTwoHours = 2 * 60 * 60;
        endDate = [now dateByAddingTimeInterval:secondsInTwoHours];
    }
    return self;
}
- (id)initView{
    if ([self init]) {
                
        /*
         UIBarButtonItem *locs = [[UIBarButtonItem alloc] initWithTitle:@"Locations" style:UIBarButtonItemStylePlain target:self action:@selector(displayLocs:)];
         UIBarButtonItem *events = [[UIBarButtonItem alloc] initWithTitle:@"Events" style:UIBarButtonItemStylePlain target:self action:@selector(displayEvents:)];
         
         self.navigationItem.rightBarButtonItem = events;
         self.navigationItem.leftBarButtonItem = locs;
         */
    }
    return self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleStartanActivity"]
                                                  forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavBar];
    [self initNameField];
    [self initDateButtons];
    [self initMapView];
    [self initRecommended];
    [self initMaxGroup];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    [_mapView addGestureRecognizer:tap];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)initMaxGroup{
    UILabel *maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 350, 140, 25)];
    maxLabel.text = @"MAX GROUP SIZE";
    maxLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16];
    maxLabel.textColor = [UIColor grayColor];
    
    UIButton *minus = [UIButton buttonWithType:UIButtonTypeCustom];
    minus.frame = CGRectMake(180, 345, 33, 33);
    minus.backgroundColor = [UIColor clearColor];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"moveGroupMinus"];
    [minus setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
    UIImage *buttonImagePressed = [UIImage imageNamed:@"moveGroupMinusSelected"];
    [minus setBackgroundImage:buttonImagePressed forState:UIControlStateHighlighted];
    [minus addTarget:self action:@selector(minusGroup) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
    plus.frame = CGRectMake(270, 345, 33, 33);
    plus.backgroundColor = [UIColor clearColor];
    UIImage *buttonImageNormalP = [UIImage imageNamed:@"moveGroupPlus"];
    [plus setBackgroundImage:buttonImageNormalP forState:UIControlStateNormal];
    UIImage *buttonImagePressedP = [UIImage imageNamed:@"moveGroupPlusSelected"];
    [plus setBackgroundImage:buttonImagePressedP forState:UIControlStateHighlighted];
    [plus addTarget:self action:@selector(addGroup) forControlEvents:UIControlEventTouchUpInside];
    
    count = [[UILabel alloc] initWithFrame:CGRectMake(230, 348, 25, 30)];
    count.text = [NSString stringWithFormat:@"%d", groupCount];
    count.font = [UIFont fontWithName:@"ProximaNova-Bold" size:20];
    count.textColor = [UIColor redColor];
    [self.view addSubview:count];
    [self.view addSubview:plus]; 
    [self.view addSubview:minus]; 
    [self.view addSubview:maxLabel];
    
}
-(void)initRecommended{
    UIView *recView = [[UIView alloc] initWithFrame:CGRectMake(5, 285, 310, 45)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"moveSingleBar"]];
    recView.backgroundColor = background;
    RecButton *rec = [[RecButton alloc] initWithFrame:CGRectMake(0, 0, 310, 45)];
    [recView addSubview:rec];
    [self.view addSubview:recView];
}
-(void)initMapView{
    UIView *mapContainer = [[UIView alloc] initWithFrame:CGRectMake(5, 150, 310, 130)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"eventDoubleDecker"]];
    mapContainer.backgroundColor = background;
    
    
    CLLocationCoordinate2D tempLoc;
    tempLoc.latitude =37.866316;
    tempLoc.longitude= -122.256546;
    _mapView.delegate = self;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (tempLoc, 100, 100);
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(2, 2, 306, 78)];
    [_mapView setRegion:region animated:NO];
    [mapContainer addSubview:_mapView];
    
    MapButton *mapbutton = [[MapButton alloc] initWithFrame:CGRectMake(0, 82, 310, 48)];
    [mapbutton addTarget:self action:@selector(pullLocations) forControlEvents:UIControlEventTouchUpInside];
    [mapContainer addSubview:mapbutton];
    
    [self.view addSubview:mapContainer];
    
    
    //latitude = [NSString stringWithFormat:@"     Latitude= %f", coordinate.latitude]; 
    //longitude = [NSString stringWithFormat:@"     Longitude= %f", coordinate.longitude];
    
}

- (void)pullLocations{
    PickLocationViewController *locView = [[PickLocationViewController alloc] initWithNibName:nil bundle:nil];
    [[self navigationController] pushViewController:locView animated:YES];
}
-(void)initDateButtons{
    NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm a"];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-DD-YYYY"];
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(5, 60, 309, 84)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"moveDateBar"]];
    dateView.backgroundColor = background;
    start = [[MoveDateButton alloc] initWithFrame:CGRectMake(14, 60, 145, 84)];
    start.tag = 0;

    start.title.text = @"BEGIN EVENT";
    start.time.text = [timeFormatter stringFromDate:startDate];
    NSLog(@"date formatter: %@", [dateFormatter stringFromDate:startDate]);
    [start addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    end = [[MoveDateButton alloc] initWithFrame:CGRectMake(169, 60, 145, 84)];

    end.tag = 1;
    end.title.text = @"END";
    end.time.text = [timeFormatter stringFromDate:endDate];
    [end addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    [self.view addSubview:dateView];
    [self.view addSubview:start];
    [self.view addSubview:end];
}
-(void)showDatePicker:(id)sender{
    NSInteger startInt = ((UIControl*)sender).tag;
    if(startInt == 1){
        PickDateViewController *startdateController = [[PickDateViewController alloc] initAsStart:YES];
        UINavigationController *dateNav = [[UINavigationController alloc] initWithRootViewController:startdateController];
        PickDateViewController *enddateController = [[PickDateViewController alloc] initAsStart:NO];
        startdateController.delegate = self;
        enddateController.delegate = self;
        [dateNav pushViewController:enddateController animated:NO];
        [self presentModalViewController:dateNav animated:YES];

        //[[self navigationController] pushViewController:dateController animated:YES];
    }
    else {
        PickDateViewController *startdateController = [[PickDateViewController alloc] initAsStart:YES];
        UINavigationController *dateNav = [[UINavigationController alloc] initWithRootViewController:startdateController];
        [self presentModalViewController:dateNav animated:YES];

        //[[self navigationController] pushViewController:dateController animated:YES];
    }

}

-(void)initNameField{
    UIView *nameFieldView = [[UIView alloc] initWithFrame:CGRectMake(5, 10, 310, 45)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"moveSingleBar"]];
    nameFieldView.backgroundColor = background;
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(0, 8, 310, 45)];
    name.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:22];
    name.textColor = [UIColor grayColor];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    name.leftView = paddingView;
    name.leftViewMode = UITextFieldViewModeAlways;
    [nameFieldView addSubview:name];
    [self.view addSubview:nameFieldView];
}
-(void)initNavBar{
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setFrame:CGRectMake(100, 0, 54, 27)];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setImage:[UIImage imageNamed:@"iconCancel2"] forState:UIControlStateNormal];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIButton *create = [UIButton buttonWithType:UIButtonTypeCustom];
    [create setFrame:CGRectMake(100, 0, 54, 27)];
    [create addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [create setImage:[UIImage imageNamed:@"iconCreate"] forState:UIControlStateNormal];
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithCustomView:create];
    self.navigationItem.rightBarButtonItem = createButton;

}

- (void)create{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)cancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)minusGroup{
    if(groupCount >0){
        groupCount = groupCount-1;
    }
    count.text = [NSString stringWithFormat:@"%d", groupCount];
}
- (void)addGroup{
    if(groupCount <50){
        groupCount = groupCount+1;
    }
    count.text = [NSString stringWithFormat:@"%d", groupCount];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dismissKeyboard {
    [name resignFirstResponder];
}


- (void) setDate: (NSDate*)datetimes asStart:(BOOL)s{
    NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    if(s){
        start.day.text = [dateFormatter stringFromDate:datetimes];
        start.time.text = [timeFormatter stringFromDate:datetimes];
    }
    else{
        end.day.text = [dateFormatter stringFromDate:datetimes];
        end.time.text = [timeFormatter stringFromDate:datetimes];
    }
    
}
@end
