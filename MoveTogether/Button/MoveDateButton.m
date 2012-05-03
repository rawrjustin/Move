//
//  MoveDateButton.m
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "MoveDateButton.h"

@implementation MoveDateButton
@synthesize title,day,time,calendar;
-(id) initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 120, 24)];
        title.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
        title.textColor = [UIColor grayColor];
        [self addSubview:title];
        
        day = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 120, 26)];
        day.text = @"TODAY";
        day.textColor = [UIColor redColor];
        day.font = [UIFont fontWithName:@"ProximaNova-Bold" size:22];
        [self addSubview:day];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(2, 50, 120, 16)];
        time.textColor = [UIColor blackColor];
        time.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
        [self addSubview:time];
        
        calendar = [[UIImageView alloc] initWithFrame:CGRectMake(104, 30, 27, 27)];
        [calendar setImage:[UIImage imageNamed:@"moveDateIcon"]];
        [self addSubview:calendar];
        

    }
    return self;
}

@end
