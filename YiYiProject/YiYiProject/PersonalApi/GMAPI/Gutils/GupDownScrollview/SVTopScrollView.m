//
//  SVTopScrollView.m
//  SlideView
//
//  Created by Chen Yaoqiang on 13-12-27.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import "SVTopScrollView.h"
#import "SVGloble.h"
#import "SVRootScrollView.h"


//按钮空隙
#define BUTTONGAP 5
//滑条宽度
#define CONTENTSIZEX 320
//按钮id
#define BUTTONID (sender.tag-10000)
//滑动id
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 10000)


@implementation SVTopScrollView

@synthesize nameArray;
@synthesize scrollViewSelectedChannelID;

+ (SVTopScrollView *)shareInstance {
    static SVTopScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 30)];
    });
    return _instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        userSelectedChannelID = 10000;
        scrollViewSelectedChannelID = 10000;
        
        self.buttonOriginXArray = [NSMutableArray array];
        self.buttonWithArray = [NSMutableArray array];
    }
    return self;
}

- (void)initWithNameButtons
{
    float xPos = 0;
    userSelectedChannelID=10000;
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 4;
        NSString *title = [self.nameArray objectAtIndex:i];
        [button setBackgroundImage:[UIImage imageNamed:@"gs_gray.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"gs_red.png"] forState:UIControlStateHighlighted];
        [button setTag:i+10000];
        if (i == 0) {
            button.selected = YES;
            NSLog(@"%p",button);
        }
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
//        int buttonWidth = [title sizeWithFont:button.titleLabel.font
//                            constrainedToSize:CGSizeMake(150, 30)
//                                lineBreakMode:NSLineBreakByClipping].width;
        int buttonWidth = 70;
        button.frame = CGRectMake(0+75*i, 0, buttonWidth+BUTTONGAP, 30);
        
        [_buttonOriginXArray addObject:@(xPos)];
        
        xPos += buttonWidth+BUTTONGAP;
        
        [_buttonWithArray addObject:@(button.frame.size.width)];
        
        [self addSubview:button];
    }
    
    self.contentSize = CGSizeMake(xPos, 30);
    
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP, 0, [[_buttonWithArray objectAtIndex:0] floatValue], 44)];
    shadowImageView.alpha = 0.3;
//    [shadowImageView setImage:[UIImage imageNamed:@"GscrollbtnBack.png"]];
    [self addSubview:shadowImageView];
}

//点击顶部条滚动标签
- (void)selectNameButton:(UIButton *)sender
{
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
//    if (sender.tag != userSelectedChannelID) {
//        //取之前的按钮
//        
//        
//        UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];
////        lastButton.selected = NO;
//        [lastButton setSelected:NO];
//        //赋值按钮ID
//        userSelectedChannelID = sender.tag;
//    }
//    
//    //按钮选中状态
//    if (!sender.selected) {
////        sender.selected = YES;
//        [sender setSelected:YES];
//        
//        [UIView animateWithDuration:0.25 animations:^{
//            
//            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:BUTTONID] floatValue], 44)];
//            
//        } completion:^(BOOL finished) {
//            if (finished) {
//                //设置新闻页出现
//                [[SVRootScrollView shareInstance] setContentOffset:CGPointMake(BUTTONID*DEVICE_WIDTH, 0) animated:YES];
//                //赋值滑动列表选择频道ID
//                scrollViewSelectedChannelID = sender.tag;
//            }
//        }];
//        
//    }else {//重复点击选中按钮
//        
//    }
    
    
    
    
    UIButton *preButton=(UIButton *)[self viewWithTag:userSelectedChannelID];
    
    NSLog(@"prebutton.tag===%ld",preButton.tag);
    NSLog(@"current===%ld",sender.tag);

    
    preButton.selected=NO;
    
    sender.selected=YES;
    
    userSelectedChannelID=sender.tag;

    
}

- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID] floatValue];
    
    if (sender.frame.origin.x - self.contentOffset.x > CONTENTSIZEX-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (sender.frame.origin.x - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}

//滚动内容页顶部滚动
- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIButton *lastButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    lastButton.selected = NO;
}

- (void)setButtonSelect
{
    //滑动选中按钮
    UIButton *button = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [shadowImageView setFrame:CGRectMake(button.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:button.tag-10000] floatValue], 44)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!button.selected) {
                button.selected = YES;
                userSelectedChannelID = button.tag;
            }
        }
    }];
    
}

-(void)setScrollViewContentOffset
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    
    if (originX - self.contentOffset.x > CONTENTSIZEX-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (originX - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}












@end
