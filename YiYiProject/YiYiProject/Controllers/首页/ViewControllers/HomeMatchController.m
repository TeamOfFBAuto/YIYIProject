//
//  HomeMatchController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/12.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "HomeMatchController.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"
#import "HomeMatchModel.h"
#import "HomeMatchView.h"
#import "MatchTopicModel.h"
#import "MatchTopicCell.h"
#import "SNRefreshTableView.h"
#import "LWaterflowView.h"

@interface HomeMatchController ()<SNRefreshDelegate,UITableViewDataSource,TMQuiltViewDataSource,WaterFlowDelegate>
{
    MBProgressHUD * hud;
    UIView * section_view;
    NSInteger current_page;
    ///瀑布流
    LWaterflowView * waterFlow;
}

///我的搭配师数据容器
@property(nonatomic,strong)NSMutableArray * myMatch_array;
///人气搭配师数据容器
@property(nonatomic,strong)NSMutableArray * hotMatch_array;

@property(nonatomic,strong)SNRefreshTableView * myTableView;

///话题数据
@property(nonatomic,strong)NSMutableArray * array_topic;

@end

@implementation HomeMatchController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myMatch_array = [NSMutableArray array];
    _hotMatch_array = [NSMutableArray array];
    _array_topic = [NSMutableArray array];
    
    _myTableView = [[SNRefreshTableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-64-49) showLoadMore:YES];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.refreshDelegate = self;
    [self.view addSubview:_myTableView];
    
    hud = [LTools MBProgressWithText:@"正在加载..." addToView:self.view];
    
    [self getDapeishiDataWithType:HomeMatchRequestTypeHot];
    [self getDapeishiDataWithType:HomeMatchRequestTypeMy];
    
    ///获取搭配师话题数据
    [self getTopicData];
}


#pragma mark - 获取数据
///获取搭配师数据
-(void)getDapeishiDataWithType:(HomeMatchRequestType)atype
{
    NSString * fullUrl;
    if (atype == HomeMatchRequestTypeHot)
    {
        fullUrl = [NSString stringWithFormat:GET_DAPEISHI_URL,@"popu",@"",@"0",1,100];
    }else
    {
        fullUrl = [NSString stringWithFormat:GET_DAPEISHI_URL,@"my",[GMAPI getAuthkey],@"0",1,100];
    }
    
    NSLog(@"fullUrl ----   %@",fullUrl);
    AFHTTPRequestOperation * request = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fullUrl]]];
    __weak typeof(self)bself = self;
    [request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * allDic = [operation.responseString objectFromJSONString];
        NSLog(@"allDic -----  %@",allDic);
        @try {
            
            NSString * errorcode = [allDic objectForKey:@"errorcode"];
            if ([errorcode intValue] == 0)
            {
                NSArray * array = [allDic objectForKey:@"division_t"];
                for (NSDictionary * dic in array) {
                    HomeMatchModel * model = [[HomeMatchModel alloc] initWithDictionary:dic];
                    if (atype == HomeMatchRequestTypeHot) {
                        [bself.hotMatch_array addObject:model];
                    }else
                    {
                        [bself.myMatch_array addObject:model];
                    }
                }
                
                [bself setSectionView];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [request start];
}
///获取话题数据
-(void)getTopicData
{
    NSString * fullUrl = [NSString stringWithFormat:GET_TOPIC_DATA_URL,@"",_myTableView.pageNum,10];
    
    AFHTTPRequestOperation * request = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fullUrl]]];
    __weak typeof(self) bself = self;
    [request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * allDic = [operation.responseString objectFromJSONString];
        NSString * errorcode = [allDic objectForKey:@"errorcode"];
        if ([errorcode intValue] == 0)
        {
            if (bself.myTableView.pageNum == 1)
            {
                [bself.array_topic removeAllObjects];
            }
            
            NSArray * array = [allDic objectForKey:@"topics"];
            for (NSDictionary * dic in array) {
                MatchTopicModel * model = [[MatchTopicModel alloc] initWithDictionary:dic];
                [bself.array_topic addObject:model];
            }
            
            [bself.myTableView finishReloadigData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [request start];
}

#pragma mark - UITableView Section View
-(void)setSectionView
{
    section_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,430)];
    section_view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = 0;
    
    if (self.myMatch_array.count)
    {
        HomeMatchView * my_view = [[HomeMatchView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,165)];
        [my_view setupWithArray:_myMatch_array WithTitle:@"我的搭配师" WithShowApplyView:YES WithMyBlock:^(int index) {
            
        }];
        [section_view addSubview:my_view];
        
        height += 165;
    }else
    {
        
    }
    
    if (self.hotMatch_array.count) {
        HomeMatchView * hot_view = [[HomeMatchView alloc] initWithFrame:CGRectMake(0,height,DEVICE_WIDTH,165)];
        [hot_view setupWithArray:_hotMatch_array WithTitle:@"人气搭配师" WithShowApplyView:NO WithMyBlock:^(int index) {
            
        }];
        [section_view addSubview:hot_view];
        height += 165;
    }else
    {
        
    }
    
    height+=20;
    UIImageView * line_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12,height,DEVICE_WIDTH-24,9)];
    line_imageView.image = [UIImage imageNamed:@"match_line_image"];
    [section_view addSubview:line_imageView];
    
    
    height += 20+9;
    NSArray * title_array = [NSArray arrayWithObjects:@"职业",@"时尚",@"休闲",@"运动",nil];
    for (int i = 0;i < 4;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + (50+12)*i,height,50,25);
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:[title_array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = RGBCOLOR(172,172,172);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        [section_view addSubview:button];
    }
    
    height = height + 25 + 20;
    
    for (int i = 0;i < 2;i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(12+(DEVICE_WIDTH-24)/2*i,height,(DEVICE_WIDTH-24)/2,34);
        button.tag = 1000 + i;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 8;
        button.layer.borderColor = RGBCOLOR(235,77,104).CGColor;
        button.layer.borderWidth = 1;
        [button addTarget:self action:@selector(clickForChange:) forControlEvents:UIControlEventTouchUpInside];
        [section_view addSubview:button];
        
        if (i == 0)
        {
            [button setTitle:@"话题" forState:UIControlStateNormal];
            [button setTitleColor:RGBCOLOR(235,77,104) forState:UIControlStateSelected];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.selected = YES;
        }else
        {
            [button setTitle:@"搭配" forState:UIControlStateNormal];
            [button setTitleColor:RGBCOLOR(235,77,104) forState:UIControlStateSelected];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.selected = NO;
        }
    }
    
    
    section_view.height = height + 34 + 20;
    _myTableView.tableHeaderView = section_view;
}

