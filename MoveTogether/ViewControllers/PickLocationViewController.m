//
//  PickLocationViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 4/26/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "PickLocationViewController.h"
#import "ASIHTTPRequest.h"
@interface PickLocationViewController ()

@end

@implementation PickLocationViewController
@synthesize mapView, locTable, searchField, keyword, placesOutputArray, xmlDocument;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        placesOutputArray = [[NSMutableArray alloc] initWithObjects: nil];
        locationController = [[MyCLController alloc] init];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self setupView];
    [self createTable];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleChooseALocation"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
        
}

- (void)setupView{
    UIImageView *searchbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moveLocationSearchBar"]];
    searchbg.frame = CGRectMake(0, 5, 320, 55);
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ssSearchBarIcon"]];
    searchIcon.frame = CGRectMake(15, 20, 15, 17);
    [searchbg addSubview:searchIcon];
    [self.view addSubview:searchbg];

    searchField = [[UITextField alloc] initWithFrame:CGRectMake(45, 23, 250, 30)];
    searchField.backgroundColor = [UIColor clearColor];
    searchField.delegate = self;
    [self.view addSubview:searchField];
    [searchField becomeFirstResponder];
    /*
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarStartDate"]
                                                  forBarMetrics:UIBarMetricsDefault];*/
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    [save setFrame:CGRectMake(100, 0, 56, 27)];
    [save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [save setImage:[UIImage imageNamed:@"iconSaveBack"] forState:UIControlStateNormal];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:save];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    
    mapView.delegate = self;
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(5, 60, 310, 140)];
    CLLocationCoordinate2D zoomLocation; 
    zoomLocation.latitude = locationController.locationManager.location.coordinate.latitude;
    zoomLocation.longitude = locationController.locationManager.location.coordinate.longitude;
    NSLog(@"location: %f,%f", locationController.locationManager.location.coordinate.latitude, locationController.locationManager.location.coordinate.longitude);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 5000, 5000);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
    
}

-(void)createTable{
    locTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 205, 300, 206) style:UITableViewStylePlain];
    locTable.dataSource = self;
    locTable.delegate = self;
    locTable.backgroundColor = [UIColor clearColor];
    locTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //postTable.separatorColor = [UIColor blackColor];
    [self.view addSubview:locTable];
}
- (void)grabURLInBackground:(id)sender
{
    float lat = locationController.locationManager.location.coordinate.latitude;
    float lon = locationController.locationManager.location.coordinate.longitude;
    NSLog(@"location2: %f,%f", lat, lon);

    NSString *baseURL = @"https://maps.googleapis.com/maps/api/place/search/json?";
    NSString *locationURL = [NSString stringWithFormat:@"location=%f,%f",lat,lon];
    NSString *radiusURL = [NSString stringWithFormat:@"&radius=5000"];
    NSString *sensor = @"&sensor=true";
    NSString *keywordURL = [NSString stringWithFormat:@"&keyword=%@", keyword];
    //NSString searchterm
    NSString *key = @"&key=AIzaSyAgfNAZAhbBpFiKLd9ewCZtM6jIFZdHFIs";  
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@",baseURL,locationURL,radiusURL,sensor,keywordURL,key];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    [app showLoading:@"getting locations"];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [app hideLoading];
    // Use when fetching text data
    //NSString *responseString = [request responseString];
    //NSLog(@"response: %@", responseString);
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    NSError *e;
    placesOutputArray = [[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&e] objectForKey:@"results"];
    NSLog(@"places array: %@", placesOutputArray);
    [locTable reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"error: %@", [error userInfo]);
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)save:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark
#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1; 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return [placesOutputArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"Normal";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor clearColor];

    cell.userInteractionEnabled = YES;
    cell.accessoryView = nil;
    //UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 49.3, 285, 1.5)];
    //separator.image = [UIImage imageNamed:@"settingsSeperator"];
    //[cell addSubview:separator];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.text = [[placesOutputArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [[placesOutputArray objectAtIndex:indexPath.row] objectForKey:@"vicinity"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[searchField resignFirstResponder];
    keyword = searchField.text;
    [self grabURLInBackground:self];
	return YES;
}

@end
