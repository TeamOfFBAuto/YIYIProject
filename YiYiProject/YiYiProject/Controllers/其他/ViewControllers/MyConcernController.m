//
//  MyConcernController.m
//  YiYiProject
//
//  Created by lichaowei on 15/1/2.
//  Copyright (c) 2015年 lcw. All rights reserved.
//

#import "MyConcernController.h"
#import "RefreshTableView.h"

#import "ShopViewCell.h"

@interface MyConcernController ()<RefreshDelegate,UITableViewDataSource>
{
    UIButton *heartButton;
    UIView *indicator;
    UIScrollView *bgScroll;
    RefreshTableView *shopTable;//店铺table
    RefreshTableView *brandTable;//品牌table
    
    BOOL isEditing;//是否处于编辑状态
    
}

@end

@implementation MyConcernController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBCOLOR(200, 200, 200);
    
    self.myTitleLabel.text = @"我的关注";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    [self createNavigationbarTools];
    [self createSegButton];
    [self createViews];
    
    [self getBrand];
    [self getShop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
/**
 *  获取品牌
 */
- (void)getBrand
{
    NSString *url = [NSString stringWithFormat:MY_CONCERN_BRAND,[GMAPI getAuthkey],brandTable.pageNum];
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"-->%@",result);
        
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        [LTools showMBProgressWithText:failDic[@"errinfo"] addToView:self.view];
    }];
}
/**
 *  获取商家
 */
- (void)getShop
{
    NSString *url = [NSString stringWithFormat:MY_CONCERN_SHOP,[GMAPI getAuthkey],brandTable.pageNum,L_PAGE_SIZE];
    
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSLog(@"-->%@",result);
        
        NSArray *list = result[@"list"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (NSDictionary *aDic in list) {
            
            MailModel *aModel = [[MailModel alloc]initWithDictionary:aDic];
            [arr addObject:aModel];
        }
        
        [shopTable reloadData:arr total:100];
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        [LTools showMBProgressWithText:failDic[@"errinfo"] addToView:self.view];
    }];
}

#pragma mark - 创建视图

- (void)createNavigationbarTools
{
    UIButton *rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    rightView.backgroundColor=[UIColor clearColor];
    
    heartButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [heartButton addTarget:self action:@selector(clickToEdit:) forControlEvents:UIControlEventTouchUpInside];
    [heartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [heartButton setTitle:@"编辑" forState:UIControlStateNormal];
    [heartButton  setTitle:@"完成" forState:UIControlStateSelected];
    [heartButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [rightView addSubview:heartButton];
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = comment_item;
}

- (void)createSegButton
{
    UIView *segView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 58)];
    segView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.view addSubview:segView];
    
    NSArray *titles = @[@"商家",@"品牌"];
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(DEVICE_WIDTH/2.f * i, 0, DEVICE_WIDTH/2.f, 45);
        [btn setBackgroundColor:[UIColor whiteColor]];
        [segView addSubview:btn];
        [btn addTarget:self action:@selector(clickToSwap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    indicator = [[UIView alloc]initWithFrame:CGRectMake(0, 43, DEVICE_WIDTH/2.f, 2)];
    indicator.backgroundColor = [UIColor colorWithHexString:@"ea5670"];
    [segView addSubview:indicator];
}

- (void)createViews
{
    bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 58, DEVICE_WIDTH, self.view.height - 58)];
    [self.view addSubview:bgScroll];
    bgScroll.contentSize = CGSizeMake(DEVICE_WIDTH * 2, bgScroll.height);
    
    //店铺
    shopTable = [[RefreshTableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, bgScroll.height)];
    shopTable.refreshDelegate = self;
    shopTable.dataSource = self;
    [bgScroll addSubview:shopTable];
    shopTable.backgroundColor = [UIColor clearColor];
    shopTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //品牌
    brandTable = [[RefreshTableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, bgScroll.height)];
    brandTable.refreshDelegate = self;
    brandTable.dataSource = self;
    [bgScroll addSubview:brandTable];
    brandTable.backgroundColor = [UIColor greenColor];
    brandTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 事件处理

- (UIButton *)buttonForTag:(int)tag
{
    return (UIButton *)[self.view viewWithTag:tag];
}

- (void)clickToSwap:(UIButton *)sender
{
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:101];
    if (sender.tag == 100) {
        btn1.selected = YES;
        btn2.selected = NO;
        indicator.left = 0;
        bgScroll.contentOffset = CGPointMake(0, 0);
    }else
    {
        btn1.selected = NO;
        btn2.selected = YES;
        indicator.left = DEVICE_WIDTH/2.f;
        bgScroll.contentOffset = CGPointMake(DEVICE_WIDTH, 0);
    }
}

- (void)clickToEdit:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    isEditing = sender.selected;
    
    [shopTable reloadData];
    [brandTable reloadData];
}

#pragma mark - 代理

#pragma - mark RefreshDelegate

- (void)loadNewData
{
    if ([self buttonForTag:100]) {
        
        [self getShop];
    }
    
    if ([self buttonForTag:101]) {
        
        [self getBrand];
    }
}
- (void)loadMoreData
{
    [self loadNewData];
}

//新加
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    
}

- (CGFloat)heightForRowIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    if ([self buttonForTag:100]) {
        
        return 60;
    }
    return 60;
}

#pragma - mark UItableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"ShopViewCell";
    
    if (tableView == shopTable) {
        
        ShopViewCell *cell = (ShopViewCell *)[LTools cellForIdentify:identify cellName:identify forTable:tableView];
        
        MailModel *aModel = shopTable.dataArray[indexPath.row];
        
        [cell setCellWithModel:aModel];
        
        
        cell.cancelButton.hidden = !isEditing;
        
        return cell;
        
    }
    
    static NSString *identify2 = @"brandCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify2];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify2];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self buttonForTag:100]) {
        
        return shopTable.dataArray.count;
    }else
    {
        return brandTable.dataArray.count;
    }
}

@end
