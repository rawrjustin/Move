//
//  MenuViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 5/3/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize searchField, sortOptions;
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"worn_dots"]];
    [self createTable];
    [super viewDidLoad];
    [self setupSearch];
    [self setupSort];
	// Do any additional setup after loading the view.
}

-(void)createTable{
    sortOptions = [[UITableView alloc] initWithFrame:CGRectMake(0, 54, 260, 480-55) style:UITableViewStylePlain];
    sortOptions.dataSource = self;
    sortOptions.delegate = self;
    sortOptions.backgroundColor = [UIColor clearColor];
    sortOptions.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:sortOptions];
}
-(void)setupSearch{
    UIImageView *searchBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    searchBg.image = [UIImage imageNamed:@"ssSearchBar"];
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 15, 17)];
    searchIcon.image = [UIImage imageNamed:@"ssSearchBarIcon"];
    [searchBg addSubview:searchIcon];
    [self.view addSubview:searchBg];
    
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(42, 20, 270, 25)];
    searchField.backgroundColor = [UIColor clearColor];
    searchField.placeholder = @"Find Anything";
    searchField.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    [self.view addSubview:searchField];
}
-(void)setupSort{
   
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
    return 40;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"Normal";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:14];
    cell.textLabel.textColor = [UIColor grayColor];
    UIImageView *cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ssListItemBg"]];
    cell.backgroundView = cellBG;
    
    UIImageView *accessory = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
    accessory.image = [UIImage imageNamed:@"ssDashed"];
    cell.accessoryView = accessory;
    
    if(indexPath.row ==0){
        cell.imageView.image = [UIImage imageNamed:@"ssIconBrowseAll"];
        cell.textLabel.text = @"BROWSE ALL";
    }
    if(indexPath.row ==1){
        cell.imageView.image = [UIImage imageNamed:@"ssIconFriends"];
        cell.textLabel.text = @"SHOW FRIENDS";
    }
    if(indexPath.row ==2){
        cell.imageView.image = [UIImage imageNamed:@"ssIconLocation"];
        cell.textLabel.text = @"BY DISTANCE";
    }
    if(indexPath.row ==3){
        cell.imageView.image = [UIImage imageNamed:@"ssIconPopular"];
        cell.textLabel.text = @"BY POPULARITY";
    }
    if(indexPath.row ==4){
        cell.imageView.image = [UIImage imageNamed:@"ssIconTime"];
        cell.textLabel.text = @"BY TIME";
    }
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    UITableViewCell *cell = [sortOptions cellForRowAtIndexPath:indexPath];
    if(cell.selected == YES){
        UIImageView *accessory = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
        accessory.image = [UIImage imageNamed:@"ssDashed"];
        cell.accessoryView = accessory;
        cell.selected = NO;
        [sortOptions reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    else{
        UIImageView *accessory = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 11)];
        accessory.image = [UIImage imageNamed:@"ssSelected"];
        cell.accessoryView = accessory;
        cell.selected = YES;
        [sortOptions reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];    
    }
    NSLog(@"selected cell: %d", indexPath.row);
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section { 
    UIImageView *sortHeader = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ssTitleBar"]];
    return sortHeader;
}


@end
