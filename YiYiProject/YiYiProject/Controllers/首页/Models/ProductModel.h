//
//  WorthBuyModel.h
//  YiYiProject
//
//  Created by lichaowei on 14/12/16.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BaseModel.h"
/**
 *  产品model
 */
@interface ProductModel : BaseModel

@property(nonatomic,retain)NSString *product_id;
@property(nonatomic,retain)NSString *distance;
@property(nonatomic,retain)NSString *mall_id;
@property(nonatomic,retain)NSString *longitude;
@property(nonatomic,retain)NSString *latitude;
@property(nonatomic,retain)NSString *mall_name;
@property(nonatomic,retain)NSString *product_name;

@property(nonatomic,retain)NSString *product_price;
@property(nonatomic,assign)CGFloat discount_num;
@property(nonatomic,retain)NSString *product_gender;

@property(nonatomic,retain)NSString *product_like_num;
@property(nonatomic,retain)NSString *product_fav_num;

@property(nonatomic,retain)NSString *product_brand_id;
@property(nonatomic,retain)NSString *product_share_num;

@property(nonatomic,retain)NSString *product_sku;
@property(nonatomic,retain)NSString *product_hostsale;

@property(nonatomic,retain)NSString *product_add_time;
@property(nonatomic,retain)NSArray *imagelist;//图片数组

@property(nonatomic,retain)NSString *product_mall_id;
@property(nonatomic,retain)NSString *product_shop_id;
@property(nonatomic,retain)NSString *product_tag;
@property(nonatomic,retain)NSString *product_status;
@property(nonatomic,retain)NSString *product_hotsale;
@property(nonatomic,assign)NSInteger is_favor;

@property(nonatomic,assign)NSInteger is_like;

@property(nonatomic,retain)NSDictionary *brand_info;
@property(nonatomic,retain)NSDictionary *mall_info;

@property(nonatomic,retain)NSArray *images;//图片数组(单品详情)


@end
