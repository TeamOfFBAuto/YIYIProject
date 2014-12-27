//
//  GnearbyStoreViewController.m
//  YiYiProject
//
//  Created by gaomeng on 14/12/27.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "GnearbyStoreViewController.h"
#import "GmPrepareNetData.h"
#import "NSDictionary+GJson.h"
#import "GLeadBuyMapViewController.h"

@interface GnearbyStoreViewController ()
{
    UIView *_upStoreInfoView;//顶部信息view
    UIScrollView *_mainScrollView;//底部scrollview
    UILabel *_mallNameLabel;//商城名称
    UILabel *_huodongLabel;//活动
    UILabel *_adressLabel;//地址
    
    UIScrollView *_floorScrollView;//楼层滚动view
    
    
}

@end

@implementation GnearbyStoreViewController



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    [self.view addSubview:_mainScrollView];
    
    
    [self prepareNetData];
    
    
    
    
}




//创建商家顶部信息view
-(void)creatUpStoreInfoView{
    
    _upStoreInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 185)];
    _upStoreInfoView.backgroundColor = [UIColor orangeColor];
    
    //商城名称
    _mallNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, DEVICE_WIDTH-15-15, 18)];
    
    //活动
    _huodongLabel = [[UILabel alloc]initWithFrame:CGRectMake(_mallNameLabel.frame.origin.x, CGRectGetMaxY(_mallNameLabel.frame)+13, _mallNameLabel.frame.size.width, 15)];
    _huodongLabel.font = [UIFont systemFontOfSize:15];
    
    //地址
    _adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_mallNameLabel.frame.origin.x, CGRectGetMaxY(_huodongLabel.frame)+8, _mallNameLabel.frame.size.width, 15)];
    _adressLabel.font = [UIFont systemFontOfSize:15];
    
    //带你买
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"带你去买" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:RGBCOLOR(114, 114, 114) forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(_mallNameLabel.frame.origin.x, CGRectGetMaxY(_adressLabel.frame)+22, 83, 37)];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 7;
    btn.layer.borderColor = [RGBCOLOR(114, 114, 114)CGColor];
    [btn addTarget:self action:@selector(leadYouBuy) forControlEvents:UIControlEventTouchUpInside];
    
    [_upStoreInfoView addSubview:_mallNameLabel];
    [_upStoreInfoView addSubview:_huodongLabel];
    [_upStoreInfoView addSubview:_adressLabel];
    [_upStoreInfoView addSubview:btn];
    
    
    [self.view addSubview:_upStoreInfoView];
    
}



//创建楼层滚动view
-(void)creatFloorScrollView{
    UIScrollView *floorScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_upStoreInfoView.frame), DEVICE_WIDTH, DEVICE_HEIGHT-64-_upStoreInfoView.frame.size.height)];
    floorScrollView.backgroundColor = [UIColor purpleColor];
    floorScrollView.contentSize = CGSizeMake(1000, floorScrollView.frame.size.height);
    [_mainScrollView addSubview:floorScrollView];
}




-(void)leadYouBuy{
    GLeadBuyMapViewController *cc = [[GLeadBuyMapViewController alloc]init];
    [self.navigationController pushViewController:cc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//请求网络数据
-(void)prepareNetData{
    //请求地址
    NSString *api = [NSString stringWithFormat:@"%@&mall_id=%@",HOME_CLOTH_NEARBYSTORE_DETAIL,self.storeIdStr];

    
    NSLog(@"请求的接口:%@",api);

    
    GmPrepareNetData *cc = [[GmPrepareNetData alloc]initWithUrl:api isPost:NO postData:nil];
    [cc requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"%@",result);
        
        
        [self creatUpStoreInfoView];
        
        _mallNameLabel.text = [NSString stringWithFormat:@"%@",[result stringValueForKey:@"mall_name"]];
//        _huodongLabel.text = [result stringValueForKey:@""];
        _adressLabel.text = [NSString stringWithFormat:@"地址：%@",[result stringValueForKey:@"address"]];
        
        [self creatFloorScrollView];
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
    }];
    
    
}











@end
