//
//  TopicDetailViewController.m
//  YiYiProject
//
//  Created by soulnear on 14-12-27.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "SNRefreshTableView.h"
#import "MatchTopicModel.h"

@interface TopicDetailViewController ()<UITableViewDataSource,SNRefreshDelegate>
{
    
}


@property(nonatomic,strong)SNRefreshTableView * myTableView;
///评论数据容器
@property(nonatomic,strong)NSMutableArray * array_comments;


@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array_comments = [NSMutableArray array];
    
    _myTableView = [[SNRefreshTableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-64) showLoadMore:YES];
    _myTableView.refreshDelegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    
    
    [self getTopicComments];
}


#pragma mark - 获取数据
///获取话题详情
-(void)getTopicDetailData
{
    NSString * fullUrl = [NSString stringWithFormat:GET_TOPIC_DETAIL_URL,_topic_model.topic_id];
    
    AFHTTPRequestOperation * request = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fullUrl]]];
    __weak typeof(self)bself = self;
    [request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * allDic = [operation.responseString objectFromJSONString];
        
        @try {
            NSString * errorcode = [allDic objectForKey:@"errorcode"];
            
            if ([errorcode intValue] == 0)
            {
                NSDictionary * topic_info = [allDic objectForKey:@"topic_info"];
                
            }else
            {
                [LTools showMBProgressWithText:[allDic objectForKey:@"msg"] addToView:self.view];
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

///获取话题评论
-(void)getTopicComments
{
    NSString * fullUrl = [NSString stringWithFormat:GET_TOPIC_COMMENTS_URL,_topic_model.topic_id,_myTableView.pageNum];
    NSLog(@"获取话题评论接口 -----   %@",fullUrl);
    AFHTTPRequestOperation * request = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fullUrl]]];
    
    [request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        @try {
            
            NSDictionary * allDic = [operation.responseString objectFromJSONString];
            
            
            
            
            
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [request start];
}



#pragma mark - UITableView Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array_comments.count;
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
    return 0;
}
- (UIView *)viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
