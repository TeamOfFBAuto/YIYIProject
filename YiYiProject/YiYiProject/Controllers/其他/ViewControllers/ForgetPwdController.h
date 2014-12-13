//
//  ForgetPwdController.h
//  YiYiProject
//
//  Created by lichaowei on 14/12/13.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  忘记密码
 */
@interface ForgetPwdController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *securityTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *secondPassword;
- (IBAction)clickToCommit:(id)sender;

@end
