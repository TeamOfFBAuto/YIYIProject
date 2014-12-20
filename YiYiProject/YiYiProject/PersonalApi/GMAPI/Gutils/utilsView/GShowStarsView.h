//
//  GShowStarsView.h
//  YiYiProject
//
//  Created by gaomeng on 14/12/20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GShowStarsView : UIView


///下列属性都需要设置

///星星的个数
@property(nonatomic,assign)float startNum;

///最多几个星星
@property(nonatomic,assign)int maxStartNum;

///星星的宽度
@property(nonatomic,assign)float starWidth;

///整颗星的图片名字
@property(nonatomic,strong)NSString *starNameStr;

///半颗星的图片名字
@property(nonatomic,strong)NSString *star_halfNameStr;








//初始化方法
-(GShowStarsView*)initWithStartNum:(int)num Frame:(CGRect)theFrame starBackName:(NSString *)theBackStarNameStr starWidth:(CGFloat)theStarWidth;


//填充数据
-(void)updateStartNum;

@end
