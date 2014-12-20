//
//  HomeMatchView.m
//  YiYiProject
//
//  Created by soulnear on 14-12-16.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "HomeMatchView.h"

@implementation HomeMatchView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    
    return self;
}

-(void)setupWithArray:(NSMutableArray *)array WithTitle:(NSString *)aTitle WithShowApplyView:(BOOL)show WithMyBlock:(HomeMatchViewBlock)aBlock
{
    UIScrollView * myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,self.height)];
    myScrollView.contentSize = CGSizeMake(20+(80+13)*array.count,0);
    [self addSubview:myScrollView];
    
    for (int i = 0;i< array.count;i++)
    {
        HomeMatchModel * model = [array objectAtIndex:i];
        
        UIView * content_view = [[UIView alloc] initWithFrame:CGRectMake(10+(80+13)*i,50,80,140)];
        [myScrollView addSubview:content_view];
        
        UIImageView * header_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,0,70,70)];
        header_imageView.backgroundColor = [UIColor grayColor];
        header_imageView.layer.masksToBounds = YES;
        header_imageView.layer.cornerRadius = 35;
        [header_imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
        [content_view addSubview:header_imageView];
        
        UILabel * user_name_label = [[UILabel alloc] initWithFrame:CGRectMake(5,header_imageView.height+7,70,18)];
        user_name_label.text = model.name;
        user_name_label.textAlignment = NSTextAlignmentCenter;
        user_name_label.textColor = [UIColor blackColor];
        user_name_label.font = [UIFont systemFontOfSize:14];
        [content_view addSubview:user_name_label];
        
        
        UIView * stars_view = [[UIView alloc] initWithFrame:CGRectMake(5,header_imageView.height+28,70,15)];
        stars_view.backgroundColor = [UIColor redColor];
        [content_view addSubview:stars_view];
    }
    
    
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(30,17,150,20)];
    title_label.text = aTitle;
    title_label.textAlignment = NSTextAlignmentLeft;
    title_label.textColor = RGBCOLOR(66,66,66);
    title_label.font = [UIFont systemFontOfSize:17];
    [self addSubview:title_label];
    
    
    if (show) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(DEVICE_WIDTH-85-15,12,85.0,30);
        [button setTitle:@"申请搭配师" forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(235,77,104) forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 8;
        button.layer.borderColor = RGBCOLOR(235,77,104).CGColor;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.borderWidth = 1;
        [self addSubview:button];
    }
}






@end
