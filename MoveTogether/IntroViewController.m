//
//  IntroViewController.m
//  MoveTogether
//
//  Created by Justin Huang on 4/22/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "IntroViewController.h"
#import "AppDelegate.h"
@interface IntroViewController ()

@end

@implementation IntroViewController
@synthesize facebook;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initView{
    if ([self init]) {
        // Custom initialization
        //[self setupFacebook];

    }
    return self;
    
}

- (void)viewDidLoad
{
    [self setupView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)setupView{
    UIImage *bgImage = [UIImage imageNamed:@"introBgEdit"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage]; 
    
    UIButton *pokeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pokeBtn.frame = CGRectMake(28, 100, 264, 55);
    pokeBtn.backgroundColor = [UIColor clearColor];
    UIImage *pokeAroundNormal = [UIImage imageNamed:@"introPokeAround"];
    [pokeBtn setBackgroundImage:pokeAroundNormal forState:UIControlStateNormal];
    UIImage *pokeAroundPressed = [UIImage imageNamed:@"introPokeAroundSelected"];
    [pokeBtn setBackgroundImage:pokeAroundPressed forState:UIControlStateHighlighted];
    [pokeBtn addTarget:self action:@selector(pokeAround) forControlEvents:UIControlEventTouchUpInside]; 
    
    [self.view addSubview:pokeBtn];
    
    UIButton *facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    facebookBtn.frame = CGRectMake(28, 165, 264, 55);
    facebookBtn.backgroundColor = [UIColor clearColor];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"introFacebook"];
    [facebookBtn setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
    UIImage *buttonImagePressed = [UIImage imageNamed:@"introFacebookSelected"];
    [facebookBtn setBackgroundImage:buttonImagePressed forState:UIControlStateHighlighted];
    [facebookBtn addTarget:self action:@selector(setupFacebook) forControlEvents:UIControlEventTouchUpInside]; 
    
    [self.view addSubview:facebookBtn];
    
    UIButton *googleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    googleBtn.frame = CGRectMake(28, 230, 264, 55);
    googleBtn.backgroundColor = [UIColor clearColor];
    UIImage *googleImageNormal = [UIImage imageNamed:@"introGoogle"];
    [googleBtn setBackgroundImage:googleImageNormal forState:UIControlStateNormal];
    UIImage *googleImagePressed = [UIImage imageNamed:@"introGoogleSelected"];
    [googleBtn setBackgroundImage:googleImagePressed forState:UIControlStateHighlighted];
    [googleBtn addTarget:self action:@selector(setupGoogle) forControlEvents:UIControlEventTouchUpInside]; 
    
    [self.view addSubview:googleBtn];

    
    UIButton *linkedinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    linkedinBtn.frame = CGRectMake(28, 295, 264, 55);
    linkedinBtn.backgroundColor = [UIColor clearColor];
    UIImage *linkedinImageNormal = [UIImage imageNamed:@"introLinkedIn"];
    [linkedinBtn setBackgroundImage:linkedinImageNormal forState:UIControlStateNormal];
    UIImage *linkedinImagePressed = [UIImage imageNamed:@"introLinkedInSelected"];
    [linkedinBtn setBackgroundImage:linkedinImagePressed forState:UIControlStateHighlighted];
    [linkedinBtn addTarget:self action:@selector(setupLinkedin) forControlEvents:UIControlEventTouchUpInside]; 
    
    [self.view addSubview:linkedinBtn];

    
}

- (void)setupFacebook{
    facebook = [[Facebook alloc] initWithAppId:@"395888400431976" andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![facebook isSessionValid]) {
        [facebook authorize:nil];
    }
}
-(void)setupGoogle{
    
}

-(void)setupLinkedin{
}
-(void)pokeAround{
    [app didLogin];
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
#pragma mark Facebook Delegate Methods
// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [self dismissModalViewControllerAnimated:YES];
}
- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}
- (void)fbDidNotLogin:(BOOL)cancelled{
    
    [self dismissModalViewControllerAnimated:YES];
}
- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt{
    
}
- (void)fbSessionInvalidated{
    
}
@end
