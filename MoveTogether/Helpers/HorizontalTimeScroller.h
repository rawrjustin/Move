//
//  HorizontalTimeScroller.h
//  MoveTogether
//
//  Created by Justin Huang on 4/26/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalTimeScroller : UIScrollView<UIScrollViewDelegate>{
    int hour;
    int minute;
    NSString *scrollType;
}
@property (nonatomic,strong) NSString *scrollType;
@property (nonatomic) NSInteger hour;
@property (nonatomic) NSInteger minute;
- (id)initWithFrame:(CGRect)frame andType:(NSString*)type;
-(NSInteger)getHour;
-(NSInteger)getMinute;
-(void)setHourTo:(NSInteger) setHour;
-(void)setMinuteTo:(NSInteger) setMinute;
@end
