//
//  TTaiViewController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "TTaiViewController.h"
#import "LoginViewController.h"
#import "PublishHuatiController.h"

#import "TTPublishViewController.h"

#import "LWaterflowView.h"
#import "TPlatModel.h"
#import "TPlatCell.h"

@interface TTaiViewController ()<TMQuiltViewDataSource,WaterFlowDelegate>
{
    LWaterflowView *waterFlow;
}

@end

@implementation TTaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitleLabel.text = @"T台";
    
    [self createNavigationbarTools];
    
    
    waterFlow = [[LWaterflowView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, ALL_FRAME_HEIGHT - 49 - 44) waterDelegate:self waterDataSource:self];
    waterFlow.backgroundColor = RGBCOLOR(240, 230, 235);
    [self.view addSubview:waterFlow];
    
    [waterFlow showRefreshHeader:YES];
    
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 100, 50, 30);
//    [btn setTitle:@"登录" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(clickToPush:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn2.frame = CGRectMake(100, 200, 100, 30);
//    [btn2 setTitle:@"发布话题" forState:UIControlStateNormal];
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(clickToPublish:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
}

#pragma mark 事件处理

- (void)clickToPhoto:(UIButton *)sender
{
    TTPublishViewController *publishT = [[TTPublishViewController alloc]init];
    publishT.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publishT animated:YES];
}

- (void)clickToPush:(UIButton *)sender
{
    LoginViewController *login = [[LoginViewController alloc]init];
    
    UINavigationController *unvc = [[UINavigationController alloc]initWithRootViewController:login];
    
    [self presentViewController:unvc animated:YES completion:nil];
}

- (void)clickToPublish:(UIButton *)sender
{
    PublishHuatiController *publish = [[PublishHuatiController alloc]init];
    publish.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNavigationbarTools
{
    
    UIButton *rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    rightView.backgroundColor=[UIColor clearColor];
    
    UIButton *heartButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [heartButton addTarget:self action:@selector(clickToPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [heartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [heartButton setImage:[UIImage imageNamed:@"rizhi_xiangji"] forState:UIControlStateNormal];
    [heartButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    [rightView addSubview:heartButton];
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = comment_item;
}

#pragma mark 网络请求

- (void)getTTaiData
{
    NSString *url = [NSString stringWithFormat:TTAI_LIST,waterFlow.pageNum,L_PAGE_SIZE,[GMAPI getAuthkey]];
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSMutableArray *arr;
        int total;
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            NSArray *list = result[@"list"];
            
            total = [result[@"total"]intValue];
            arr = [NSMutableArray arrayWithCapacity:list.count];
            if ([list isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *aDic in list) {
                    
                    TPlatModel *aModel = [[TPlatModel alloc]initWithDictionary:aDic];
                    
                    [arr addObject:aModel];
                }
                
            }
            
        }
        
        if (total % L_PAGE_SIZE == 0) {
            total = total / L_PAGE_SIZE;
        }else
        {
            total = total / L_PAGE_SIZE + 1;
        }
        
        [waterFlow reloadData:arr total:total];
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        NSLog(@"failBlock == %@",failDic[RESULT_INFO]);
        [waterFlow loadFail];
        
    }];
}

#pragma mark - WaterFlowDelegate

- (void)waterLoadNewData
{
    [self getTTaiData];
}
- (void)waterLoadMoreData
{
    [self getTTaiData];
}

- (void)waterDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)height:(CGFloat)aHeight aWidth:(CGFloat)aWidth
{
    CGFloat realWidth = (DEVICE_WIDTH - 30 / 3);
    
    return realWidth * aHeight / aWidth;
}

- (CGFloat)waterHeightForCellIndexPath:(NSIndexPath *)indexPath
{
    CGFloat aHeight = 0.f;
    TPlatModel *aModel = waterFlow.dataArray[indexPath.row];
    aHeight = [aModel.image[@"heigth"]floatValue];
    CGFloat aWidth = [aModel.image[@"width"]floatValue];

    return [self height:aHeight / 2.f aWidth:aWidth] + 55 + 36;
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
    TPlatCell *cell = (TPlatCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"TPlatCell"];
    if (!cell) {
        cell = [[TPlatCell alloc] initWithReuseIdentifier:@"TPlatCell"];
    }
    
    cell.layer.cornerRadius = 3.f;
    
    TPlatModel *aMode = waterFlow.dataArray[indexPath.row];
    [cell setCellWithModel:aMode];
    
    return cell;
}


@end
