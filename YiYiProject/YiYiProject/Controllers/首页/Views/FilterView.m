//
//  FilterView.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/21.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "FilterView.h"

@implementation FilterView

+ (id)shareInstance
{
    static dispatch_once_t once_t;
    static FilterView *dataBlock;
    
    dispatch_once(&once_t, ^{
        dataBlock = [[FilterView alloc]init];
    });
    
    return dataBlock;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FilterView class]) owner:self options:nil]lastObject];
        self.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    }
    return self;
}

- (void)show
{
    UIView *root = [UIApplication sharedApplication].keyWindow;
    [root addSubview:self];
}

- (void)hidden
{
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidden];
}

@end