#pragma mark - 点击按钮
-(void)buttonTap:(UIButton *)button
{
    
}

#pragma mark - 点击按钮切换搭配、话题
-(void)clickForChange:(UIButton *)button
{
    if (button.tag == current_page) {
        return;
    }
    
    for (int i = 0;i<2;i++)
    {
        UIButton * aButton = (UIButton *)[section_view viewWithTag:i+1000];
        
        if (aButton.tag == button.tag)
        {
            button.selected = YES;
        }else
        {
            aButton.selected = NO;
        }
    }
    
    current_page = button.tag;
}

#pragma mark - UITabelView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selected_type == MatchSelectedTypeTopic) {
        return _array_topic.count;
    }else
    {
        return 1;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selected_type == MatchSelectedTypeTopic)
    {
        static NSString * identifier = @"identifier";
        MatchTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MatchTopicCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        [cell setInfoWith:[_array_topic objectAtIndex:indexPath.row]];
        
        return cell;
    }else
    {
        NSString * identifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [waterFlow removeFromSuperview];
        
        waterFlow = [[LWaterflowView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, ALL_FRAME_HEIGHT - 49 - 44) waterDelegate:self waterDataSource:self];
        waterFlow.backgroundColor = RGBCOLOR(240, 230, 235);
        [cell.contentView addSubview:waterFlow];
        
        [waterFlow showRefreshHeader:YES];

        return cell;
    }
    
    
}


#pragma mark - Refresh Delegate
- (void)loadNewData
{
    
}
- (void)loadMoreData
{
    
}
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)heightForRowIndexPath:(NSIndexPath *)indexPath
{
    if (selected_type == MatchSelectedTypeTopic) {
        return 89;
    }else
    {
        return DEVICE_HEIGHT-64-49;
    }
}


#pragma mark - WaterFlowDelegate

- (void)waterLoadNewData
{
    
}
- (void)waterLoadMoreData
{
    
}

- (void)waterDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)waterHeightForCellIndexPath:(NSIndexPath *)indexPath
{
    CGFloat aHeight = 0.f;
    ProductModel *aMode = waterFlow.dataArray[indexPath.row];
    if (aMode.imagelist.count >= 1) {
        
        NSDictionary *imageDic = aMode.imagelist[0];
        NSDictionary *middleImage = imageDic[@"504Middle"];
        //        CGFloat aWidth = [middleImage[@"width"]floatValue];
        aHeight = [middleImage[@"height"]floatValue];
    }
    
    return aHeight / 2.f + 50;
}
- (CGFloat)waterViewNumberOfColumns
{
    
    return 2;
}

#pragma mark - TMQuiltViewDataSource

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [waterFlow.dataArray count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"];
    }
    
    ProductModel *aMode = waterFlow.dataArray[indexPath.row];
    [cell setCellWithModel:aMode];
    
    
    return cell;
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

@end
