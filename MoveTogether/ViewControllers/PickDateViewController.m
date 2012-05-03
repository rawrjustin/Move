//
//  PickDateViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 4/22/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "PickDateViewController.h"

@interface PickDateViewController ()

@end

@implementation PickDateViewController
@synthesize delegate;
@synthesize start, calendar, timeBar,hourBar, chosenEnd, chosenStart;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initAsStart:(BOOL)isStart{
    if([self init]){
        if(isStart){
            start = isStart;
            chosenStart = [NSDate date];
            
        }
        else{
            start = isStart;
            chosenEnd = [NSDate date];
        }
    }
    calendar = 	[[TKCalendarMonthView alloc] init];
    calendar.delegate = self;
    calendar.dataSource = self;
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadCalendar];
    [self loadTimeBar];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadNavBar];
}

-(void)loadTimeBar{
    
    NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH"];
    NSDateFormatter* hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setDateFormat:@"mm"];
    
    timeBar = [[HorizontalTimeScroller alloc] initWithFrame:CGRectMake(30.5, 285, 261, 50) andType:@"hour"];
    [self.view addSubview:timeBar];
    hourBar = [[HorizontalTimeScroller alloc] initWithFrame:CGRectMake(30.5, 348, 261, 50) andType:@"minute"];
    [self.view addSubview:hourBar];
    if(start){
        [timeBar setHourTo:[[timeFormatter stringFromDate:chosenStart] intValue]];
        [hourBar setMinuteTo:[[hourFormatter stringFromDate:chosenStart] intValue]];
    }
    else{
        [timeBar setHourTo:[[timeFormatter stringFromDate:chosenEnd] intValue]];
        [hourBar setMinuteTo:[[hourFormatter stringFromDate:chosenEnd] intValue]];
    }
    
    UIImageView *timeOverlay =  [[UIImageView alloc] initWithFrame:CGRectMake(137, 280, 49, 118)];
    timeOverlay.image = [UIImage imageNamed:@"hourOverlay"];
    [self.view addSubview:timeOverlay];
    UIImageView *timeBarCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 270, 320, 140)];
    timeBarCover.image = [UIImage imageNamed:@"moveDateRollerBorder"];
    [self.view addSubview:timeBarCover];
}
- (void)loadCalendar{
    calendar.frame = CGRectMake(0, 5, calendar.frame.size.width, calendar.frame.size.height);
    [self.view addSubview:calendar];
	[calendar reload];
    [calendar selectDate:[NSDate date]];
}

- (void)loadNavBar{
    self.navigationController.navigationBar.layer.masksToBounds = NO;

    if(start){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarStartDate"]
                                                      forBarMetrics:UIBarMetricsDefault];
        UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
        [save setFrame:CGRectMake(100, 0, 56, 27)];
        [save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [save setImage:[UIImage imageNamed:@"iconSaveBack"] forState:UIControlStateNormal];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:save];
        self.navigationItem.leftBarButtonItem = saveButton;
        
        UIButton *end = [UIButton buttonWithType:UIButtonTypeCustom];
        [end setFrame:CGRectMake(100, 0, 54, 27)];
        [end addTarget:self action:@selector(end:) forControlEvents:UIControlEventTouchUpInside];
        [end setImage:[UIImage imageNamed:@"iconEndNext"] forState:UIControlStateNormal];
        UIBarButtonItem *endButton = [[UIBarButtonItem alloc] initWithCustomView:end];
        self.navigationItem.rightBarButtonItem = endButton;
    }
    
    else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarEndDate"]
                                                      forBarMetrics:UIBarMetricsDefault];
        UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
        [save setFrame:CGRectMake(100, 0, 56, 27)];
        [save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [save setImage:[UIImage imageNamed:@"iconSave"] forState:UIControlStateNormal];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:save];
        self.navigationItem.rightBarButtonItem = saveButton;
        
        UIButton *startBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBack setFrame:CGRectMake(100, 0, 54, 27)];
        [startBack addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
        [startBack setImage:[UIImage imageNamed:@"iconStart"] forState:UIControlStateNormal];
        UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithCustomView:startBack];
        self.navigationItem.leftBarButtonItem = startButton;
        
    }
    
    
    
}

