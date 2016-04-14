//
//  VisaListCell.m
//  WelLv
//
//  Created by 张发杰 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VisaListCell.h"
#import "IamgeAndLabelView.h"
#import "ZFJVisaModel.h"
#define ICON_TOP 10
#define ICON_LEFT 10
#define ICON_WIDTH 75

#define WIDTH_GAP 10 //间距

#define TITLE_HEIGHT 20

@implementation VisaListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = [UIColor grayColor].CGColor;
        [self coustomView];
    }
    return self;
}

- (void)coustomView
{
    self.iconCountryImage = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_LEFT, ICON_TOP, ICON_WIDTH, ICON_WIDTH)];
    self.iconCountryImage.layer.cornerRadius = 5;
    self.iconCountryImage.layer.masksToBounds = YES;
    self.iconCountryImage.backgroundColor = [UIColor cyanColor];
    [self addSubview:_iconCountryImage];
    
    self.visaListNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP, self.frame.size.width - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, TITLE_HEIGHT)];
    //self.visaListNameLabel.backgroundColor = [UIColor purpleColor];
    self.visaListNameLabel.text = @"马来西亚旅游签证［北京微旅科技］";
    [self addSubview:_visaListNameLabel];
    
    self.LengthOfTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP + TITLE_HEIGHT, self.frame.size.width - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, TITLE_HEIGHT )];
    self.LengthOfTimeLabel.font = [UIFont systemFontOfSize:15];
    self.LengthOfTimeLabel.text = @"单次入境  最长停留15天";
    self.LengthOfTimeLabel.textColor = [UIColor grayColor];
    [self addSubview:_LengthOfTimeLabel];
    
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP , ICON_TOP + TITLE_HEIGHT * 2, 100, TITLE_HEIGHT)];
    
    self.priceLabel.text = @"¥123";
    self.priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    
    UILabel * startLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.frame.origin.x + self.priceLabel.frame.size.width, ICON_TOP + TITLE_HEIGHT * 2 + 5, 50, TITLE_HEIGHT - 5)];
    startLabel.text = @"起";
    startLabel.textColor = [UIColor grayColor];
    startLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:startLabel];

    //UILabel * aTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP + 10 + , <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    
    
    self.imageAndLabelView = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP + TITLE_HEIGHT * 3, self.frame.size.width - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, TITLE_HEIGHT - 5)];
    self.imageAndLabelView.infoLanel.text = @"3个月有效期";
    self.imageAndLabelView.iconIamge.image = [UIImage imageNamed:@""];
    self.imageAndLabelView.infoLanel.font = [UIFont systemFontOfSize:12];
    self.imageAndLabelView.infoLanel.textColor = [UIColor grayColor];
    [self addSubview:_imageAndLabelView];
    
}

- (void)setVisaModel:(ZFJVisaModel *)visaModel
{
    [self.iconCountryImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP, visaModel.list_thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.visaListNameLabel.text = visaModel.product_name;
    self.LengthOfTimeLabel.text = visaModel.stay;
}

@end
