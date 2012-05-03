//
//  SocialNetworksViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 4/29/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialNetworksViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView *socialTable;
    UILabel *footer;
}

@property (nonatomic, strong) UITableView *socialTable;
@property (nonatomic, strong) UILabel *footer;
-(void)createTable;
-(void)createNavBar;

@end
