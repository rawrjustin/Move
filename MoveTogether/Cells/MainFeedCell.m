//
//  MainFeedCell.m
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "MainFeedCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation MainFeedCell
@synthesize profile,event, comments,commentsContainer, numAttending,CommentsAndAttending,distance, time, roughLoc,attending,attendingList;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 310, 82.5)];
        bgImage.image = [UIImage imageNamed:@"feedPostBg"];
        [self.contentView addSubview:bgImage];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 52, 52)];
        [profile.layer setBorderColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.7].CGColor];
        [profile.layer setBorderWidth: 2.0f];
        profile.layer.shadowOffset = CGSizeMake(0, 3);
        profile.layer.shadowOpacity = 0.3;	
        profile.layer.shouldRasterize = YES;
        [self.contentView addSubview:profile];
        
        event = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 220, 20)];
        event.font = [UIFont fontWithName:@"ProximaNova-Bold" size:20];
        event.textColor = [[UIColor alloc] initWithRed:0.3 green:0.3
                                                  blue:0.3 alpha:1.0];
        event.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:event];
        
        commentsContainer = [[UIImageView alloc] initWithFrame:CGRectMake(70, 32, 16, 15)];
        commentsContainer.image = [UIImage imageNamed:@"feedComments"];
        
        comments = [[UILabel alloc] initWithFrame:CGRectMake(6, -1, 16, 15)];
        comments.backgroundColor = [UIColor clearColor];
        comments.font = [UIFont fontWithName:@"ProximaNova-Regular" size:12];
        comments.textColor = [UIColor whiteColor];
        [commentsContainer addSubview:comments];
        [self.contentView addSubview:commentsContainer];
        
        CommentsAndAttending = [[UILabel alloc] initWithFrame:CGRectMake(88, 32, 200, 14)];
        CommentsAndAttending.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
        CommentsAndAttending.backgroundColor = [UIColor clearColor];
        CommentsAndAttending.textColor = [[UIColor alloc] initWithRed:0.3 green:0.3
                                                                 blue:0.3 alpha:1.0];
        CommentsAndAttending.text = @"Comments      Attending";
        [self.contentView addSubview:CommentsAndAttending];
                
        attending = [UIButton buttonWithType:UIButtonTypeCustom];
        attending.frame = CGRectMake(0, 82.5, 310, 47.5);
        [attending setImage:[UIImage imageNamed:@"feedMiniListBg"] forState:UIControlStateNormal];
        [self.contentView addSubview:attending];
        
        
        // Initialization code
        
    }
    return self;
}

- (void)setupAttending{
    int max = [attendingList count];
    int count =0;
    for(NSString* urlString in attendingList){
        UIImageView *miniProf = [[UIImageView alloc] initWithImage:[UIImage imageNamed:urlString]];
        miniProf.frame = CGRectMake(10+(40*count), 92, 30, 30);
        [self.contentView addSubview:miniProf];
        count+=1;
        if(count==max){
            break;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
