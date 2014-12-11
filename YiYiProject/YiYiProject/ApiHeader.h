//
//  ApiHeader.h
//  YiYiProject
//
//  Created by lichaowei on 14/12/11.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#ifndef YiYiProject_ApiHeader_h
#define YiYiProject_ApiHeader_h

//常用宏

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]


//整屏幕的Frame
#define ALL_FRAME [UIScreen mainScreen].applicationFrame
//宽
#define ALL_FRAME_WIDTH ALL_FRAME.size.width
//高
#define ALL_FRAME_HEIGHT ALL_FRAME.size.height

//保存用户信息的常量key
#define USER_FACE @"userface"
#define USER_NAME @"username"
#define USER_PWD @"userPw"
#define USER_UID @"useruid"
#define USER_LONGIN @"user_in" //0是未登陆  1是已登陆
#define USER_AUTHOD @"user_authod"
#define USER_CHECKUSER @"checkfbuser"

#define USER_AUTHKEY_OHTER @"otherKey"//第三方key
#define USRR_AUTHKEY @"authkey"
#define USER_DEVICE_TOKEN @"DEVICE_TOKEN"

//接口地址


#endif
