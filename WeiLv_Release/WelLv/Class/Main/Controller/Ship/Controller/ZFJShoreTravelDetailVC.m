//
//  ZFJShoreTravelDetailVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/22.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShoreTravelDetailVC.h"
#import "ZFJShipDetailModel.h"

@interface ZFJShoreTravelDetailVC ()
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIScrollView * msgScrollView;
@property (nonatomic, strong) UIButton * dismissBut;

@end

@implementation ZFJShoreTravelDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0x4a4a4a);
    [self addHeaderView];
    [self addMsgScrollView];
    
    self.dismissBut  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dismissBut.frame = CGRectMake(windowContentWidth / 2 - 25, windowContentHeight - 80, 50, 50);
    //self.dismissBut.backgroundColor = [UIColor orangeColor];
    [self.dismissBut setImage:[UIImage imageNamed:@"shore_travel_cancel_but"] forState:UIControlStateNormal];
    [self.dismissBut addTarget:self action:@selector(dismissVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissBut];
}

- (void)dismissVC:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, windowContentWidth, 40)];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [self judgeReturnString:[self.dataDic objectForKey:@"tour_name"] withReplaceString:@""];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.headerView addSubview:titleLabel];

    
    UILabel * dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(titleLabel), windowContentWidth, 40)];
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.text = [NSString stringWithFormat:@"第%@天", [self judgeReturnString:[self.dataDic objectForKey:@"day"] withReplaceString:@""]];
    dayLabel.font = [UIFont systemFontOfSize:20];
    [self.headerView addSubview:dayLabel];
    
    
    UIImageView * priceBgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 55, ViewBelow(titleLabel), 55, 27)];
    priceBgIcon.image = [UIImage imageNamed:@"shore_travel_price_bg"];
    [self.headerView addSubview:priceBgIcon];
    
    
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(13.5, 0, 55 - 13.5, 27)];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.adjustsFontSizeToFitWidth = YES;
    NSString * priceStr = @"";
    //NSLog(@"%@", [self.dataDic objectForKey:@"fee_status"]);
    if ([[self.dataDic objectForKey:@"fee_status"] isEqualToString:@"0"]) {
        priceStr = [NSString stringWithFormat:@"¥%@", [self judgeReturnString:[self.dataDic objectForKey:@"tour_price"] withReplaceString:@""]];
    } else if ([[self.dataDic objectForKey:@"fee_status"] isEqualToString:@"1"]) {
        priceStr = @"免费";
    }
    priceLabel.text = priceStr;
    [priceBgIcon addSubview:priceLabel];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(10, ViewBelow(dayLabel), windowContentWidth - 20, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    self.headerView.frame = CGRectMake(0, 50, windowContentHeight, ViewBelow(lineView));
    [self.headerView addSubview:lineView];
    [self.view addSubview:_headerView];

}

- (void)addMsgScrollView {
    self.msgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ViewBelow(_headerView), windowContentWidth, windowContentHeight - ViewBelow(_headerView) - 80)];
    //self.msgScrollView.backgroundColor = [UIColor orangeColor];
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ViewWidth(_msgScrollView) - 20, 30)];
    timeLabel.text = [NSString stringWithFormat:@"%@抵达   %@离开", self.arrival_time, self.sail_time];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor grayColor];
    [self.msgScrollView addSubview:timeLabel];
    
    
    
    
    NSString *breakfastStr = @"";
    NSString *lunchStr = @"";
    NSString *dinnerStr = @"";
    
    if ([[self.dataDic objectForKey:@"breakfast"] isEqual:@"0"]) {
        breakfastStr = @"自理";
    }else if ([[self.dataDic objectForKey:@"breakfast"] isEqual:@"1"]){
        breakfastStr = @"含餐";
    }
    if ([[self.dataDic objectForKey:@"lunch"] isEqual:@"0"]) {
        lunchStr = @"自理";
    }else if ([[self.dataDic objectForKey:@"lunch"] isEqual:@"1"]){
        lunchStr = @"含餐";
    }
    if ([[self.dataDic objectForKey:@"dinner"] isEqual:@"0"]) {
        dinnerStr = @"自理";
    }else if ([[self.dataDic objectForKey:@"dinner"] isEqual:@"1"]){
        dinnerStr = @"含餐";
    }

    
    
    UILabel * eatLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(timeLabel), ViewWidth(_msgScrollView) - 20, 30)];
    eatLabel.textColor = [UIColor grayColor];
    eatLabel.font = [UIFont systemFontOfSize:14];
    eatLabel.text = [NSString stringWithFormat:@"早餐:%@    午餐:%@    晚餐:%@", breakfastStr, lunchStr, dinnerStr];
    //@"早餐:自理     午餐:包含    晚餐:自理";
    [self.msgScrollView addSubview:eatLabel];
    
    UILabel * msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(eatLabel) + 5, ViewWidth(_msgScrollView) - 20, 50)];
    msgLabel.numberOfLines = 0;
    //<span color:#FFFFFF;>%@</span>
    msgLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:14px;background-color:#4a4a4a;color:#FFFFFF;>%@</span>", [self judgeReturnString:[self.dataDic objectForKey:@"detail"] withReplaceString:@""]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    msgLabel.font = [UIFont systemFontOfSize:14];
    [msgLabel sizeToFit];
    [self.msgScrollView addSubview:msgLabel];
    
    NSArray * albumArr = @[];
    if ([[self.dataDic objectForKey:@"album"] isKindOfClass:[NSArray class]]) {
        albumArr = [self.dataDic objectForKey:@"album"];
    }
    
    for ( int i = 0; i < albumArr.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, ViewBelow(msgLabel) + 5 + ((ViewWidth(_msgScrollView) - 20) / 1.77 + 8) * i, ViewWidth(_msgScrollView) - 20, (ViewWidth(_msgScrollView) - 20) / 1.77)];
        NSString * imageUrl = albumArr[i][@"picture"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:imageUrl]] placeholderImage:[UIImage imageNamed:@"默认图4"]];
        [self.msgScrollView addSubview:imageView];
        self.msgScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(imageView));
    }
    
    
    [self.view addSubview:_msgScrollView];
}


@end
