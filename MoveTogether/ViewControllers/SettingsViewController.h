//
//  SettingsViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 4/25/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>


@interface SettingsViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>{
    UILabel *followers;
    UILabel *following;
    UILabel *activities;
    UIButton *profile;
    UILabel *name;
    UILabel *location;
    UIActionSheet *changeProfile;
    UITableView *settingsTable;
    UILabel *footer;
}
@property(nonatomic, strong) UITableView *settingsTable;
@property(nonatomic, strong) UIButton *profile;
@property(nonatomic, strong) UILabel *followers;
@property(nonatomic, strong) UILabel *following;
@property(nonatomic, strong) UILabel *activites;
@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UILabel *location;
@property(nonatomic, strong) UILabel *footer;

- (void) showCameraUI;
- (void)setupOptionButtons;
- (void)setupUser;
- (void)setupTopProfile;
- (void)initNavBar;
- (void)back;
- (void)createTable;
- (void)profileTap;
@end
