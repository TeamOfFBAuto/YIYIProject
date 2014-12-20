//
//  GShowStarsView.m
//  YiYiProject
//
//  Created by gaomeng on 14/12/20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "GShowStarsView.h"

@implementation GShowStarsView

-(GShowStarsView*)initWithStartNum:(int)num Frame:(CGRect)theFrame{
    self = [super initWithFrame:theFrame];
    if (self) {
        
        CGFloat kuan = 12;
        
        for (int i = 0; i<num; i++) {
            UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*kuan, 0, kuan, theFrame.size.height)];
            [imv setImage:[UIImage imageNamed:@"gstart.png"]];
            [self addSubview:imv];
        }
    }
    
    return self;
}


-(void)updateStartNum{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.startNum = self.startNum>self.maxStartNum ? self.maxStartNum : self.startNum;
    
    int nnn_int = (int)self.startNum;
    
    CGFloat kuan = 12;
    
    if (nnn_int<self.startNum) {//有半颗星
        
        for (int i = 0; i<nnn_int; i++) {
            NSLog(@"%d",i);
            UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*kuan, 0, kuan, self.frame.size.height)];
            [imv setImage:[UIImage imageNamed:@"gstart.png"]];
            [self addSubview:imv];
            
            if ((i+1)>=nnn_int) {
                UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0+(i+1)*kuan, 0, kuan, self.frame.size.height)];
                [imv setImage:[UIImage imageNamed:@"gstart_half.png"]];
                [self addSubview:imv];
            }
        }
        
    }else{//没有半颗星
        for (int i = 0; i<self.startNum; i++) {
            UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*kuan, 0, kuan, self.frame.size.height)];
            [imv setImage:[UIImage imageNamed:@"gstart.png"]];
            [self addSubview:imv];
        }
    }
    
    
}

@end
