//
//  HomeViewController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBuyController.h"
#import "HomeClothController.h"
#import "HomeMatchController.h"

@interface HomeViewController ()
{
    UIView *menu_view;
    
    HomeBuyController   *buy_viewcontroller;
    HomeClothController *cloth_viewcontroller;
    HomeMatchController *match_viewcontroller;
}

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitleLabel.text = @"首页";
    
    [self createMemuView];
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    [self clickToSwap:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建视图

- (void)createMemuView
{
    menu_view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ALL_FRAME_WIDTH, 30)];
    menu_view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:menu_view];
    NSArray *titles = @[@"值得买",@"衣+衣",@"搭配师"];
    
    CGFloat aWidth = ALL_FRAME_WIDTH / 3.f;
    
    for (int i = 0; i < titles.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(aWidth * i, 0, aWidth, menu_view.height);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [menu_view addSubview:btn];
        [btn addTarget:self action:@selector(clickToSwap:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 事件处理

- (void)clickToSwap:(UIButton *)sender
{
    int tag = (int)sender.tag;
    
    CGFloat aFrameY = menu_view.bottom;
    switch (tag) {
        case 100:
        {
            if (buy_viewcontroller)
            {
                buy_viewcontroller.view.hidden = NO;
            }
            else
            {
                buy_viewcontroller = [[HomeBuyController alloc]init];
                buy_viewcontroller.view.frame = CGRectMake(0, aFrameY, self.view.frame.size.width, self.view.frame.size.height - menu_view.height);
                buy_viewcontroller.rootViewController = self;
                [self.view addSubview:buy_viewcontroller.view];
            }
            
            buy_viewcontroller.view.backgroundColor = [UIColor redColor];
            
            [self controlViewController:buy_viewcontroller];
            
        }
            break;
        case 101:
        {
            if (cloth_viewcontroller)
            {
                cloth_viewcontroller.view.hidden = NO;
            }
            else
            {
                cloth_viewcontroller = [[HomeClothController alloc]init];
                cloth_viewcontroller.view.frame = CGRectMake(0, aFrameY, self.view.frame.size.width, self.view.frame.size.height-35);
                cloth_viewcontroller.rootViewController = self;
                [self.view addSubview:cloth_viewcontroller.view];
            }
            
            cloth_viewcontroller.view.backgroundColor = [UIColor greenColor];
            [self controlViewController:cloth_viewcontroller];
            
            
        }
            break;
        case 102:
        {
            if (match_viewcontroller)
            {
                match_viewcontroller.view.hidden = NO;
            }
            else
            {
                match_viewcontroller = [[HomeMatchController alloc]init];
                match_viewcontroller.view.frame = CGRectMake(0, aFrameY, self.view.frame.size.width, self.view.frame.size.height  -35);
                match_viewcontroller.rootViewController = self;
                [self.view addSubview:match_viewcontroller.view];
            }
            
            match_viewcontroller.view.backgroundColor = [UIColor purpleColor];
            
            [self controlViewController:match_viewcontroller];
            
        }
            break;
        default:
            NSLog(@"Controller-Error");
            break;
    }
}

- (void)controlViewController:(UIViewController *)vc
{
    buy_viewcontroller.view.hidden = [vc isKindOfClass:[HomeBuyController class]] ? NO : YES;//服务介绍
    cloth_viewcontroller.view.hidden = [vc isKindOfClass:[HomeClothController class]] ? NO : YES;//商家介绍
    match_viewcontroller.view.hidden = [vc isKindOfClass:[HomeMatchController class]] ? NO : YES;//商家服务
}

@end
