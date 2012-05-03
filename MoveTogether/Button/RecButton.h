//
//  RecButton.h
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecButton : UIButton{
    UILabel *label;
    UIImageView *friendmarker;
    UIImageView *nextmarker;
}


@property(nonatomic, retain) UILabel *label;
@property(nonatomic, retain) UIImageView *friendmaker;
@property(nonatomic, retain) UIImageView *nextmarker;
@end
