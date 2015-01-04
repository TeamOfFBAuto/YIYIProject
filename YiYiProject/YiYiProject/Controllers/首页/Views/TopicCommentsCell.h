//
//  TopicCommentsCell.h
//  YiYiProject
//
//  Created by soulnear on 14-12-28.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

/*
 话题评论cell
 */

#import <UIKit/UIKit.h>
#import "TopicCommentsModel.h"

@interface TopicCommentsCell : UITableViewCell

///头像
@property (strong, nonatomic) IBOutlet UIImageView *header_imageView;

///昵称
@property (strong, nonatomic) IBOutlet UILabel *userName_label;

///时间
@property (strong, nonatomic) IBOutlet UILabel *date_label;
///内容
@property (strong, nonatomic) IBOutlet UILabel *content_label;



///填充数据
-(void)setInfoWithCommentsModel:(TopicCommentsModel *)model;


@end
















