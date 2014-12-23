//
//  ApplyForViewController.m
//  YiYiProject
//
//  Created by soulnear on 14-12-21.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ApplyForViewController.h"

@interface ApplyForViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString * phone_num_string;///手机号
    NSString * verification_string;//验证码
    NSString * qq_string;//qq号
    NSString * wechat_string;//微信号
    NSMutableArray * string_array;
}



@property(nonatomic,strong)UITableView * myTableView;


@end

@implementation ApplyForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    string_array = [NSMutableArray arrayWithObjects:phone_num_string,verification_string,qq_string,wechat_string,nil];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorColor = RGBCOLOR(234,234,234);
    [self.view addSubview:_myTableView];
}


#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)///灰色部分
    {
        return 30;
    }else if (indexPath.row == 5)///提交身份证，上传
    {
        return 370;
    }else
    {
        return 50;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (indexPath.row == 0)///灰色部分
    {
        cell.backgroundColor = RGBCOLOR(242,242,242);
        cell.contentView.backgroundColor = RGBCOLOR(242,242,242);
    }else if (indexPath.row == 5)///提交身份证，上传
    {
        
    }else
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23,15,20,20)];
        imageView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:imageView];
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(54,0,DEVICE_WIDTH-160,50)];
        textField.delegate = self;
        textField.tag = 100+indexPath.row;
        [cell.contentView addSubview:textField];
        
        
        UIButton * timer_button = [UIButton buttonWithType:UIButtonTypeCustom];
        timer_button.frame = CGRectMake(DEVICE_WIDTH,10,80,30);
        timer_button.titleLabel.font = [UIFont systemFontOfSize:16];
        [timer_button setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
    return cell;
}


#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [string_array replaceObjectAtIndex:textField.tag-100 withObject:textField.text];
    
    return YES;
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
