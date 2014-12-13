//
//  MineViewController.m
//  YiYiProject
//
//  Created by lichaowei on 14/12/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "GTableViewCell.h"
#import "MLImageCrop.h"
#import "GcustomActionSheet.h"
#import "AFNetworking.h"
#import "GeditUserInfoViewController.h"

typedef enum{
    USERFACE = 0,//头像
    USERBANNER,//banner
    USERIMAGENULL,
}CHANGEIMAGETYPE;

#define CROPIMAGERATIO_USERBANNER 3.0/2//banner 图片裁剪框宽高比
#define CROPIMAGERATIO_USERFACE 1.0//头像 图片裁剪框宽高比例

#define UPIMAGECGSIZE_USERBANNER CGSizeMake(320,240)//需要上传的banner的分辨率
#define UPIMAGECGSIZE_USERFACE CGSizeMake(200,200)//需要上传的头像的分辨率

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,GcustomActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,MLImageCropDelegate>
{
    UITableView *_tableView;//主tableview
    CHANGEIMAGETYPE _changeImageType;
    NSArray *_tabelViewCellTitleArray;
}
@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitleLabel.text = @"我的";
    
    //判断是否登录
    if ([LTools cacheBoolForKey:USER_LONGIN] == NO) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        [self presentViewController:login animated:YES completion:nil];
        
    }
    
    
    //初始化相关
    _changeImageType = USERIMAGENULL;
    
    _tabelViewCellTitleArray = @[@"我的主页",@"我的收藏",@"我的搭配",@"我的衣橱",@"我的体型",@"穿衣日记",@"我的关注",@"我是店主,申请衣+衣小店",@"邀请好友"];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-49-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self creatTableViewHeaderView];
    [self.view addSubview:_tableView];
    
    NSLog(@"%@",NSStringFromCGRect(_tableView.frame));
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///创建用户头像banner的view
-(UIView *)creatTableViewHeaderView{
    //底层view
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 150.00)];
    backView.backgroundColor = [UIColor whiteColor];
    
    //banner
    self.userBannerImv = [[UIImageView alloc]initWithFrame:backView.frame];
    self.userBannerImv.backgroundColor = RGBCOLOR_ONE;
    //模糊效果
    self.userBannerImv.layer.masksToBounds = NO;
    self.userBannerImv.layer.shadowColor = [UIColor blackColor].CGColor;
    self.userBannerImv.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.userBannerImv.layer.shadowOpacity = 0.5f;//阴影透明度，默认0
    self.userBannerImv.layer.shadowRadius = 4;//阴影半径，默认3
    
    //头像
    self.userFaceImv = [[UIImageView alloc]initWithFrame:CGRectMake(40*GscreenRatio_320, 70.00*GscreenRatio_320, 60, 60)];
    self.userFaceImv.backgroundColor = RGBCOLOR_ONE;
    self.userFaceImv.layer.cornerRadius = 30*GscreenRatio_320;
    self.userFaceImv.layer.masksToBounds = YES;
    
    //昵称
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userFaceImv.frame)+5, self.userFaceImv.frame.origin.y+10, 120*GscreenRatio_320, 17)];
    self.userNameLabel.text = @"昵称";
    self.userNameLabel.backgroundColor = [UIColor lightGrayColor];
    
    //积分
    self.userScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.userNameLabel.frame.origin.x, CGRectGetMaxY(self.userNameLabel.frame)+10, self.userNameLabel.frame.size.width, self.userNameLabel.frame.size.height)];
    self.userScoreLabel.text = @"积分：2000";
    self.userScoreLabel.backgroundColor = [UIColor orangeColor];
    
    //编辑按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setFrame:CGRectMake(CGRectGetMaxX(self.userNameLabel.frame)+25, self.userFaceImv.frame.origin.y+5, 50, 30)];
    editBtn.backgroundColor = [UIColor purpleColor];
    editBtn.layer.cornerRadius = 8;
    [editBtn addTarget:self action:@selector(goToEdit) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    
    
    //手势
    UITapGestureRecognizer *ddd = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userBannerClicked)];
    self.userBannerImv.userInteractionEnabled = YES;
    [self.userBannerImv addGestureRecognizer:ddd];
    UITapGestureRecognizer *eee = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userFaceClicked)];
    self.userFaceImv.userInteractionEnabled = YES;
    [self.userFaceImv addGestureRecognizer:eee];
    
    
    //添加视图
    [backView addSubview:self.userBannerImv];
    [backView addSubview:self.userFaceImv];
    [backView addSubview:self.userNameLabel];
    [backView addSubview:self.userScoreLabel];
    [backView addSubview:editBtn];
    
    return backView;
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    GTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[GTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [cell creatCustomViewWithGcellType:GPERSON indexPath:indexPath customObject:_tabelViewCellTitleArray];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"在这里进行跳转");
}



