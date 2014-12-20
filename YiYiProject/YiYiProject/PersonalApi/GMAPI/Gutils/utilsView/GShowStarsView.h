//
//  GShowStarsView.h
//  YiYiProject
//
//  Created by gaomeng on 14/12/20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GShowStarsView : UIView

///星星的个数
@property(nonatomic,assign)float startNum;

///最多几个星星
@property(nonatomic,assign)int maxStartNum;

//初始化方法
-(GShowStarsView*)initWithStartNum:(int)num Frame:(CGRect)theFrame;


//填充数据
-(void)updateStartNum;

@end
