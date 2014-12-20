//
//  ProductDetailController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ProductDetailController.h"

@interface ProductDetailController ()

@end

@implementation ProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS7DAOHANGLANBEIJING_PUSH2] forBarMetrics: UIBarMetricsDefault];
    }
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    self.shopNameLabel.text = @"  店铺的名字会很长的  ";
    
    self.bugButton.layer.cornerRadius = 10.0f;
    self.bugButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.bugButton.layer.borderWidth = 1.f;
    
    [self createNavigationbarTools];
    
    [self networkForDetail];
    
}

- (void)viewWillLayoutSubviews NS_AVAILABLE_IOS(5_0)
{
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews NS_AVAILABLE_IOS(5_0)
{
    NSLog(@"viewDidLayoutSubviews");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求

- (void)networkForDetail
{
    NSString *url = [NSString stringWithFormat:HOME_PRODUCT_DETAIL,self.product_id,[GMAPI getAuthkey]];
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"result %@",result);
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        NSLog(@"failBlock == %@",failDic[RESULT_INFO]);
        
    }];
}


#pragma mark - 事件处理

- (IBAction)clickToDaPeiShi:(id)sender {
}

- (IBAction)clickToContact:(id)sender {
}
- (IBAction)clickToBuy:(id)sender {
}


#pragma mark - 创建视图

- (void)createNavigationbarTools
{
    UIButton *heartButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [heartButton addTarget:self action:@selector(dianzan:) forControlEvents:UIControlEventTouchUpInside];
    
    [heartButton setTitle:@"喜欢" forState:UIControlStateNormal];
    
    [heartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [heartButton setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    
    [heartButton setImage:[UIImage imageNamed:nil] forState:UIControlStateSelected];
    
    
    //收藏的
    
    UIButton *collectButton=[[UIButton alloc]initWithFrame:CGRectMake(74,0, 44,42.5)];
    [collectButton addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    [collectButton setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?140: 25-3,0, 44,44)];
    [button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
    [button_comment setImage:[UIImage imageNamed:@"zhuanfa_image.png"] forState:UIControlStateNormal];
    [button_comment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *    rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    // [rightView addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button_comment];
    
    rightView.backgroundColor=[UIColor clearColor];

    [rightView addSubview:heartButton];
    [rightView addSubview:collectButton];
    
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    self.navigationItem.rightBarButtonItem=comment_item;
}


@end
