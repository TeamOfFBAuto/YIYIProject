//
//  MatchCaseCell.h
//  YiYiProject
//
//  Created by soulnear on 14-12-21.
//  Copyright (c) 2014年 lcw. All rights reserved.
//
/*
 搭配师界面搭配案例cell
 */

#import <UIKit/UIKit.h>
#import "TMPhotoQuiltViewCell.h"
#import "MatchCaseModel.h"

@interface MatchCaseCell : TMQuiltViewCell

@property (strong, nonatomic) IBOutlet UIImageView *header_imageView;

@property (strong, nonatomic) IBOutlet UILabel *userName_label;


@property (strong, nonatomic) IBOutlet UIImageView *pic_imageView;








-(void)setContentWithModel:(MatchCaseModel *)model;

@end
