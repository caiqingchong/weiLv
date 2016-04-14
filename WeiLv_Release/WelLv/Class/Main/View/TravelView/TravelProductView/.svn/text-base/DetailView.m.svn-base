//
//  DetailView.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/21.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "DetailView.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation DetailView

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
//        [self addControl];
    }
    return self;
}

- (void)addControl{
    
    self.locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40, UISCREEN_HEIGHT / 30, UISCREEN_WIDTH / 17.58, UISCREEN_HEIGHT / 22.36)];
    self.locationImage.image = [UIImage imageNamed:@"定位"];
    
    self.lineLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2, CGRectGetMaxY(self.locationImage.frame), 0.5, 130)];
    self.lineLable.backgroundColor = [UIColor greenColor];
    
    [self addSubview:self.locationImage];
    [self addSubview:self.lineLable];
    
    self.dayLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.locationImage.frame) + UISCREEN_WIDTH / 40, UISCREEN_HEIGHT / 37.86, UISCREEN_WIDTH / 2, UISCREEN_HEIGHT / 20.28)];
    self.dayLable.text = @"第1天   郑州-昆明";
    self.dayLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.85];
    [self addSubview:self.dayLable];
    NSArray *pictureArr = @[@"时间",@"酒店",@"餐饮"];
    for (int i = 0; i < pictureArr.count; i++) {
        self.pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.dayLable.frame), CGRectGetMaxY(self.dayLable.frame) + UISCREEN_HEIGHT / 35.5 + i * (UISCREEN_HEIGHT/ 28.4 + UISCREEN_HEIGHT / 43.69), UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 16)];
        self.pictureImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",pictureArr[i]]];
        [self addSubview:self.pictureImage];
    }
    
    NSArray *textArr = @[@"发车时间:08:00出发    12:00到达",@"酒店:暂无",@"早餐:自理   午餐:提供     晚餐:自理"];
    for (int i = 0; i < textArr.count; i++) {
        self.detaillable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImage.frame) + UISCREEN_WIDTH / 40, CGRectGetMaxY(self.dayLable.frame) + UISCREEN_HEIGHT /35.5 + i * (UISCREEN_HEIGHT/ 28.4 + UISCREEN_HEIGHT / 43.69), UISCREEN_WIDTH - UISCREEN_WIDTH / 6, UISCREEN_WIDTH / 16)];
        self.detaillable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
        self.detaillable.text = [NSString stringWithFormat:@"%@",textArr[i]];
        self.detaillable.textColor = [UIColor grayColor];
        [self addSubview:self.detaillable];
    }

    self.textLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.pictureImage.frame), CGRectGetMaxY(self.pictureImage.frame) + UISCREEN_HEIGHT / 51.6, UISCREEN_WIDTH - UISCREEN_WIDTH / 12.8, 60)];
    
    self.textLable.text = @"男星阮经天(小天)和许玮甯爱情长跑多年,最后两人曝分手,阮经天爱情失意,近期登陆改当综艺咖,加入真人秀拼命搞笑,而他20日却在微博大方邀约人妻Angelababy(Baby)一起过情人节?阮经天在微博晒出海报发文说:听说今年情人节我们要一起过”,并标记Angelababy,高调邀人妻过情人节,网友看了直呼“晓明欧巴会来打你的”,原来两人是合作爱情悬疑电影《谋杀似水年华》,Baby也有分享阮经天海报,还说“好想擦一擦这张海报”。而日前阮经天被问到情人节会不会跟许玮甯过时,他则表示:现在属于一言难尽的一种状态。";
    self.textLable.numberOfLines = 0;
    self.textLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
    self.textLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.textLable];
    
    CGSize size = CGSizeMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 12.8, 20);
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.textLable.font,NSFontAttributeName, nil];
    CGSize actualsize = [self.textLable.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    self.textLable.frame = CGRectMake(CGRectGetMinX(self.pictureImage.frame), CGRectGetMaxY(self.pictureImage.frame) + UISCREEN_HEIGHT / 51.6, actualsize.width, actualsize.height);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
