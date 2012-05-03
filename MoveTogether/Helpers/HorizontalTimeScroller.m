//
//  HorizontalTimeScroller.m
//  MoveTogether
//
//  Created by Justin Huang on 4/26/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "HorizontalTimeScroller.h"

@implementation HorizontalTimeScroller
@synthesize scrollType, hour, minute;
- (id)initWithFrame:(CGRect)frame andType:(NSString*)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if([type isEqualToString:@"hour"]){
            self.contentSize = CGSizeMake(1294,50);
            [self setContentInset:UIEdgeInsetsMake(0, -10, 0, -10)];
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hourBar2"]];

        }
        else if([type isEqualToString:@"minute"]){
            self.contentSize = CGSizeMake(772,50);
            [self setContentInset:UIEdgeInsetsMake(0, -10, 0, -10)];
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"minutesBar2"]];

        }
        [self setShowsHorizontalScrollIndicator:NO];
        scrollType = type;
        self.delegate = self;
            
    }
    return self;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offset = scrollView.contentOffset.x;
    int snap = (int)(offset +7.0)/44;
    if(snap <0){
        snap = 0;
    }
    snap = (snap * 44 +15) - (snap/2);
    if([scrollType isEqualToString:@"hour"]){
        hour = snap+1;
    }
    if([scrollType isEqualToString:@"minute"]){
        minute = snap*5;
    }

    [self scrollRectToVisible:CGRectMake((CGFloat)snap, self.frame.size.height/2, self.frame.size.width, self.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    int snap = (int)(offset +7.0)/44;
    if(snap <0){
        snap = 0;
    }
    snap = (snap * 44 +15) - (snap/2);
    if([scrollType isEqualToString:@"hour"]){
        hour = snap+1;
    }
    if([scrollType isEqualToString:@"minute"]){
        minute = snap*5;
    }
    [self scrollRectToVisible:CGRectMake((CGFloat)snap, self.frame.size.height/2, self.frame.size.width, self.frame.size.height) animated:YES];
}
-(void)setHourTo:(NSInteger)setHour{
    int pos = ((setHour-1) * 44 +15) - ((setHour-1)/2);
    [self scrollRectToVisible:CGRectMake((CGFloat)pos, self.frame.size.height/2, self.frame.size.width, self.frame.size.height) animated:YES];
}
-(void)setMinuteTo:(NSInteger)setMinute{
    int tempMin = setMinute/5;
    int pos = (tempMin * 44 +15) - ((tempMin-1)/2);
    [self scrollRectToVisible:CGRectMake((CGFloat)pos, self.frame.size.height/2, self.frame.size.width, self.frame.size.height) animated:YES];
}

-(NSInteger)getHour{
    return hour;
}
-(NSInteger)getMinute{
    return minute;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
