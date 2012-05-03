//
//  MenuViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 5/3/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITextField *searchField;
    UITableView *sortOptions;
}
@property(nonatomic, strong) UITextField *searchField;
@property(nonatomic, strong) UITableView *sortOptions;
-(void)setupSearch;
-(void)setupSort;
@end
