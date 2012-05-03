//
//  IntroViewController.h
//  MoveTogether
//
//  Created by Justin Huang on 4/22/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface IntroViewController : UIViewController <FBSessionDelegate>{
    Facebook *facebook;
}

@property (nonatomic, retain) Facebook *facebook;

- (id)initView;
- (void)setupFacebook;
- (void)setupGoogle;
- (void)setupLinkedin;
- (void)setupView;
- (void)pokeAround;
@end
