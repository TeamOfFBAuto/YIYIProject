//
//  HomeClothViewController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/12.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "HomeClothController.h"
#import "GCycleScrollView.h"

@interface HomeClothController ()<UITableViewDataSource,UITableViewDelegate,GCycleScrollViewDatasource,GCycleScrollViewDelegate>
{
    UITableView *_tableView;
    GCycleScrollView *_gscrollView;
}
@end

@implementation HomeClothController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
    
    [self.view addSubview:_tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 180)];
        headerView.backgroundColor = [UIColor orangeColor];
        _gscrollView = [[GCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 180)];
        _gscrollView.backgroundColor = [UIColor orangeColor];
        _gscrollView.delegate = self;
        _gscrollView.datasource = self;
        [headerView addSubview:_gscrollView];
        [cell.contentView addSubview:_gscrollView];
    }
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
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
        view.backgroundColor = [UIColor purpleColor];
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
