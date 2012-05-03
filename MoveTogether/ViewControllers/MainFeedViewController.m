//
//  MainFeedViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "MainFeedViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MainFeedCell.h"
#import "CreateActivityViewController.h"
#import "AppDelegate.h"
#import "SettingsViewController.h"
#import "ActivityViewController.h"
@interface MainFeedViewController ()

@end

@implementation MainFeedViewController
@synthesize moveButton, feed, myLocation;
@synthesize activity, modalActivityNav;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initView{
    if ([self init]) {
        locationController = [[MyCLController alloc] init];
        locationController.delegate = self;
        [locationController.locationManager startUpdatingLocation];
        
    }
    return self;
    
}

- (void)viewDidLoad
{   
    activity = [[CreateActivityViewController alloc] init];
    modalActivityNav = [[UINavigationController alloc] initWithRootViewController:activity];
    modalActivityNav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [modalActivityNav view];
    
    
    //Loading UI Elements
    [self initNavBar];
    UIImage *patternImage = [UIImage imageNamed:@"background"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage]; 
    [self createTable];
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)showMenu{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

-(void)initNavBar{
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topBar"]
                                                      forBarMetrics:UIBarMetricsDefault];
        //[self.navigationController.navigationBar setTitleVerticalPositionAdjustment:0 forBarMetrics: UIBarMetricsDefault];
    }
    moveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moveButton.frame = CGRectMake(0, 0, 73, 20);
    [moveButton setImage:[UIImage imageNamed:@"move"] forState:UIControlStateNormal];
    [moveButton addTarget:self action:@selector(makeActivity:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar.topItem setTitleView:moveButton];
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    [search setFrame:CGRectMake(100, 0, 26, 26)];
    [search addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [search setImage:[UIImage imageNamed:@"iconSearchSort"] forState:UIControlStateNormal];
    UIBarButtonItem *ssButton = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.leftBarButtonItem = ssButton;
    
    UIButton *settings = [UIButton buttonWithType:UIButtonTypeCustom];
    [settings setFrame:CGRectMake(100, 0, 26, 26)];
    [settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [settings setImage:[UIImage imageNamed:@"iconSettings"] forState:UIControlStateNormal];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settings];
    self.navigationItem.rightBarButtonItem = settingsButton;
}

-(void)createTable{
    feed = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, 310, self.view.bounds.size.height-44) style:UITableViewStylePlain];
    feed.dataSource = self;
    feed.delegate = self;
    feed.backgroundColor = [UIColor clearColor];
    feed.separatorStyle = UITableViewCellSeparatorStyleNone;
    feed.contentInset = UIEdgeInsetsMake(25.0f, 0.0f, 0.0f, 0.0f);
    [self.view addSubview:feed];
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

#pragma mark
#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 140;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"Normal";
    
    MainFeedCell *cell = (MainFeedCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[MainFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.profile.image = [UIImage imageNamed:@"fakeUser2@2x.jpg"];
    cell.comments.text = @"1";
    cell.event.text = @"Test Event One 1";
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.attendingList = [NSArray arrayWithObjects:@"miniUser1@2x.jpg",@"miniUser2@2x.jpg",@"miniUser3@2x.jpg", nil];
    //[cell.attending addTarget:self action:@selector(viewAttending:) forControlEvents:UIControlEventTouchUpInside];

    [cell setupAttending];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityViewController *ViewActivity = [[ActivityViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ViewActivity animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark
#pragma mark Modal Methods

-(void)makeActivity:(id)sender{
    //activity.delegate = self;
    [self presentModalViewController:modalActivityNav animated:YES];
}
- (void) ModalDidFinish{
    
}
-(void)settings{
    UINavigationController *settingsNav;
    SettingsViewController *settingView = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
    settingsNav = [[UINavigationController alloc] initWithRootViewController:settingView];
    settingsNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:settingsNav animated:YES];
}

#pragma mark
#pragma mark - location methods
#pragma mark

- (void)locationUpdate:(CLLocation *)location {
    myLocation.latitude = location.coordinate.latitude;
    myLocation.longitude = location.coordinate.longitude;

    //NSLog(@"lat: %f", location.coordinate.latitude);
    //NSLog(@"lon: %f", location.coordinate.longitude);
    [locationController.locationManager stopUpdatingLocation];
}

- (void)locationError:(NSError *)error {
    
}


@end
