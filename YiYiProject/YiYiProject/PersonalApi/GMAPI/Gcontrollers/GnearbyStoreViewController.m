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
#import "CWSegmentedControl.h"
#import "UIViewAdditions.h"
#import "SVGloble.h"
#import "SVTopScrollView.h"
#import "SVRootScrollView.h"

@interface GnearbyStoreViewController ()<CWSegmentDelegate,UIScrollViewDelegate>
{
    UIView *_upStoreInfoView;//顶部信息view
    UIScrollView *_mainScrollView;//底部scrollview
    UILabel *_mallNameLabel;//商城名称
    UILabel *_huodongLabel;//活动
    UILabel *_adressLabel;//地址
    
    UIScrollView *_floorScrollView;//楼层滚动view
    
    CWSegmentedControl *_segment;
    UIScrollView *_downScrollView;
    
    UITableView *_tabelView;
    
    
    SVTopScrollView *_topScrollView;
    SVRootScrollView *_rootScrollView;
    
}

@end

@implementation GnearbyStoreViewController



-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    [self.view addSubview:_mainScrollView];
    [self creatUpStoreInfoView];
    [self creatFloorScrollView];
    
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

    [SVGloble shareInstance].tableViewHeight = 300.0f;
    
    UIView *gUpDownScrollView =[[UIView alloc]initWithFrame:CGRectMake(0, 185, DEVICE_WIDTH, DEVICE_HEIGHT-185)];
    gUpDownScrollView.backgroundColor = [UIColor whiteColor];
    
    
    _topScrollView = [SVTopScrollView shareInstance];
    _rootScrollView = [SVRootScrollView shareInstance];
    
    _topScrollView.nameArray = @[@"F1",@"F2",@"F3",@"F4",@"F5",@"F6",@"F7",@"F8",@"F9",@"F10",@"F11",@"F12"];
    _rootScrollView.viewCountNum = _topScrollView.nameArray.count;
    
    [_topScrollView initWithNameButtons];
    [_rootScrollView initWithViews];
    
    [gUpDownScrollView addSubview:_topScrollView];
    [gUpDownScrollView addSubview:_rootScrollView];
    
    
    [_mainScrollView addSubview:gUpDownScrollView];

    
    
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

        _mallNameLabel.text = [NSString stringWithFormat:@"%@",[result stringValueForKey:@"mall_name"]];
//        _huodongLabel.text = [result stringValueForKey:@""];
        _adressLabel.text = [NSString stringWithFormat:@"地址：%@",[result stringValueForKey:@"address"]];

    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
    }];
    
    
}











@end
