//
//  SocialNetworksViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 4/29/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "SocialNetworksViewController.h"

@interface SocialNetworksViewController ()

@end

@implementation SocialNetworksViewController
@synthesize socialTable, footer;
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
    UILabel *topTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 220, 50)];
    topTitle.text = @"Something better should be here than repeating the profile picture but making it smaller";
    topTitle.lineBreakMode = UILineBreakModeWordWrap;
    topTitle.numberOfLines = 3;
    topTitle.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:topTitle];
    UIImage *bgImage = [UIImage imageNamed:@"settingsSocialNetworkBg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    [self createNavBar];
    [self createTable];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createNavBar{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(100, 0, 55.5, 27)];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"iconBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backButton;
    
    footer = [[UILabel alloc] initWithFrame:CGRectMake(40, 270, 240, 30)];
    footer.textColor = [UIColor grayColor];
    footer.lineBreakMode = UILineBreakModeWordWrap;
    footer.textAlignment = UITextAlignmentCenter;
    footer.numberOfLines = 2;
    footer.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
    footer.text = @"MoveTogether will never post to your social networks or share your information";
    [self.view addSubview:footer];
}


-(void)createTable{
    socialTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, 320, 175) style:UITableViewStylePlain];
    socialTable.dataSource = self;
    socialTable.delegate = self;
    socialTable.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.5];
    socialTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:socialTable];

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
        cell.imageView.image = [UIImage imageNamed:@"settingsFacebook"];
        cell.textLabel.text = @"Facebook";
    }
    if(indexPath.row ==1){
        cell.imageView.image = [UIImage imageNamed:@"settingsTwitter"];
        cell.textLabel.text = @"Twitter";
    }
    if(indexPath.row ==2){
        cell.imageView.image = [UIImage imageNamed:@"settingsLinkedIn"];
        cell.textLabel.text = @"LinkedIn";
    
    }
    cell.userInteractionEnabled = YES;
    UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 54.2
                                                                           , 285, 1.5)];
    separator.image = [UIImage imageNamed:@"settingsSeperator"];
    [cell addSubview:separator];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    
    UISwitch *socialSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100, 0, 0)];
    cell.accessoryView = socialSwitch;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
