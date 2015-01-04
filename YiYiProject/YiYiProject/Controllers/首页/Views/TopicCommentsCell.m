//
//  TopicCommentsCell.m
//  YiYiProject
//
//  Created by soulnear on 14-12-28.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "TopicCommentsCell.h"

@implementation TopicCommentsCell

- (void)awakeFromNib
{
    _header_imageView.frame = CGRectMake(12,12,36,36);
    _header_imageView.layer.masksToBounds = YES;
    _header_imageView.layer.cornerRadius = _header_imageView.width/2.0;
    
    
    _userName_label.frame = CGRectMake(60,10,DEVICE_WIDTH-60-12,16);
    _date_label.frame = CGRectMake(60,30,DEVICE_WIDTH-60-12,16);
    _content_label.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setInfoWithCommentsModel:(TopicCommentsModel *)model
{
    [_header_imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    _userName_label.text = model.user_name;
    _date_label.text = [ZSNApi timechange:model.post_time WithFormat:@"MM月dd日 HH:mm"];
    
    
    CGFloat string_height = [LTools heightForText:model.repost_content width:DEVICE_WIDTH-60-12 font:14];
    _content_label.frame = CGRectMake(60,58,DEVICE_WIDTH-60-12,string_height);
    _content_label.text = model.repost_content;
    
    
    
    if (model.child_array.count > 0)
    {
        
        
    }
    
}



@end
