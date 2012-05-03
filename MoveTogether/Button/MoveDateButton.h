//
//  MoveDateButton.h
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveDateButton : UIButton{
    UILabel *title;
    UILabel *day;
    UILabel *time;
    UIImageView *calendar;
}

@property(nonatomic,retain) UILabel *title;
@property(nonatomic, retain) UILabel *day;
@property(nonatomic, retain) UILabel *time;
@property(nonatomic,retain) UIImageView *calendar;

-(id) initWithFrame:(CGRect)frame;
@end
