//
//  RegisterViewController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/13.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickToClose:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 网络请求

#pragma mark - 事件处理 

/**
 *  获取验证码
 */
- (IBAction)clickToSecurityCode:(id)sender {
    
//url:http://182.92.158.32/index.php?d=api&c=user_api&m=get_code
//    get方式调取
//    参数解释依次为:
//    mobile(手机号) string
//    type(验证码用途 1=》注册 2=》商店短信验证 3=》找回密码 4⇒申请成为搭配师获取验证码 默认为1) int
//    返回:
//    {“errorcode”:0,“msg”:“\u5e97\u94fa\u521b\u5efa\u6210\u529f”,'code':123456} errorcode 0 成功 1失败 msg为失败或成功文案
    
    SecurityCode_Type type;//默认注册
    NSString *mobile = self.phoneTF.text;
    
    if (![LTools isValidateMobile:mobile]) {
        
        [LTools alertText:@"请输入有效手机号"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:USER_GET_SECURITY_CODE,mobile,type];
    
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"result %@ erro %@",result,erro);
        
        
        [LTools showMBProgressWithText:result[RESULT_INFO] addToView:self.view];
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        NSLog(@"failDic %@ erro %@",failDic,erro);
        
        [LTools showMBProgressWithText:failDic[RESULT_INFO] addToView:self.view];
    }];

}

- (IBAction)clickToRegister:(id)sender {
    
    //url:http://182.92.158.32/index.php?d=api&c=user_api&m=register
    //    get方式调取
    //    参数解释依次为:
    //    username(昵称,可不填，系统自动分配一个) string
    //    password（密码，必须大于等于6位，不能有中文）string
    //    gender(性别，1=》男 2=》女，可不填，默认为女) int
    //    type(注册类型，1=》手机注册 2=》邮箱注册，默认为手机注册) int
    //    code(验证码 6位数字) int
    //    mobile(手机号) string
    
    NSString *userName = @"";
    NSString *password = self.passwordTF.text;
    Gender sex;//默认女
    Register_Type type = Register_Phone;//默认手机号方式
    int code = [self.securityTF.text intValue];
    NSString *mobile = self.phoneTF.text;
    
    if (![LTools isValidateMobile:mobile]) {
        
        [LTools alertText:@"请输入有效手机号"];
        return;
    }
    
    if (![LTools isValidatePwd:password]) {
        
        [LTools alertText:@"密码格式有误,请输入6~15位英文字母或数字"];
        return;
    }
    if (self.securityTF.text.length != 6) {
        
        [LTools alertText:@"验证码格式有误,请输入6位数字"];
        return;
    }
    
    
    NSString *url = [NSString stringWithFormat:USER_REGISTER_ACTION,userName,password,sex,type,code,mobile];
    
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"result %@ erro %@",result,erro);
        
        
        [LTools showMBProgressWithText:result[RESULT_INFO] addToView:self.view];
        
        [self performSelector:@selector(clickToClose:) withObject:nil afterDelay:0.2];
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        NSLog(@"failDic %@ erro %@",failDic,erro);
        
        [LTools showMBProgressWithText:failDic[RESULT_INFO] addToView:self.view];
    }];

}

- (IBAction)tapToHiddenKeyboard:(id)sender {
    
    [self.passwordTF resignFirstResponder];
    [self.securityTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
}

#pragma mark - 创建视图

#pragma mark - 代理

@end
