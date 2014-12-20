//
//  ApiHeader.h
//  YiYiProject
//
//  Created by lichaowei on 14/12/11.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#ifndef YiYiProject_ApiHeader_h
#define YiYiProject_ApiHeader_h

//颜色相关
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

//屏幕尺寸相关
#define ALL_FRAME [UIScreen mainScreen].applicationFrame
//宽
#define ALL_FRAME_WIDTH ALL_FRAME.size.width
//高
#define ALL_FRAME_HEIGHT ALL_FRAME.size.height

//版本判断相关
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

//保存用户信息设备信息相关

#define USER_INFO @"userInfo"//用户信息
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


#define LOGIN_SUCCESS @"login_success"//登录状态

//通知 信息相关

#define NOTIFICATION_LOGIN @"loginin_success" //登录成功通知
#define NOTIFICATION_LOGOUT @"logout_success" //退出登录通知

//错误提示信息 

#define ALERT_ERRO_PHONE @"请输入有效手机号"
#define ALERT_ERRO_PASSWORD @"密码格式有误,请输入6~15位英文字母或数字"
#define ALERT_ERRO_SECURITYCODE @"验证码格式有误,请输入6位数字"
#define ALERT_ERRO_FINDPWD @"两次密码不一致"

#define L_PAGE_SIZE 20

//登录类型 normal为正常手机登陆，sweibo、qq、weixin分别代表新浪微博、qq、微信登陆
typedef enum{
    Login_Normal = 0,
    Login_Sweibo,
    Login_QQ,
    Login_Weixin
}Login_Type;

//性别
typedef enum{
    Gender_Girl = 1,
    Gender_Boy
}Gender;

//注册类型，1=》手机注册 2=》邮箱注册，默认为手机注册
typedef enum{
    Register_Phone = 1,
    Register_Email
}Register_Type;

//验证码用途 1=》注册 2=》商店短信验证 3=》找回密码 4⇒申请成为搭配师获取验证码 默认为1) int
typedef enum{
    SecurityCode_Register = 1,
    SecurityCode_Shop,
    SecurityCode_FindPWD,
    SecurityCode_Match
}SecurityCode_Type;

//接口地址

//登录
#define USER_LOGIN_ACTION @"http://182.92.158.32/index.php?d=api&c=user_api&m=login&type=%@&password=%@&thirdid=%@&nickname=%@&thirdphoto=%@&gender=%d&devicetoken=%@&mobile=%@"
//注册
#define USER_REGISTER_ACTION @"http://182.92.158.32/index.php?d=api&c=user_api&m=register&username=%@&password=%@&gender=%d&type=%d&code=%d&mobile=%@"
//获取验证码
#define USER_GET_SECURITY_CODE @"http://182.92.158.32/index.php?d=api&c=user_api&m=get_code&mobile=%@&type=%d"
//找回密码
#define USER_GETBACK_PASSWORD @"http://182.92.158.32/index.php?d=api&c=user_api&m=get_back_password&mobile=%@&code=%d&new_password=%@"

//首页--值得买
#define HOME_DESERVE_BUY @"http://182.92.158.32/?d=api&c=products&m=listWorthBuy&long=%@&lat=%@&sex=%d&discount=%d&page=%d&count=%d"




















//个人信息相关
#define PERSON_CHANGEUSERBANNER @"http://182.92.158.32/index.php?d=api&c=user_api&m=update_user_banner"




#pragma mark - 搭配师相关接口 ******************************add by sn
/*
 action(该参数有两个值，等于my时表示获取我的搭配师，当popu时表示获取人气搭配师，默认为my)
 authcode(uid加密串，当action参数为my时需要该参数，不是my时不用传)
 tagid(搭配师标签的id，当action参数为popu时并需要做筛选时需要该参数，不是popu时不用传 ，当不做筛选时刻不传该参数或者传0)
 page(页数 默认1)
 perpage(每页显示数量 默认10)
 */
#define GET_DAPEISHI_URL @"http://182.92.158.32/index.php?d=api&c=division_t&m=get_division_teachers&action=%@&authcode=%@&tagid=%@&page=%d&perpage=%d"



#endif
