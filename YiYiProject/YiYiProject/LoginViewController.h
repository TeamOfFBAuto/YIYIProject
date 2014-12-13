//
//  LoginViewController.h
//  OneTheBike
//
//  Created by lichaowei on 14/10/26.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

//normal为正常手机登陆，sweibo、qq、weixin分别代表新浪微博、qq、微信登陆
typedef enum{
    Login_Normal = 0,
    Login_Sweibo,
    Login_QQ,
    Login_Weixin
}Login_Type;

typedef enum{
    Gender_Girl = 0,
    Gender_Boy
}Gender;

@interface LoginViewController : UIViewController
- (IBAction)clickToSina:(id)sender;
- (IBAction)clickToQQ:(id)sender;

@end
