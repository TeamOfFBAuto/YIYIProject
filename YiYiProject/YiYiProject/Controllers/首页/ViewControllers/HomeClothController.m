//
//  HomeClothViewController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/12.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "HomeClothController.h"
#import "GCycleScrollView.h"

@interface HomeClothController ()<GCycleScrollViewDatasource,GCycleScrollViewDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    GCycleScrollView *_gscrollView;//循环滚动的scrollview
    UIView *_nearByView;//附近的view
    UIView *_pinpaiView;//品牌的view
    
}
@end

@implementation HomeClothController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT -  64 - 44)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 1000);
    
    
    
    
    [scrollView addSubview:[self creatGscrollView]];//循环滚动幻灯片
    
    [scrollView addSubview:[self creatNearbyView]];//附近
    
    [scrollView addSubview:[self creatPinpaiView]];
    
    
    [self.view addSubview:scrollView];
    
    
    
    
//    [self.view addSubview:[self creatGscrollView]];
//    [self.view addSubview:[self creatNearbyView]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



///创建循环滚动的scrollview
-(UIView*)creatGscrollView{
    _gscrollView = [[GCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 180)];
    _gscrollView.backgroundColor = [UIColor orangeColor];
    _gscrollView.delegate = self;
    _gscrollView.datasource = self;
    return _gscrollView;
}

//创建附近的view
-(UIView*)creatNearbyView{
    _nearByView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_gscrollView.frame), DEVICE_WIDTH, 218)];
    _nearByView.backgroundColor = [UIColor purpleColor];
    return _nearByView;
}

//品牌
-(UIView *)creatPinpaiView{
    _pinpaiView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nearByView.frame), DEVICE_HEIGHT, 218)];
    _pinpaiView.backgroundColor = [UIColor blueColor];
    return _pinpaiView;
    
}



#pragma mark - 循环滚动的scrollView

- (NSInteger)numberOfPages
{
    
    return 3;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 180)];
    

    if (index == 0) {
        view.backgroundColor = [UIColor yellowColor];
    }else if (index == 1){
        view.backgroundColor = [UIColor orangeColor];
    }else if (index == 2){
        view.backgroundColor = [UIColor yellowColor];
    }
    
    return view;
    
}

- (void)didClickPage:(GCycleScrollView *)csView atIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"当前点击第%ld个页面",index]
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}





@end
