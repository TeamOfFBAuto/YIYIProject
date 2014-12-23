//
//  MatchCaseCell.m
//  YiYiProject
//
//  Created by soulnear on 14-12-21.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MatchCaseCell.h"

@implementation MatchCaseCell

- (void)awakeFromNib {
    // Initialization code
    _header_imageView.layer.masksToBounds = YES;
    _header_imageView.layer.cornerRadius = _header_imageView.width/2.0f;
}


-(void)setContentWithModel:(MatchCaseModel *)model
{
    [_header_imageView sd_setImageWithURL:[NSURL URLWithString:model.u_photo] placeholderImage:nil];
    _userName_label.text = model.name;
    [_pic_imageView sd_setImageWithURL:[NSURL URLWithString:model.t_img] placeholderImage:nil];
}


@end
