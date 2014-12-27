//
//  GScrollView.m
//  YiYiProject
//
//  Created by gaomeng on 14/12/27.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "GScrollView.h"

#import "NSDictionary+GJson.h"
#import "HomeClothController.h"

@implementation GScrollView



//block的set方法

-(void)setPinpaiViewBlock:(pinpaiViewBlock)pinpaiViewBlock{
    _pinpaiViewBlock = pinpaiViewBlock;
}


-(void)gReloadData{
    if (self.gtype == 11) {//附近的品牌
        
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        
        NSInteger countNum = self.dataArray.count;
        
        self.contentSize = CGSizeMake(countNum *77, self.contentSize.height);
        
        for (int i = 0; i<countNum; i++) {
            NSDictionary *dic = self.dataArray[i];
            NSString *imvStr = [dic stringValueForKey:@"brand_logo"];
            NSString *nameStr = [dic stringValueForKey:@"brand_name"];
            
            UIView *pinpaiView = [[UIView alloc]initWithFrame:CGRectMake(0+i*77, 0, 70, 120)];
            pinpaiView.tag = [[dic stringValueForKey:@"id"]intValue];
            pinpaiView.backgroundColor = RGBCOLOR(242, 242, 242);
            pinpaiView.userInteractionEnabled = YES;
            
            //手势
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
            [pinpaiView addGestureRecognizer:tap];
            
            
            
            
            UIImageView *yuanLogoImv = [[UIImageView alloc]initWithFrame:CGRectMake(2, 15, 66, 66)];
            yuanLogoImv.layer.cornerRadius = 33;
            yuanLogoImv.layer.borderWidth = 1;
            yuanLogoImv.layer.masksToBounds = YES;
            yuanLogoImv.userInteractionEnabled = YES;
            yuanLogoImv.layer.borderColor = RGBCOLOR(212, 212, 212).CGColor;
            [yuanLogoImv sd_setImageWithURL:[NSURL URLWithString:imvStr] placeholderImage:nil];
            [pinpaiView addSubview:yuanLogoImv];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(yuanLogoImv.frame)+10, 70, 13)];
            nameLabel.userInteractionEnabled = YES;
            nameLabel.font = [UIFont systemFontOfSize:13];
            nameLabel.text = nameStr;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.textColor = RGBCOLOR(114, 114, 114);
            [pinpaiView addSubview:nameLabel];
            
            
            [self addSubview:pinpaiView];
            
        }
        
    }
}





//手势方法
-(void)doTap:(UITapGestureRecognizer *)sender{
//    if (self.pinpaiViewBlock) {
//        self.pinpaiViewBlock(sender.view.tag);
//    }
    
    NSString *ssidstr = [NSString stringWithFormat:@"%ld",sender.view.tag];
    [self.delegate1 pushToPinpaiDetailVCWithIdStr:ssidstr];
    
}

@end