-(void)goToEdit{
    [self.navigationController pushViewController:[[GeditUserInfoViewController alloc]init] animated:YES];
}


//修改banner&&头像
-(void)userBannerClicked{
    NSLog(@"点击用户banner");
    _changeImageType = USERBANNER;
    GcustomActionSheet *aaa = [[GcustomActionSheet alloc]initWithTitle:nil
                                                          buttonTitles:@[@"更换相册封面"]
                                                     buttonTitlesColor:[UIColor blackColor]
                                                           buttonColor:[UIColor whiteColor]
                                                           CancelTitle:@"取消"
                                                      cancelTitelColor:[UIColor whiteColor]
                                                           CancelColor:RGBCOLOR(253, 144, 39)
                                                       actionBackColor:RGBCOLOR(236, 236, 236)];
    aaa.tag = 90;
    aaa.delegate = self;
    [aaa showInView:self.view WithAnimation:YES];
    
    
}
-(void)userFaceClicked{
    NSLog(@"点击头像");
    _changeImageType = USERFACE;
    GcustomActionSheet *aaa = [[GcustomActionSheet alloc]initWithTitle:nil
                                                          buttonTitles:@[@"更换头像"]
                                                     buttonTitlesColor:[UIColor blackColor]
                                                           buttonColor:[UIColor whiteColor]
                                                           CancelTitle:@"取消"
                                                      cancelTitelColor:[UIColor whiteColor]
                                                           CancelColor:RGBCOLOR(253, 144, 39)
                                                       actionBackColor:RGBCOLOR(236, 236, 236)];
    aaa.tag = 91;
    aaa.delegate = self;
    [aaa showInView:self.view WithAnimation:YES];
}




#pragma mark - GcustomActionSheetDelegate

///隐藏或显示tabbar
-(void)gHideTabBar:(BOOL)hidden{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if (hidden) {
        NSLog(@"加等 %f",self.tabBarController.tabBar.top);
        self.tabBarController.tabBar.top+=49;
    }else{
        NSLog(@"减等 %f",self.tabBarController.tabBar.top);
        self.tabBarController.tabBar.top-=49;
    }
    [UIView commitAnimations];
    
    
//    self.tabBarController.tabBar.hidden = hidden;//无动画
}

-(void)gActionSheet:(GcustomActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    
    //图片选择器
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if (actionSheet.tag == 90) {//banner
        if (buttonIndex == 1) {//修改
            [self presentViewController:picker animated:YES completion:^{
                
            }];
        }
    }else if (actionSheet.tag == 91){//头像
        if (buttonIndex == 1) {//修改
            [self presentViewController:picker animated:YES completion:^{
                
            }];
        }
    }
    
}

