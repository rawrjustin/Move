//
//  MainFeedCell.h
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainFeedCell : UITableViewCell{
    //main part
    UIImageView *profile;
    UILabel *event;
    UILabel *comments;
    UIImageView *commentsContainer;
    UILabel *numAttending;
    UILabel *CommentsAndAttending;
    UILabel *distance;
    UILabel *time;
    UILabel *roughLoc;
    UIButton *attending;
    //attenders
    NSArray *attendingList;
    
}
@property (nonatomic, retain) UIImageView *profile;
@property (nonatomic, retain) UILabel *event;
@property (nonatomic, retain) UILabel *comments;
@property (nonatomic, retain) UIImageView *commentsContainer;
@property (nonatomic, retain) UILabel *numAttending;
@property (nonatomic, retain) UILabel *CommentsAndAttending;
@property (nonatomic, retain) UILabel *distance;
@property (nonatomic, retain) UILabel *time;
@property (nonatomic, retain) UILabel *roughLoc;
@property (nonatomic, retain) UIButton *attending;
@property (nonatomic, retain) NSArray *attendingList;
- (void)setupAttending;
@end
