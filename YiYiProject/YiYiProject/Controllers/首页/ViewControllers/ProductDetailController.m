//
//  ProductDetailController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ProductDetailController.h"
#import "ProductModel.h"

@interface ProductDetailController ()
{
    ProductModel *aModel;
}

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
    
    self.bugButton.layer.cornerRadius = 5.0f;
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
    
    __weak typeof(self)weakSelf = self;
    NSString *url = [NSString stringWithFormat:HOME_PRODUCT_DETAIL,self.product_id,[GMAPI getAuthkey]];
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"result %@",result);
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic = result[@"pinfo"];
            
            aModel = [[ProductModel alloc]initWithDictionary:dic];
            
            [weakSelf prepareViewWithModel:aModel];
        }
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        NSLog(@"failBlock == %@",failDic[RESULT_INFO]);
        
    }];
}


#pragma mark - 事件处理

/*
   是否喜欢
 */
- (void)clickToLike:(UIButton *)sender
{
    
}

/*
   是否收藏
*/

- (void)clickToCollect:(UIButton *)sender
{
    
}

/*
  分享
 */

- (void)clickToShare:(UIButton *)sender
{
    
}

- (IBAction)clickToDaPeiShi:(id)sender {
    
}

- (IBAction)clickToContact:(id)sender {
    
}

- (IBAction)clickToBuy:(id)sender {
    
    
}

/*
 原图
*/
- (NSString *)originalImageForArr:(NSArray *)imagesArr
{
    if (imagesArr.count >= 1) {
        
        NSDictionary *imageDic = imagesArr[0];
        NSDictionary *originalImage = imageDic[@"original"];
        
        
        return originalImage[@"src"];
    }
    
    return @"";
}

- (NSString *)thumbImageForArr:(NSArray *)imagesArr
{
    if (imagesArr.count >= 1) {
        
        NSDictionary *imageDic = imagesArr[0];
        NSDictionary *originalImage = imageDic[@"540Middle"];
        
        
        return originalImage[@"src"];
    }
    
    return @"";
}

- (CGFloat)thumbImageHeightForArr:(NSArray *)imagesArr
{
    CGFloat aHeight = 0.f;
    CGFloat aWidth = 0.f;
    if (imagesArr.count >= 1) {
        
        NSDictionary *imageDic = imagesArr[0];
        NSDictionary *originalImage = imageDic[@"540Middle"];
        
        aHeight = [originalImage[@"height"] floatValue];
        aWidth = [originalImage[@"width"] floatValue];
    }
    //
    
    return aHeight * (DEVICE_WIDTH / aWidth);
}

/**
 *  给view 赋值
 *
 *  @param aProductModel
 */
- (void)prepareViewWithModel:(ProductModel *)aProductModel
{
    NSString *brandName = aProductModel.brand_info[@"brand_name"];
    self.brandName.text = [NSString stringWithFormat:@" %@ ",brandName];
    
    
    CGFloat aHeight = [self thumbImageHeightForArr:aProductModel.images];
    
    self.bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, aHeight)];
    [self.view addSubview:_bigImageView];
    
    [self.view insertSubview:_bigImageView atIndex:0];
    
//    self.bigImageView.height = aHeight;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[self thumbImageForArr:aProductModel.images]] placeholderImage:[UIImage imageNamed:nil]];
    
    self.priceLabel.text = [NSString stringWithFormat:@" %.2f  ",[aProductModel.product_price floatValue]];
    self.discountLabel.text = [NSString stringWithFormat:@"%.f折",aProductModel.discount_num * 10];
    
    self.titleLabel.text = aProductModel.product_name;
    self.xingHaoLabel.text = [NSString stringWithFormat:@"型号: %@",aProductModel.product_sku];
    self.biaoQianLabel.text = [NSString stringWithFormat:@"标签: %@",aProductModel.product_tag];
    
    NSString *mallName = aProductModel.mall_info[@"mall_name"];
    self.shangChangLabel.text = [NSString stringWithFormat:@"商场: %@",mallName];
    
    NSString *address = aProductModel.mall_info[@"street"];
    self.addressLabel.text = [NSString stringWithFormat:@"地址: %@",address];

}


#pragma mark - 创建视图

- (void)createNavigationbarTools
{
    
    UIButton *rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 190, 44)];
    rightView.backgroundColor=[UIColor clearColor];
    
    UIButton *heartButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [heartButton addTarget:self action:@selector(clickToLike:) forControlEvents:UIControlEventTouchUpInside];
//    [heartButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [heartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [heartButton setImage:[UIImage imageNamed:@"product_like"] forState:UIControlStateNormal];
    [heartButton setImage:[UIImage imageNamed:nil] forState:UIControlStateSelected];
    [heartButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    //收藏的
    
    UIButton *collectButton =[[UIButton alloc]initWithFrame:CGRectMake(74,0, 44,42.5)];
    [collectButton addTarget:self action:@selector(clickToCollect:) forControlEvents:UIControlEventTouchUpInside];
    [collectButton setImage:[UIImage imageNamed:@"product_shoucang"] forState:UIControlStateNormal];
//    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    collectButton.center = CGPointMake(rightView.width / 2.f, collectButton.center.y);
    [collectButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    UIButton *shareButton =[[UIButton alloc]initWithFrame:CGRectMake(rightView.width - 44,0, 44,44)];
//    [shareButton setTitle:@"评论" forState:UIControlStateNormal];
    shareButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [shareButton addTarget:self action:@selector(clickToShare:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"product_share"] forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

    [rightView addSubview:shareButton];
    [rightView addSubview:heartButton];
    [rightView addSubview:collectButton];
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    self.navigationItem.rightBarButtonItem = comment_item;
}


@end
