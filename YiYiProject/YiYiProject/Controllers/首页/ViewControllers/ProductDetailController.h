//
//  ProductDetailController.h
//  YiYiProject
//
//  Created by lichaowei on 14/12/20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MyViewController.h"

@interface ProductDetailController : MyViewController

@property (nonatomic,retain)NSString *product_id;//产品id

@property (strong, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
- (IBAction)clickToDaPeiShi:(id)sender;
- (IBAction)clickToContact:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *xingHaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *biaoQianLabel;
@property (strong, nonatomic) IBOutlet UILabel *shangChangLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *bugButton;


- (IBAction)clickToBuy:(id)sender;


@end
