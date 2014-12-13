//
//  MineViewController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitleLabel.text = @"我的";
    
    if ([LTools cacheBoolForKey:USER_LONGIN] == NO) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        [self presentViewController:login animated:YES completion:nil];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///创建用户头像banner的view
-(UIView *)creatTableViewHeaderView{
    //底层view
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 240.00/320*DEVICE_WIDTH)];
    backView.backgroundColor = RGBCOLOR_ONE;
    
    
    
    return backView;
}

@end