- (void)save:(id)sender{
    NSDate *selected = [calendar dateSelected];
    NSCalendar *gregorian = [[NSCalendar alloc]  initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *calendarComponents = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:selected];
    NSInteger day = [calendarComponents day];
    NSInteger month = [calendarComponents month];
    NSInteger year = [calendarComponents year];
    
    NSInteger hour= [hourBar getHour];
    NSInteger minute = [timeBar getMinute];

    NSDateComponents *newDateComponents = [[NSDateComponents alloc] init];
    [newDateComponents setDay:day];
    [newDateComponents setMonth:month];
    [newDateComponents setYear:year];
    [newDateComponents setHour:hour];
    [newDateComponents setMinute:minute];
    
    NSDate *selectedDate = [gregorian dateFromComponents: newDateComponents];
    
    if(start){
        chosenStart = selectedDate;
        NSLog(@"start: %@", chosenStart);
        [[self delegate] setDate:chosenStart asStart:YES];
    }
    if(!start){
        chosenEnd = selectedDate;
        [[self delegate] setDate:chosenEnd asStart:NO];
    }
    
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)end:(id)sender{
    
    PickDateViewController *dateController = [[PickDateViewController alloc] initAsStart:NO];
    [[self navigationController] pushViewController:dateController animated:YES];
}
- (void)start:(id)sender{
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
#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");	
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
	NSLog(@"calendarMonthView marksFromDate toDate");	
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
	// When testing initially you will have to update the dates in this array so they are visible at the
	// time frame you are testing the code.
	NSArray *data = [NSArray arrayWithObjects:
					 @"2011-01-01 00:00:00 +0000", @"2011-01-09 00:00:00 +0000", @"2011-01-22 00:00:00 +0000",
					 @"2011-01-10 00:00:00 +0000", @"2011-01-11 00:00:00 +0000", @"2011-01-12 00:00:00 +0000",
					 @"2011-01-15 00:00:00 +0000", @"2011-01-28 00:00:00 +0000", @"2011-01-04 00:00:00 +0000",					 
					 @"2011-01-16 00:00:00 +0000", @"2011-01-18 00:00:00 +0000", @"2011-01-19 00:00:00 +0000",					 
					 @"2011-01-23 00:00:00 +0000", @"2011-01-24 00:00:00 +0000", @"2011-01-25 00:00:00 +0000",					 					 
					 @"2011-02-01 00:00:00 +0000", @"2011-03-01 00:00:00 +0000", @"2011-04-01 00:00:00 +0000",
					 @"2011-05-01 00:00:00 +0000", @"2011-06-01 00:00:00 +0000", @"2011-07-01 00:00:00 +0000",
					 @"2011-08-01 00:00:00 +0000", @"2011-09-01 00:00:00 +0000", @"2011-10-01 00:00:00 +0000",
					 @"2011-11-01 00:00:00 +0000", @"2011-12-01 00:00:00 +0000", nil]; 
	
    
	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
	NSMutableArray *marks = [NSMutableArray array];
	
	// Initialise calendar to current type and set the timezone to never have daylight saving
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	// Construct DateComponents based on startDate so the iterating date can be created.
	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed 
	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first 
	// iterating date then times would go up and down based on daylight savings.
	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
                                              NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
                                    fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	
	// Init offset components to increment days in the loop by one each time
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];	
	
    
	// for each date between start date and end date check if they exist in the data array
	while (YES) {
		// Is the date beyond the last date? If so, exit the loop.
		// NSOrderedDescending = the left value is greater than the right
		if ([d compare:lastDate] == NSOrderedDescending) {
			break;
		}
		
		// If the date is in the data array, add it to the marks array, else don't
		if ([data containsObject:[d description]]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
		}
		
		// Increment day using offset components (ie, 1 day in this instance)
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
	
	
	return [NSArray arrayWithArray:marks];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offset = scrollView.contentOffset.x;
    int snap = (int)((offset +7.0)/44);
    snap = (snap * 44 +15) - (int)(snap/2);
    [timeBar scrollRectToVisible:CGRectMake((CGFloat)snap, timeBar.frame.size.height/2, timeBar.frame.size.width, timeBar.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    int snap = (int)((offset +7.0)/44);
    snap = (snap * 44 +15) - (int)(snap/2);
    if(scrollView == timeBar){
        [timeBar scrollRectToVisible:CGRectMake((CGFloat)snap, timeBar.frame.size.height/2, timeBar.frame.size.width, timeBar.frame.size.height) animated:YES];
    }
    if(scrollView == hourBar){
        [hourBar scrollRectToVisible:CGRectMake((CGFloat)snap, timeBar.frame.size.height/2, timeBar.frame.size.width, timeBar.frame.size.height) animated:YES];
    }
    
}


@end
