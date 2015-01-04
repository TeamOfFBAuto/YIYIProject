//
//  TopicDetailBottomView.m
//  YiYiProject
//
//  Created by soulnear on 14-12-28.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "TopicDetailBottomView.h"

@implementation TopicDetailBottomView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.backgroundColor = [RGBCOLOR(73,73,73) colorWithAlphaComponent:0.8];
    
    NSArray * image_array = [NSArray arrayWithObjects:[UIImage imageNamed:@"xq_love_up"],[UIImage imageNamed:@"xq_pinglun"],[UIImage imageNamed:@"fenxiangb"], nil];
    
    for (int i = 0;i < 3;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(DEVICE_WIDTH/3.0f,0,DEVICE_WIDTH/3.0f,self.height);
        button.tag = 100 + i;
        [button setImage:[image_array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:button];
    }
}

-(void)setBottomBlock:(TopicDetailBottomViewBlock)aBlock
{
    topicDetailBottomView_block = aBlock;
}

@end
