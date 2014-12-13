//
//  HomeBuyController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/12.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "HomeBuyController.h"
#import "TMQuiltView.h"
#import "TMPhotoQuiltViewCell.h"

#import "LWaterflowView.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface HomeBuyController ()<TMQuiltViewDataSource,WaterFlowDelegate>
{
    LWaterflowView *waterFlow;
}

@property (nonatomic, retain) NSMutableArray *images;

@end

@implementation HomeBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    waterFlow = [[LWaterflowView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, ALL_FRAME_HEIGHT - 49 - 30) waterDelegate:nil waterDataSource:nil];
    waterFlow.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:waterFlow];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 事件处理


@end
