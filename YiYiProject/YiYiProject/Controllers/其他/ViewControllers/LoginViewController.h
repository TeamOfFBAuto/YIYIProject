//
//  LoginViewController.h
//  OneTheBike
//
//  Created by lichaowei on 14/10/26.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *pwdTF;



- (IBAction)clickToSina:(id)sender;
- (IBAction)clickToQQ:(id)sender;
- (IBAction)tapToHiddenKeyboard:(id)sender;

@end
