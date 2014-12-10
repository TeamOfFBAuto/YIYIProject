//
//  RootViewController.m
//  TestClouth
//
//  Created by lichaowei on 14/12/9.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "TTaiViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareItems
{
    
    NSArray *classNames = @[@"HomeViewController",@"TTaiViewController",@"UIViewController",@"MessageViewController",@"MineViewController"];
    
    NSArray *item_names = @[@"首页",@"T台",@"+",@"消息",@"我的"];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5;i ++) {
        
        NSString *className = classNames[i];
        UIViewController *vc = [[NSClassFromString(className) alloc]init];
        
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random() % (255)/256.f green:arc4random() % 255/256.f blue:arc4random() % 255/256.f alpha:1];
        UINavigationController *unvc = [[UINavigationController alloc]initWithRootViewController:vc];
        
        [items addObject:unvc];
    }
    
    self.viewControllers = [NSArray arrayWithArray:items];
    
    CGSize tabbarSize = self.tabBar.frame.size;
    UIView *customTabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tabbarSize.width, tabbarSize.height)];
    customTabbar.backgroundColor = [UIColor redColor];
    [self.tabBar addSubview:customTabbar];
    
    CGSize allSize = [UIScreen mainScreen].applicationFrame.size;
    
    CGFloat aWidth = allSize.width / 5;
    
    for (int i = 0; i < 5; i ++) {
        
        UIButton *item_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        item_btn.frame = CGRectMake(aWidth * i, 0,aWidth, tabbarSize.height);
        [item_btn setTitle:item_names[i] forState:UIControlStateNormal];
        item_btn.tag = 100 + i;
        [item_btn addTarget:self action:@selector(clickToSelectForIndex:) forControlEvents:UIControlEventTouchUpInside];
        [customTabbar addSubview:item_btn];
    }
    
}

- (void)clickToSelectForIndex:(UIButton *)sender
{
    if (sender.tag - 100 == 2) {
        NSLog(@"点击加号");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击中间按钮" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    self.selectedIndex = sender.tag - 100;
}

@end
