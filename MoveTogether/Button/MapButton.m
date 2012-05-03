//
//  MapButton.m
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "MapButton.h"

@implementation MapButton
@synthesize name, address, mapmarker, nextmarker;
-(id) initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        name = [[UILabel alloc] initWithFrame:CGRectMake(35, 7, 260, 20)];
        name.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
        name.text = @"Current Location";
        name.textColor = [UIColor redColor];
        [self addSubview:name];
        
        address = [[UILabel alloc] initWithFrame:CGRectMake(35, 27, 260, 12)];
        address.text = @"1890 Powell St San Francisco, CA";
        address.textColor = [UIColor grayColor];
        address.font = [UIFont fontWithName:@"ProximaNova-Regular" size:12];
        [self addSubview:address];
        
        
        mapmarker = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 13, 22)];
        [mapmarker setImage:[UIImage imageNamed:@"eventLocation"]];
        [self addSubview:mapmarker];
        
        nextmarker = [[UIImageView alloc] initWithFrame:CGRectMake(290, 20, 7, 12)];
        [nextmarker setImage:[UIImage imageNamed:@"expandArrow"]];
        [self addSubview:nextmarker];
        
        
    }
    return self;
}

@end