#pragma mark- 缩放图片
//按比例缩放
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//按像素缩放
-(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
#pragma mark - UIImagePickerControllerDelegate 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%s",__FUNCTION__);
    [UIApplication sharedApplication].statusBarHidden = NO;
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        //压缩图片 不展示原图
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //按比例缩放
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.5];
        
        
        //将图片传递给截取界面进行截取并设置回调方法（协议）
        MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
        imageCrop.delegate = self;
        
        //按像素缩放
        imageCrop.ratioOfWidthAndHeight = 400.0f/400.0f;//设置缩放比例
        
        imageCrop.image = scaleImage;
        //[imageCrop showWithAnimation:NO];
        picker.navigationBar.hidden = YES;
        [picker pushViewController:imageCrop animated:YES];
        
    }
}


#pragma mark - MLImageCropDelegate
- (void)cropImage:(UIImage*)cropImage forOriginalImage:(UIImage*)originalImage
{
    
    if (_changeImageType == USERBANNER) {
        UIImage *doneImage = [self scaleToSize:cropImage size:UPIMAGECGSIZE_USERBANNER];//按像素缩放
        self.userBanner = doneImage;
        self.userUploadImagedata = UIImagePNGRepresentation(self.userBanner);
        [GMAPI setUserBannerImageWithData:self.userUploadImagedata];//存储到本地
        [self.userBannerImv setImage:[GMAPI getUserBannerImage]];//及时更新banner
        [GMAPI setUpUserBannerYes];//设置是否上传标志位
    }else if (_changeImageType == USERFACE){
        UIImage *doneImage = [self scaleToSize:cropImage size:UPIMAGECGSIZE_USERFACE];//按像素缩放
        self.userFace = doneImage;
        self.userUploadImagedata = UIImagePNGRepresentation(self.userFace);
        [GMAPI setUserFaceImageWithData:self.userUploadImagedata];//存储到本地
        [self.userFaceImv setImage:[GMAPI getUserFaceImage]];//及时更新face
        [GMAPI setUpUserFaceYes];//设置是否上传标志位
    }
    
    
    //ASI上传
    [self upLoadImage];

    [_tableView reloadData];
    
}

//上传
-(void)upLoadImage{
    
    NSString *uploadImageUrlStr = @"";
    
    if (_changeImageType == USERBANNER) {//banner
        uploadImageUrlStr = @"123";
    }else if (_changeImageType == USERFACE){//头像
        uploadImageUrlStr = @"456";
    }
    
    //设置接收响应类型为标准HTTP类型(默认为响应类型为JSON)
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation  * o2= [manager
                                   POST:@"https://upload.api.weibo.com/2/statuses/upload.json"
                                   parameters:@{@"uid":@"3720138052",
                                                @"access_token":@"2.00eq_lDEJAyrCD6bfcb76e8d0UMOMK",
                                                @"status":@"测试"}
                                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                   {
                                       //开始拼接表单
                                       //获取图片的二进制形式
                                       NSData * data= self.userUploadImagedata;
                                       //将得到的二进制图片拼接到表单中
                                       /**
                                        *  data,指定上传的二进制流
                                        *  name,服务器端所需参数名
                                        *  fileName,指定文件名
                                        *  mimeType,指定文件格式
                                        */
                                       [formData appendPartWithFileData:data name:@"pic" fileName:@"icon.png" mimeType:@"image/png"];
                                       //多用途互联网邮件扩展（MIME，Multipurpose Internet Mail Extensions）
                                   }
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
                                   {
                                       NSLog(@"%@",responseObject);
                                       if (_changeImageType == USERBANNER) {
                                           [GMAPI setUpUserBannerNo];
                                       }else if (_changeImageType == USERFACE){
                                           [GMAPI setUpUserFaceNo];
                                       }
                                       
                                   }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       if (_changeImageType == USERBANNER) {
                                           [GMAPI setUpUserBannerYes];
                                       }else if (_changeImageType == USERFACE){
                                           [GMAPI setUpUserFaceYes];
                                       }
                                   }];
    //设置上传操作的进度
    [o2 setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    }];
    
    
}




@end
