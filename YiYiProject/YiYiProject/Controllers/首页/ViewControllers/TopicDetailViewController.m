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
#import "TopicCommentsModel.h"
#import "TopicCommentsCell.h"

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
    
    self.myTitle = @"话题详情";
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    _array_comments = [NSMutableArray array];
    
    _myTableView = [[SNRefreshTableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-64) showLoadMore:YES];
    _myTableView.refreshDelegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorInset = UIEdgeInsetsMake(0,60,0,0);
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
    __weak typeof(self) bself = self;
    [request setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        @try {
            
            NSDictionary * allDic = [operation.responseString objectFromJSONString];
            NSLog(@"allDic --- - -- - --   %@",allDic);
            
            if (bself.myTableView.pageNum == 1)
            {
                [bself.array_comments removeAllObjects];
                bself.myTableView.hiddenLoadMore = NO;
            }
            
            NSString * errorcode = [allDic objectForKey:@"errorcode"];
            if ([errorcode intValue] == 0)
            {
                NSArray * array = [allDic objectForKey:@"list"];
                
                for (NSDictionary * dic in array) {
                    TopicCommentsModel * model = [[TopicCommentsModel alloc] initWithDictionary:dic];
                    [bself.array_comments addObject:model];
                }
                
                if (bself.myTableView.pageNum == 1 && array.count < 20) {
                    bself.myTableView.hiddenLoadMore = YES;
                }
                
                [bself.myTableView finishReloadigData];
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



#pragma mark - UITableView Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array_comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    TopicCommentsCell * cell = (TopicCommentsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TopicCommentsCell" owner:self options:nil] objectAtIndex:0];
    }
    
    TopicCommentsModel * model = [_array_comments objectAtIndex:indexPath.row];
    
    [cell setInfoWithCommentsModel:model];
    
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
    
    TopicCommentsModel * model = [_array_comments objectAtIndex:indexPath.row];
    NSString * content_string = model.repost_content;
    
    CGFloat string_height = [LTools heightForText:content_string width:DEVICE_WIDTH-60-12 font:14];
        ///数字一次代表距离顶部距离、头像高度、内容离头像距离、底部距离
    return string_height + 12 + 36 + 10 + 12;
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
