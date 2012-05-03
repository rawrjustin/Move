//
//  MapButton.h
//  MoveTogether
//
//  Created by Justin Huang on 4/19/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapButton : UIButton{
    UILabel *name;
    UILabel *address;
    UIImageView *mapmarker;
    UIImageView *nextmarker;

}


@property(nonatomic, retain) UILabel *name;
@property(nonatomic, retain) UILabel *address;
@property(nonatomic, retain) UIImageView *mapmarker;
@property(nonatomic, retain) UIImageView *nextmarker;


@end
