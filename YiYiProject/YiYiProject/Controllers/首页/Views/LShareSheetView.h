//
//  LShareSheetView.h
//  FBAuto
//
//  Created by lichaowei on 14-7-24.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  分享 sheetView
 */

//items = @[@"朋友圈",@"微博",@"QQ空间",@"微信",@"QQ",];

typedef enum {
    
    Share_WX_PengYouQuan = 100,
    Share_WX_HaoYou = 103,
    Share_WeiBo = 101,
    Share_QQZone = 102,
    Share_QQ = 104
    
}Share_Type;

typedef void(^ ActionBlock) (NSInteger buttonIndex,Share_Type shareType);

@interface LShareSheetView : UIView
{
    ActionBlock actionBlock;
    UIView *bgView;
    NSArray *items;
}

+ (id)shareInstance;
- (void)actionBlock:(ActionBlock)aBlock;

- (void)show;

@end
