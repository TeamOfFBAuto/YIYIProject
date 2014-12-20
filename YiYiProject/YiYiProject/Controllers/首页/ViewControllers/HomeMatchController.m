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

@interface HomeMatchController ()<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD * hud;
    UIView * section_view;
}

///我的搭配师数据容器
@property(nonatomic,strong)NSMutableArray * myMatch_array;
///人气搭配师数据容器
@property(nonatomic,strong)NSMutableArray * hotMatch_array;

@property(nonatomic,strong)UITableView * myTableView;

@end

@implementation HomeMatchController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myMatch_array = [NSMutableArray array];
    _hotMatch_array = [NSMutableArray array];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    hud = [LTools MBProgressWithText:@"正在加载..." addToView:self.view];
    
    [self getDapeishiDataWithType:HomeMatchRequestTypeHot];
    [self getDapeishiDataWithType:HomeMatchRequestTypeMy];
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

#pragma mark - UITableView Section View
-(void)setSectionView
{
    section_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,430)];
    section_view.backgroundColor = [UIColor whiteColor];
    
    if (self.hotMatch_array.count)
    {
        HomeMatchView * my_view = [[HomeMatchView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,165)];
        [my_view setupWithArray:_hotMatch_array WithTitle:@"我的搭配师" WithShowApplyView:YES WithMyBlock:^(int index) {
            
        }];
        [section_view addSubview:my_view];
    }else
    {
        
    }
    
    if (self.hotMatch_array.count) {
        HomeMatchView * hot_view = [[HomeMatchView alloc] initWithFrame:CGRectMake(0,165,DEVICE_WIDTH,165)];
        [hot_view setupWithArray:_hotMatch_array WithTitle:@"人气搭配师" WithShowApplyView:NO WithMyBlock:^(int index) {
            
        }];
        [section_view addSubview:hot_view];
    }
    
    
    UIImageView * line_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12,326,DEVICE_WIDTH-24,9)];
    
    
    
    
    NSArray * title_array = [NSArray arrayWithObjects:@"职业",@"时尚",@"休闲",@"运动",nil];
    for (int i = 0;i < 4;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + (50+12)*i,345,50,25);
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
    
    _myTableView.tableHeaderView = section_view;
}

#pragma mark - 点击按钮
-(void)buttonTap:(UIButton *)button
{
    
}

#pragma mark - UITabelView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
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
