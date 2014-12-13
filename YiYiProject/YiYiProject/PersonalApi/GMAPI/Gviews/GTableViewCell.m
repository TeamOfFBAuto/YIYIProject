//
//  GTableViewCell.m
//  YiYiProject
//
//  Created by gaomeng on 14/12/13.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "GTableViewCell.h"

@implementation GTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)creatCustomViewWithGcellType:(GCELLTYPE)theType indexPath:(NSIndexPath*)theIndexPath customObject:(id)theInfo{
    if (theType == GPERSON) {//个人中心
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 200*GscreenRatio_320, 24*GscreenRatio_320)];
        titleLabel.text = theInfo[theIndexPath.row];
        [self.contentView addSubview:titleLabel];
    }
}


@end
