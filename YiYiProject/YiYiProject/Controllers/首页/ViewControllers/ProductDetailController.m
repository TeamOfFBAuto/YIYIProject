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
    
//    self.shopNameLabel.layer.borderWidth
//    self.shopNameLabel.layer.borderColor
    
}

- (void)viewWillLayoutSubviews NS_AVAILABLE_IOS(5_0)
{
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews NS_AVAILABLE_IOS(5_0)
{
    NSLog(@"viewDidLayoutSubviews");
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
//    label.backgroundColor = [UIColor orangeColor];
//    
//    [self.view addSubview:label];
//    
//    label.layer.cornerRadius = 5.f;
    
//    self.shopNameLabel.layer.cornerRadius = 10.f;
//    self.shopNameLabel.clipsToBounds = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    [heartButton setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    
    [heartButton setImage:[UIImage imageNamed:nil] forState:UIControlStateSelected];
    
    
    //收藏的
    
    UIButton *collectButton=[[UIButton alloc]initWithFrame:CGRectMake(74,0, 44/2,42.5)];
    [collectButton addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    [collectButton setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    
    
    
    
    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?140: 25-3,0, 43/2,44)];
    button_comment.tag=26;
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
    [button_comment setImage:[UIImage imageNamed:@"zhuanfa_image.png"] forState:UIControlStateNormal];
    // button_comment.userInteractionEnabled=NO;
    
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
