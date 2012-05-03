//
//  RecButton.m
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "RecButton.h"

@implementation RecButton
@synthesize label,friendmaker,nextmarker;
-(id) initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        label = [[UILabel alloc] initWithFrame:CGRectMake(36, 13, 260, 20)];
        label.font = [UIFont fontWithName:@"ProximaNova-Bold" size:14];
        label.text = @"RECOMMENDED";
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
                
        friendmaker = [[UIImageView alloc] initWithFrame:CGRectMake(7, 15, 20, 15)];
        [friendmaker setImage:[UIImage imageNamed:@"moveGroupIcon"]];
        [self addSubview:friendmaker];
        
        nextmarker = [[UIImageView alloc] initWithFrame:CGRectMake(290, 20, 7, 12)];
        [nextmarker setImage:[UIImage imageNamed:@"expandArrow"]];
        [self addSubview:nextmarker];
        
        
    }
    return self;
}
@end
