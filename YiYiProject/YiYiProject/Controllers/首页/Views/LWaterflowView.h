//
//  LWaterflowView.h
//  Waterflow
//
//  Created by lichaowei on 14/12/13.
//  Copyright (c) 2014年 yangjw . All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "TMQuiltView.h"
#import "TMPhotoQuiltViewCell.h"

@protocol WaterFlowDelegate <NSObject>

@optional
- (void)loadNewData;
- (void)loadMoreData;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)waterHeightForCellIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)waterViewNumberOfColumns;

@end

@interface LWaterflowView : UIView<EGORefreshTableDelegate,TMQuiltViewDataSource,TMQuiltViewDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;
    
    TMQuiltView *qtmquitView;
}

@property (nonatomic, retain) NSMutableArray *images;

@property(nonatomic,assign)int pageNum;
@property (nonatomic,assign)id<WaterFlowDelegate>waterDelegate;

-(instancetype)initWithFrame:(CGRect)frame
               waterDelegate:(id<WaterFlowDelegate>)waterDelegate
             waterDataSource:(id<TMQuiltViewDataSource>)waterDatasource;

- (void)reloadData;

@end
