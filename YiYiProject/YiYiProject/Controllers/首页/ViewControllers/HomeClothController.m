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
    GCycleScrollView *_gscrollView;//上方循环滚动的scrollview
    UIView *_pinpaiView;//品牌的view
    
    UIView *_nearbyView;//附近的view
    UIScrollView *_scrollview_nearbyView;//附近的view上面的scrollview
    
    UIScrollView *_scrollView_pinpai;//品牌的scrollview
    
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
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 180+218+155);
    
    [scrollView addSubview:[self creatGscrollView]];//循环滚动幻灯片
    
    [scrollView addSubview:[self creatNearbyView]];//附近
    
    [scrollView addSubview:[self creatPinpaiView]];//品牌
    
    [self.view addSubview:scrollView];
    
    
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
    
    
    _nearbyView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_gscrollView.frame), DEVICE_WIDTH, 218)];
    _nearbyView.backgroundColor = [UIColor whiteColor];
    
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 30, 15)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"附近";
    [_nearbyView addSubview:titleLabel];
    
    
    //滚动界面
    _scrollview_nearbyView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 30, DEVICE_WIDTH-15-40, 218-30-14)];
    _scrollview_nearbyView.backgroundColor = [UIColor whiteColor];
    _scrollview_nearbyView.contentSize = CGSizeMake(1000, 218-30-14);
    _scrollview_nearbyView.tag = 10;
    _scrollview_nearbyView.delegate = self;
    [_nearbyView addSubview:_scrollview_nearbyView];
    
    
    //标题下面的分割线
    UIView *downTitleLine = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame)+3, DEVICE_WIDTH-30, 1)];
    downTitleLine.backgroundColor = RGBCOLOR(213, 213, 213);
    [_nearbyView addSubview:downTitleLine];
    
    
    
    //向右按钮btn
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(DEVICE_WIDTH-37, CGRectGetMaxY(downTitleLine.frame)+15, 22, 22)];
    rightBtn.layer.cornerRadius = 4;
    rightBtn.backgroundColor = RGBCOLOR(195, 195, 195);
    [rightBtn addTarget:self action:@selector(nearGoRight) forControlEvents:UIControlEventTouchUpInside];
    [_nearbyView addSubview:rightBtn];
    
    
    
    
    return _nearbyView;
}


//品牌
-(UIView *)creatPinpaiView{
    
    _pinpaiView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nearbyView.frame), DEVICE_HEIGHT, 155)];
    _pinpaiView.backgroundColor = RGBCOLOR(242, 242, 242);
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 30, 15)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"品牌";
    [_pinpaiView addSubview:titleLabel];
    
    
    //滚动界面
    _scrollView_pinpai = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 30, DEVICE_WIDTH-15-15, 155-30-14)];
    _scrollView_pinpai.backgroundColor = RGBCOLOR(242, 242, 242);
    _scrollView_pinpai.contentSize = CGSizeMake(1000, 155-30-14);
    _scrollView_pinpai.tag = 10;
    _scrollView_pinpai.delegate = self;
    [_pinpaiView addSubview:_scrollView_pinpai];
    
    
    //标题下面的分割线
    UIView *downTitleLine = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame)+3, DEVICE_WIDTH-30, 1)];
    downTitleLine.backgroundColor = RGBCOLOR(213, 213, 213);
    [_pinpaiView addSubview:downTitleLine];
    
    
    
    
    //向左按钮btn
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(15, CGRectGetMaxY(downTitleLine.frame)+40, 22, 22)];
    leftBtn.layer.cornerRadius = 4;
    leftBtn.backgroundColor = RGBCOLOR(195, 195, 195);
    [leftBtn addTarget:self action:@selector(nearGoRight) forControlEvents:UIControlEventTouchUpInside];
    [_pinpaiView addSubview:leftBtn];
    
    
    //向右按钮btn
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(DEVICE_WIDTH-37, CGRectGetMaxY(downTitleLine.frame)+40, 22, 22)];
    rightBtn.layer.cornerRadius = 4;
    rightBtn.backgroundColor = RGBCOLOR(195, 195, 195);
    [rightBtn addTarget:self action:@selector(nearGoRight) forControlEvents:UIControlEventTouchUpInside];
    [_pinpaiView addSubview:rightBtn];
    
    
    return _pinpaiView;
    
}




-(void)nearGoRight{
    CGFloat xx = _scrollview_nearbyView.contentOffset.x;
    CGFloat yy = _scrollview_nearbyView.contentOffset.y;
    xx+=100;
    if (xx>_scrollview_nearbyView.contentSize.width) {
        xx = _scrollview_nearbyView.contentSize.width;
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        _scrollview_nearbyView.contentOffset = CGPointMake(xx, yy);
    } completion:^(BOOL finished) {
        
    }];
}





#pragma mark - 循环滚动的scrollView的代理方法

//滚动总共几页
- (NSInteger)numberOfPages
{
    
    return 3;
}

//每一页
- (UIView *)pageAtIndex:(NSInteger)index
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 180)];
    

    if (index == 0) {
        view.backgroundColor = [UIColor yellowColor];
    }else if (index == 1){
        view.backgroundColor = [UIColor orangeColor];
    }else if (index == 2){
        view.backgroundColor = [UIColor greenColor];
    }
    
    return view;
    
}

//点击的哪一页
- (void)didClickPage:(GCycleScrollView *)csView atIndex:(NSInteger)index
{
    
    id obj=NSClassFromString(@"UIAlertController");
    if ( obj!=nil){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前点击第%ld个页面",index] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[NSString stringWithFormat:@"当前点击第%ld个页面",index]
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 10) {
        NSLog(@"x:%f,y:%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    }
    
    
}




@end
