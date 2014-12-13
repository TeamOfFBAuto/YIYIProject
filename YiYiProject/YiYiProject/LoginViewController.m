//
//  LoginViewController.m
//  OneTheBike
//
//  Created by lichaowei on 14/10/26.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocial.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

- (void)createLoginView
{
    
}

- (IBAction)clickToSina:(id)sender {
    
    [self loginToPlat:UMShareToSina];
}

- (IBAction)clickToQQ:(id)sender {
    
    [self loginToPlat:UMShareToQQ];
}

- (IBAction)clickToWeiXin:(id)sender {
    //微信
    
    NSLog(@"微信");
    
    [self loginToPlat:UMShareToWechatSession];
}


- (void)loginToPlat:(NSString *)snsPlatName
{
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    
    __weak typeof(self)weakSelf = self;
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsPlatName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"login response is %@",response);
        
        //获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatName];
            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
            
            Login_Type type;
            if ([snsPlatName isEqualToString:UMShareToSina]) {
                type = Login_Sweibo;
            }else if ([snsPlatName isEqualToString:UMShareToQQ]) {
                type = Login_QQ;
            }else if ([snsPlatName isEqualToString:UMShareToSina]) {
                type = Login_Sweibo;
            }

//            weakSelf loginType:<#(Login_Type)#> thirdId:<#(NSString *)#> nickName:<#(NSString *)#> thirdphoto:<#(NSString *)#> gender:<#(Gender)#> password:<#(NSString *)#>
        }
        
    });
}

#pragma mark - 事件处理

- (void)autoShareToSina
{
    UIImage *shareImage = [UIImage imageNamed:@"share_Image"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"@骑叭 安装完成，据说这是专门为自行车运动极客打造的骑行软件，先用为快了哦，哈哈" image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

- (void)autoShareToQQ
{
    UIImage *shareImage = [UIImage imageNamed:@"share_Image"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"分享内嵌文字" image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}


//清空原先数据
- (void)changeUser:(NSNotification *)notification
{
    
}

#pragma mark - 数据解析

#pragma mark - 网络请求

/**
 *  @param type       (登录方式，normal为正常手机登陆，sweibo、qq、weixin分别代表新浪微博、qq、微信登陆) string
 *  @param thirdId    (第三方id，若为第三方登陆需要该参数)
 *  @param nickName   (第三方昵称，若为第三方登陆需要该参数)
 *  @param thirdphoto (第三方头像，若为第三方登陆需要该参数)
 *  @param gender     (性别，若第三方登录可填写，也可不填写，1=》男 2=》女 默认为女) int
 */

- (void)loginType:(Login_Type)loginType
          thirdId:(NSString *)thirdId
             nickName:(NSString *)nickName
       thirdphoto:(NSString *)thirdphoto
           gender:(Gender)gender
         password:(NSString *)password
{
    NSString *type;
    switch (loginType) {
        case Login_Normal:
        {
            type = @"normal";
        }
            break;
        case Login_Sweibo:
        {
            type = @"sweibo";
        }
            break;
        case Login_QQ:
        {
            type = @"qq";
        }
            break;
        case Login_Weixin:
        {
           type = @"weixin";
        }
            break;
            
        default:
            break;
    }
    
    NSString *url = [NSString stringWithFormat:LOGIN_ACTION,type,password,thirdId,nickName,thirdphoto,gender,@"test"];
    
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestSpecialCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"result %@ erro %@",result,erro);
        
            
            if ([type isEqualToString:UMShareToQQ]) {
                
//                [self autoShareToQQ];
            }else
            {
                [self autoShareToSina];
            }
            
//        }
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        NSLog(@"failDic %@ erro %@",failDic,erro);
        
    }];
}



@end
