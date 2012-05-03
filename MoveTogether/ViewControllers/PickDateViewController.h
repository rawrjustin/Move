//
//  PickDateViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 4/22/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "HorizontalTimeScroller.h"

@protocol DateDelegate
@required
- (void) setDate: (NSDate*)datetimes asStart:(BOOL)s;
@end

@interface PickDateViewController : UIViewController<TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource, UIScrollViewDelegate>{
    BOOL start;
    TKCalendarMonthView *calendar;
	HorizontalTimeScroller *timeBar;
    HorizontalTimeScroller *hourBar;
    NSDate *chosenStart;
    NSDate *chosenEnd;
    id <DateDelegate> delegate;
}
@property (nonatomic, retain) HorizontalTimeScroller *timeBar;
@property (nonatomic, retain) HorizontalTimeScroller *hourBar;
@property (nonatomic, retain) NSDate *chosenStart;
@property (nonatomic, retain) NSDate *chosenEnd;
@property (retain) id delegate;

@property (nonatomic) BOOL start;
@property (nonatomic, retain) TKCalendarMonthView *calendar;

-(void)loadNavBar;
- (void)loadCalendar;
-(void)loadTimeBar;
- (id)initAsStart:(BOOL)isStart;
- (void)save:(id)sender;
- (void)end:(id)sender;
- (void)start:(id)sender;
@end
