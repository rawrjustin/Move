//
//  ActivityViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 5/1/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "ActivityViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ActivityViewController ()

@end

@implementation ActivityViewController
@synthesize profile,name,location,start, end;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self setupTopProfile];
    [self setupNavBar];
    [self initDateButtons];
    [self initMapView];
    name.text = @"Coffee & Homework";
    location.text = @"Eric Benjamin";
    [profile setImage:[UIImage imageNamed:@"settingsProfilePic"] forState:UIControlStateNormal];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)initDateButtons{
    NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm a"];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-DD-YYYY"];
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(5, 145, 309, 84)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"moveDateBar"]];
    dateView.backgroundColor = background;
    start = [[MoveDateButton alloc] initWithFrame:CGRectMake(14, 145, 145, 84)];
    start.tag = 0;
    
    start.title.text = @"BEGIN EVENT";
    start.time.text = @"4:00 PM";
    //[start addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    end = [[MoveDateButton alloc] initWithFrame:CGRectMake(169, 145, 145, 84)];
    
    end.tag = 1;
    end.title.text = @"END";
    end.time.text = @"6:00 PM";
   // [end addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.view addSubview:dateView];
    [self.view addSubview:start];
    [self.view addSubview:end];
}

-(void)initMapView{
    UIView *mapContainer = [[UIView alloc] initWithFrame:CGRectMake(5, 230, 310, 130)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"eventDoubleDecker"]];
    mapContainer.backgroundColor = background;
    
    
    CLLocationCoordinate2D tempLoc;
    tempLoc.latitude =37.866316;
    tempLoc.longitude= -122.256546;
    mapView.delegate = self;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (tempLoc, 100, 100);
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(2, 2, 306, 78)];
    [mapView setRegion:region animated:NO];
    [mapContainer addSubview:mapView];
    
    MapButton *mapbutton = [[MapButton alloc] initWithFrame:CGRectMake(0, 82, 310, 48)];
    //[mapbutton addTarget:self action:@selector(pullLocations) forControlEvents:UIControlEventTouchUpInside];
    [mapContainer addSubview:mapbutton];
    mapbutton.name.text = @"Some Starbucks or something";
    [self.view addSubview:mapContainer];
    
    
    //latitude = [NSString stringWithFormat:@"     Latitude= %f", coordinate.latitude]; 
    //longitude = [NSString stringWithFormat:@"     Longitude= %f", coordinate.longitude];
    
}

-(void)setupNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"new-navBar"]
                                                  forBarMetrics:UIBarMetricsDefault];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(100, 0, 55.5, 27)];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"iconBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backButton;

    
}
-(void)setupTopProfile{
    UIImageView *topProfileBg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 310, 130)];
    topProfileBg.image = [UIImage imageNamed:@"eventDoubleDecker"];
    [self.view addSubview:topProfileBg];
    
    profile = [UIButton buttonWithType:UIButtonTypeCustom];
    //[profile addTarget:self action:@selector(profileTap) forControlEvents:UIControlEventTouchUpInside];
    profile.frame = CGRectMake(10, 15, 64, 64);
    [profile.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor];
    [profile.layer setBorderWidth: 1.0f];
    profile.layer.shadowOffset = CGSizeMake(0, 2);
    profile.layer.shadowOpacity = 0.3;	
    profile.layer.shouldRasterize = YES;
    [self.view addSubview:profile];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(88, 18
                                                     , 200, 26)];
    name.font = [UIFont fontWithName:@"ProximaNova-Bold" size:22];
    name.textColor = [UIColor redColor];
    name.backgroundColor = [UIColor clearColor];
    [self.view addSubview:name];
    
    location = [[UILabel alloc] initWithFrame:CGRectMake(88, 44, 200, 20)];
    location.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16];
    location.textColor = [UIColor grayColor];
    location.backgroundColor = [UIColor clearColor];
    [self.view addSubview:location];
  
    UIButton *attendbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attendbtn.frame = CGRectMake(10, 365, 150, 49);
    attendbtn.backgroundColor = [UIColor clearColor];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"eventBtn"];
    [attendbtn setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
    UIImage *buttonImagePressed = [UIImage imageNamed:@"eventBtnSelected"];
    [attendbtn setBackgroundImage:buttonImagePressed forState:UIControlStateHighlighted];
    [attendbtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside]; 
    
    
    UILabel *attend = [[UILabel alloc] initWithFrame:CGRectMake(160, 365
                                                     , 150, 49)];
    attend.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    attend.textColor = [UIColor redColor];
    attend.backgroundColor = [UIColor clearColor];
    attend.text = @"ATTEND";
    attend.textAlignment = UITextAlignmentCenter;

    
    UIButton *watchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    watchBtn.frame = CGRectMake(160, 365, 150, 49);
    watchBtn.backgroundColor = [UIColor clearColor];
    UIImage *buttonImageNormalw = [UIImage imageNamed:@"eventBtn"];
    [watchBtn setBackgroundImage:buttonImageNormalw forState:UIControlStateNormal];
    UIImage *buttonImagePressedw = [UIImage imageNamed:@"eventBtnSelected"];
    [watchBtn setBackgroundImage:buttonImagePressedw forState:UIControlStateHighlighted];
    [watchBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside]; 
    
    UILabel *watch = [[UILabel alloc] initWithFrame:CGRectMake(5, 365
                                                                , 150, 49)];
    watch.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    watch.textColor = [UIColor grayColor];
    watch.backgroundColor = [UIColor clearColor];
    watch.text = @"WATCH";
    watch.textAlignment = UITextAlignmentCenter;
    
    UILabel *buttonBG = [[UILabel alloc] initWithFrame:CGRectMake(5, 362, 310, 55)];
    buttonBG.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:buttonBG];
    [self.view addSubview:watchBtn];
    [self.view addSubview:attendbtn];
    [self.view addSubview:attend];
    [self.view addSubview:watch];


}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
