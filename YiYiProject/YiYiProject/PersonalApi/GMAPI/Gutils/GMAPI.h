//
//  GMAPI.h
//  YiYiProject
//
//  Created by gaomeng on 14/12/13.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>


#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
//保存用户信息的常量key
#define USER_FACE @"userface"
#define USER_NAME @"username"
#define USER_PW @"userPw"
#define USER_UID @"useruid"
#define USER_IN @"user_in" //0是未登陆  1是已登陆
#define DEVICETOKEN @"pushdevicetoken"

@interface GMAPI : NSObject


+(NSString *)getUsername;


+(NSString *)getDeviceToken;

+(NSString *)getAuthkey;

+(NSString *)getUid;

+(NSString *)getUserPassWord;


+ (MBProgressHUD *)showMBProgressWithText:(NSString *)text addToView:(UIView *)aView;


//写数据=========================

//保存用户banner到本地
+(BOOL)setUserBannerImageWithData:(NSData *)data;

//保存用户头像到本地
+(BOOL)setUserFaceImageWithData:(NSData *)data;



//获取document路径
+ (NSString *)documentFolder;


//读数据=========================

//获取用户bannerImage
+(UIImage *)getUserBannerImage;

//获取用户头像Image
+(UIImage *)getUserFaceImage;


//获取document路径
+ (NSString *)documentFolder;

//清除banner和头像
+(BOOL)cleanUserFaceAndBanner;



//NSUserDefault 缓存
//存
+ (void)cache:(id)dataInfo ForKey:(NSString *)key;
//取
+ (id)cacheForKey:(NSString *)key;



@end
