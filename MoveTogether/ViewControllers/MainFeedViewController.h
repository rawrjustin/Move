//
//  MainFeedViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateActivityViewController.h"
#import "MyCLController.h"
@protocol ModalViewDelegate
//- (void) ModalDidCancel;
- (void) ModalDidFinish;

@end

@interface MainFeedViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ModalViewDelegate>{
    UIButton *moveButton;
    UITableView *feed;
    UINavigationController *modalActivityNav;
    CreateActivityViewController *activity;
    MyCLController *locationController;
    CLLocationCoordinate2D myLocation;

}
@property(nonatomic) CLLocationCoordinate2D myLocation;
@property(nonatomic, retain) CreateActivityViewController *activity;
@property(nonatomic, retain) UINavigationController *modalActivityNav;
@property(strong) UIButton *moveButton;
@property(nonatomic, retain) UITableView *feed;
-(id) initView;
-(void) initNavBar;
-(void)makeActivity:(id)sender;
-(void)createTable;
@end
