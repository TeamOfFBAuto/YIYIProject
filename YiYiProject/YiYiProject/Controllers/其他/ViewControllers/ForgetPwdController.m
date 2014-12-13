//
//  ForgetPwdController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/13.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ForgetPwdController.h"

@interface ForgetPwdController ()

@end

@implementation ForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 事件处理

#pragma mark - 网络请求

- (IBAction)tapToHiddenKeyboard:(id)sender {
    
    [self.passwordTF resignFirstResponder];
    [self.securityTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.secondPassword resignFirstResponder];
}


/**
 *  获取验证码
 */
- (IBAction)clickToSecurityCode:(id)sender {
    
    SecurityCode_Type type = SecurityCode_FindPWD;//找回密码
    NSString *mobile = self.phoneTF.text;
    
    if (![LTools isValidateMobile:mobile]) {
        
        [LTools alertText:ALERT_ERRO_PHONE];
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


- (IBAction)clickToCommit:(id)sender {
    
    
    //url:http://182.92.158.32/index.php?d=api&c=user_api&m=get_back_password
//    get方式调取
//    参数解释依次为:
//    mobile(手机号) string
//    code（验证码）int
//    new_password(新密码) str
    
    
    NSString *password = self.passwordTF.text;
    int code = [self.securityTF.text intValue];
    NSString *mobile = self.phoneTF.text;
    
    if (![LTools isValidateMobile:mobile]) {
        
        [LTools alertText:ALERT_ERRO_PHONE];
        return;
    }
    
    if (![LTools isValidatePwd:password]) {
        
        [LTools alertText:ALERT_ERRO_PASSWORD];
        return;
    }
    
    if (![self.passwordTF.text isEqualToString:self.secondPassword.text]) {
        
        [LTools alertText:ALERT_ERRO_SECURITYCODE];
        
        return;
    }
    
    if (self.securityTF.text.length != 6) {
        
        [LTools alertText:ALERT_ERRO_SECURITYCODE];
        return;
    }
    
    
    NSString *url = [NSString stringWithFormat:USER_GETBACK_PASSWORD,mobile,code,password];
    
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

- (void)clickToClose:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
