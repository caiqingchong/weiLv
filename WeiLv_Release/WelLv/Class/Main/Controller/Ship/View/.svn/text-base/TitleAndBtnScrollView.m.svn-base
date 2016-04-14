//
//  TitleAndBtnScrollView.m
//  WelLv
//
//  Created by 吴伟华 on 16/3/8.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TitleAndBtnScrollView.h"
#import "ZFJImageAndTitleButton.h"
#define M_BUT_Width 70
#define M_BUT_Heigth 58

#define M_ShipLine_But_Width 60

@interface TitleAndBtnScrollView ()<UIScrollViewDelegate>
@property(nonatomic,strong)ChooseBtnClick chooseBtnClick;
@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *currentView;
@property (nonatomic,strong) NSArray *btnImageArray;
@end

@implementation TitleAndBtnScrollView

-(instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName andtitleImage:(NSString *)titleImage andBtnNameArray:(NSArray *)btnNameArray btnImgArray:(NSArray *)btnImgArray andChooseBlock:(ChooseBtnClick)chooseBtnClick
{
    if (self = [super initWithFrame:frame]) {
        self.chooseBtnClick = chooseBtnClick;
        self.backgroundColor = [UIColor whiteColor];
        //图片
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
        self.titleImageView.image = [UIImage imageNamed:titleImage];
        [self addSubview:self.titleImageView];
        
        self.btnImageArray = btnImgArray;
        
        //文字
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, frame.size.width - 70, 25)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.text = titleName;
        [self addSubview:self.titleLabel];
        
        
        
        UIScrollView *btnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth, frame.size.height - 50)];
        [self addSubview:btnScrollView];
        
        int colWidth = (windowContentWidth - M_ShipLine_But_Width * 4 - 40) / 3;
        for (int i = 0; i < btnNameArray.count; i++) {
            NSString * imageStr = [btnImgArray objectAtIndex:i];
            NSString * title = [btnNameArray objectAtIndex:i];
            ZFJImageAndTitleButton * but = [[ZFJImageAndTitleButton alloc] initWithFrame:CGRectMake(M_ShipLine_But_Width *i  + colWidth *i  + 20, 0, M_ShipLine_But_Width, M_ShipLine_But_Width + 30) shipViewCornerRadius:0 masksToBounds:NO];
            
                [but.iconImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"默认图1"]];
                but.title.text = title;
                but.tag = 100 + i ;
                [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
                [btnScrollView addSubview:but];

        }
        btnScrollView.delegate = self;
        btnScrollView.pagingEnabled = YES;
        btnScrollView.showsHorizontalScrollIndicator = NO;
         NSInteger pageCount = btnNameArray.count / 4 < btnNameArray.count / 4.0 ?btnNameArray.count / 4 + 1 :btnNameArray.count / 4;
        btnScrollView.contentSize = CGSizeMake(pageCount*windowContentWidth, frame.size.height - 50);
        
        CGFloat pageViewX = (windowContentWidth - pageCount*20 - 40)/2 + 10;
        
        for (int i = 0;i < pageCount; i++) {
            UIView * pageTag = [[UIView alloc] initWithFrame:CGRectMake( pageViewX + 20  * i + 10 * i, frame.size.height - 10, 20, 3)];
            pageTag.layer.cornerRadius = 1.5;
            pageTag.layer.masksToBounds = YES;
            pageTag.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [self addSubview:pageTag];
        }
        
        self.currentView = [[UIView alloc] initWithFrame:CGRectMake(pageViewX, frame.size.height - 10, 20, 3)];
        self.currentView.backgroundColor = [UIColor orangeColor];
        self.currentView.layer.cornerRadius = 1.5;
        self.currentView.layer.masksToBounds = YES;
        [self addSubview:self.currentView];
    }

    return self;
}


-(instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName andtitleImage:(NSString *)titleImage btnImgArray:(NSArray *)btnImgArray andChooseBlock:(ChooseBtnClick)chooseBtnClick
{
    if (self = [super initWithFrame:frame]) {
        self.chooseBtnClick = chooseBtnClick;
        self.backgroundColor = [UIColor whiteColor];
        //图片
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
        self.titleImageView.image = [UIImage imageNamed:titleImage];
        [self addSubview:self.titleImageView];
        
        //文字
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, frame.size.width - 70, 25)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.text = titleName;
        [self addSubview:self.titleLabel];
        
        self.btnImageArray = btnImgArray;
        
        UIScrollView *btnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth, frame.size.height - 40)];
        [self addSubview:btnScrollView];
        
        
        int colWidth = (windowContentWidth - M_ShipLine_But_Width * 4 - 40) / 3;
        for (int i = 0; i < btnImgArray.count; i++) {
            NSString * imageStr = [btnImgArray objectAtIndex:i];

            ZFJImageAndTitleButton * but = [[ZFJImageAndTitleButton alloc] initWithFrame:CGRectMake(M_ShipLine_But_Width *i  + colWidth *i  + 20, 0, M_ShipLine_But_Width, M_ShipLine_But_Width + 30) shipViewCornerRadius:0 masksToBounds:NO];
            
            [but.iconImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"默认图1"]];
            but.tag = 100 + i ;
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            [btnScrollView addSubview:but];
            
        }
        btnScrollView.delegate = self;
        btnScrollView.pagingEnabled = YES;
        btnScrollView.showsHorizontalScrollIndicator = NO;
        NSInteger pageCount = btnImgArray.count / 4 < btnImgArray.count / 4.0 ?btnImgArray.count / 4 + 1 :btnImgArray.count / 4;
        btnScrollView.contentSize = CGSizeMake(pageCount*windowContentWidth, frame.size.height - 50);
        
        CGFloat pageViewX = (windowContentWidth - pageCount*20 - 40)/2 + 10;
        
        for (int i = 0;i < pageCount; i++) {
            UIView * pageTag = [[UIView alloc] initWithFrame:CGRectMake(pageViewX + 20  * i + 10 * i, frame.size.height - 10, 20, 3)];
            pageTag.layer.cornerRadius = 1.5;
            pageTag.layer.masksToBounds = YES;
            pageTag.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [self addSubview:pageTag];
        }
        
        self.currentView = [[UIView alloc] initWithFrame:CGRectMake(pageViewX, frame.size.height - 10, 20, 3)];
        self.currentView.backgroundColor = [UIColor orangeColor];
        self.currentView.layer.cornerRadius = 1.5;
        self.currentView.layer.masksToBounds = YES;
        [self addSubview:self.currentView];
        
    }
    return self;

}
-(instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName andtitleImage:(NSString *)titleImage
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //图片
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
        self.titleImageView.image = [UIImage imageNamed:titleImage];
        [self addSubview:self.titleImageView];
        
        //文字
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, frame.size.width - 70, 25)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.text = titleName;
        [self addSubview:self.titleLabel];
    }
    return self;
}
-(void)chooseBut:(ZFJImageAndTitleButton *)btn
{
    if (self.chooseBtnClick) {
        self.chooseBtnClick(btn.tag - 100);
    }

    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger pageCount = self.btnImageArray.count / 4 < self.btnImageArray.count / 4.0 ?self.btnImageArray.count / 4 + 1 :self.btnImageArray.count / 4;
    CGFloat pageViewX = (windowContentWidth - pageCount*20 - 40)/2;

    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.currentView.frame = CGRectMake(pageViewX + scrollView.contentOffset.x / windowContentWidth * 30, self.frame.size.height - 10, 20, 3);
    } completion:nil];

}
@end
