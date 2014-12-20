//
//  GmyMainViewController.m
//  YiYiProject
//
//  Created by gaomeng on 14/12/20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "GmyMainViewController.h"
#import "GShowStarsView.h"

@interface GmyMainViewController ()

@end

@implementation GmyMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    GShowStarsView *sd =[[GShowStarsView alloc]initWithStartNum:5 Frame:CGRectMake(100, 100, 100, 40)];
    sd.backgroundColor = [UIColor grayColor];
    sd.maxStartNum = 5;
    sd.starWidth = 20;
    sd.startNum = 4.0;
    [sd updateStartNum];
    
    [self.view addSubview:sd];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
