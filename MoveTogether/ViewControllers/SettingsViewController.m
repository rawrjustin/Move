//
//  SettingsViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 4/25/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SocialNetworksViewController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize activites, followers, following, profile, location, name, footer;
@synthesize settingsTable;
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
    [self setupOptionButtons];
    [self createTable];
    [self setupTopProfile];
    [self initNavBar];
    [self setupUser];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)setupOptionButtons{
    
}

-(void)createTable{
    settingsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, 320, 480-150-50) style:UITableViewStylePlain];
    settingsTable.dataSource = self;
    settingsTable.delegate = self;
    settingsTable.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.5];
    settingsTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:settingsTable];
}
-(void)setupUser{
    followers.text = @"17";
    following.text = @"18";
    activities.text = @"19";
    [profile setImage:[UIImage imageNamed:@"settingsProfilePic"] forState:UIControlStateNormal];
    name.text = @"Eric Benjamin";
    location.text = @"Denver, CO";
    footer.text = @"Moving Since March 1991";
    name.text = [name.text uppercaseString];
}
-(void)setupTopProfile{
    UIImageView *topProfileBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    topProfileBg.image = [UIImage imageNamed:@"settingsTopBg"];
    [self.view addSubview:topProfileBg];
    
    profile = [UIButton buttonWithType:UIButtonTypeCustom];
    [profile addTarget:self action:@selector(profileTap) forControlEvents:UIControlEventTouchUpInside];
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
    [self.view addSubview:name];
    
    location = [[UILabel alloc] initWithFrame:CGRectMake(88, 44, 200, 20)];
    location.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16];
    location.textColor = [UIColor grayColor];
    [self.view addSubview:location];
    
    
    followers = [[UILabel alloc] initWithFrame:CGRectMake(45, 104, 30, 24)];
    following = [[UILabel alloc] initWithFrame:CGRectMake(148, 104, 30, 24)];
    activities = [[UILabel alloc] initWithFrame:CGRectMake(250, 104, 30, 24)];
    followers.font = [UIFont fontWithName:@"ProximaNova-Bold" size:24];
    activities.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:24];
    following.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:24];
    followers.textColor = [UIColor grayColor];
    following.textColor = [UIColor grayColor];
    activities.textColor = [UIColor redColor];
    followers.backgroundColor = [UIColor clearColor];
    following.backgroundColor = [UIColor clearColor];
    activities.backgroundColor = [UIColor clearColor];
    [self.view addSubview:following];
    [self.view addSubview:followers];
    [self.view addSubview:activities];
    
    UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 370, 320, 48)];
    bottomBar.image = [UIImage imageNamed:@"feedMiniListBg"];
    [self.view addSubview:bottomBar];
    
    footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 380, 320, 30)];
    footer.textColor = [UIColor redColor];
    footer.textAlignment = UITextAlignmentCenter;
    footer.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
    [self.view addSubview:footer];
}
-(void)initNavBar{
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"new-navBar"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    UIImageView *title = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 69, 17)];
    title.image = [UIImage imageNamed:@"titleSettings"];
    [self.navigationController.navigationBar.topItem setTitleView:title];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(100, 0, 55.5, 27)];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"iconBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backButton;
    
}

-(void)back{
    [self dismissModalViewControllerAnimated:YES];
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
    return 4;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 55;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"Normal";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor clearColor];
    if(indexPath.row ==0){
        cell.imageView.image = [UIImage imageNamed:@"settingsEventsIcon"];
        cell.textLabel.text = @"Manage Activities";
    }
    if(indexPath.row ==1){
        cell.imageView.image = [UIImage imageNamed:@"settingsPeopleIcon"];
        cell.textLabel.text = @"Manage People";
    }
    if(indexPath.row ==2){
        cell.imageView.image = [UIImage imageNamed:@"settingsInterestsIcon"];
        cell.textLabel.text = @"Manage Interests";
    }
    if(indexPath.row ==3){
        cell.imageView.image = [UIImage imageNamed:@"settingsPeopleIcon"];
        cell.textLabel.text = @"Social Networks";
    }
    cell.userInteractionEnabled = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 54.2
                                                                           , 285, 1.5)];
    separator.image = [UIImage imageNamed:@"settingsSeperator"];
    [cell addSubview:separator];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    if(indexPath.row ==3){
        SocialNetworksViewController *socialView = [[SocialNetworksViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:socialView animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark 
#pragma mark Action Sheet methods

-(void)profileTap{
    changeProfile = [[UIActionSheet alloc] initWithTitle:@"Change Profile Pic"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"Take a Picture", @"Select From Album", nil];
    
    // Show the sheet
    [changeProfile showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button %d", buttonIndex);
    if(buttonIndex == 0){
        [self showCameraUI];
    }
    if(buttonIndex ==1){
        [self showSavedMediaBrowser];
    }
    
}

#pragma mark
#pragma mark - Camera methods
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}
- (void) showCameraUI {
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissModalViewControllerAnimated: YES];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        imageToSave = originalImage;
        
        profile.imageView.image = imageToSave;
        // Save the new image (original or edited) to the Camera Roll
        //UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    }
    
    [self dismissModalViewControllerAnimated: YES];
}

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = delegate;
    
    [controller presentModalViewController: mediaUI animated: YES];
    return YES;
}

- (void) showSavedMediaBrowser {
    [self startMediaBrowserFromViewController: self
                                usingDelegate: self];
}


@end
