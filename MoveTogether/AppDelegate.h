//
//  AppDelegate.h
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "IIViewDeckController.h"

#define app ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *mainNav;
    UIView* loadingView;
    UIView* dimView;
    UILabel* label;
    TKProgressCircleView *_progressCircle;
    IIViewDeckController *menuSlider;
}
@property (strong, nonatomic) UINavigationController *mainNav;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UIView* loadingView;
@property (nonatomic, retain) UIView* dimView;
@property (nonatomic, retain) UILabel* label;
@property (retain,nonatomic) TKProgressCircleView *progressCircle;


- (void) didLogin;
- (void) createLoading;
- (void) showLoading: (NSString*) title;
- (void) hideLoading;
- (void) showSideMenu;
@end
