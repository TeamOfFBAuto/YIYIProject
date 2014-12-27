//
//  GnearbyStoreViewController.m
//  YiYiProject
//
//  Created by gaomeng on 14/12/27.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "GnearbyStoreViewController.h"
#import "RefreshTableView.h"
#import "GmPrepareNetData.h"

@interface GnearbyStoreViewController ()<UITableViewDataSource,RefreshDelegate>
{
    RefreshTableView *_tableView;
    
    int _page;//第几页
    int _pageCapacity;//一页请求几条数据
    NSArray *_dataArray;//数据源
    
    CGFloat _cellHight;//单元格高度

    
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
    
    _tableView = [[RefreshTableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//请求网络数据
-(void)prepareNetData{
    //请求地址
    NSString *api = nil;

    
    NSLog(@"请求的接口:%@",api);
    
    __weak typeof (self)bself = self;
    
    GmPrepareNetData *cc = [[GmPrepareNetData alloc]initWithUrl:api isPost:NO postData:nil];
    
}

#pragma mark - 下拉刷新上提加载更多
/**
 *  刷新数据列表
 *
 *  @param dataArr  新请求的数据
 *  @param isReload 判断在刷新或者加载更多
 */
- (void)reloadData:(NSArray *)dataArr isReload:(BOOL)isReload
{
    
    if (isReload) {
        
        _dataArray = dataArr;
        
    }else
    {
        NSMutableArray *newArr = [NSMutableArray arrayWithArray:_dataArray];
        [newArr addObjectsFromArray:dataArr];
        _dataArray = newArr;
    }
    
    
    
    _tableView.dataArray = [NSMutableArray arrayWithArray:_dataArray];
    
    [_tableView performSelector:@selector(finishReloadigData) withObject:nil afterDelay:0.2];
}



#pragma - mark RefreshDelegate <NSObject>

- (void)loadNewData
{
    _page = 1;
    _tableView.isReloadData = YES;
    
    _dataArray = nil;
    
}

- (void)loadMoreData
{
    NSLog(@"loadMoreData");
    
    _page ++;
    _tableView.isReloadData = NO;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
}

- (CGFloat)heightForRowIndexPath:(NSIndexPath *)indexPath
{
    return _cellHight;
}

     
     
     
     
     
     



#pragma mark -  UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}







@end
