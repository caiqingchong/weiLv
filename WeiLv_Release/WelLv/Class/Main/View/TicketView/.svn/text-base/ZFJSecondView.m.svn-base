//
//  ZFJSecondView.m
//  WelLv
//
//  Created by 张发杰 on 15/8/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSecondView.h"
#import "ZFJInforView.h"

#define M_RIGHT_WIDTH  70
#define M_commission_height 18
@interface ZFJSecondView ()
@property (nonatomic, strong)ZFJInforView * inforView;

@end

@implementation ZFJSecondView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addCustomView];
    }
    return self;
}

- (void)addCustomView {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth - M_RIGHT_WIDTH, ViewHeight(self))];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    //self.titleLabel.backgroundColor = [UIColor orangeColor];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    
    self.commissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewHeight(_titleLabel) - M_commission_height, ViewWidth(_titleLabel) - 10, M_commission_height)];
    //self.commissionLabel.backgroundColor = [UIColor blackColor];
    self.commissionLabel.font = [UIFont systemFontOfSize:12];
    self.commissionLabel.textColor = TimeGreenColor;
    [self.titleLabel addSubview:_commissionLabel];
    
    
    self.onAndOffIcon = [[UIImageView alloc] init];
    //self.onAndOffIcon.backgroundColor = [UIColor grayColor];
    self.onAndOffIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
    [self addSubview:_onAndOffIcon];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(self) - M_RIGHT_WIDTH, 5, M_RIGHT_WIDTH, ViewHeight(self) / 2)];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
    
    self.reserveBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reserveBut.frame = CGRectMake(ViewWidth(self) - M_RIGHT_WIDTH, ViewHeight(self) / 2 - 5, M_RIGHT_WIDTH - 10, ViewHeight(self) / 2 - 5);
    self.reserveBut.layer.cornerRadius = 3.0;
    self.reserveBut.layer.masksToBounds = YES;
    self.reserveBut.backgroundColor = kColor(123, 174, 253);
    [self.reserveBut setTitle:@"预订" forState:UIControlStateNormal];
    [self.reserveBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.reserveBut addTarget:self action:@selector(reserveBut:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reserveBut];
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTicketView:)];
//    [self addGestureRecognizer:tap];
    
}

- (void)setGoodsModel:(TicketGoodsModel *)goodsModel {
    
    self.titleLabel.text = [NSString stringWithFormat:@"  %@", [self judgeReturnString:goodsModel.goods_name withReplaceString:@""]];
    CGFloat titleWidth = [self returnTextCGRectText:self.titleLabel.text textFont:15 cGSize:CGSizeMake(0, ViewHeight(self))].size.width;
    self.titleLabel.frame = CGRectMake(0, 0, MIN(titleWidth, windowContentWidth - M_RIGHT_WIDTH - 25), ViewHeight(self));
    self.commissionLabel.frame = CGRectMake(ViewX(_commissionLabel), ViewY(_commissionLabel), windowContentWidth - M_RIGHT_WIDTH - 10, ViewHeight(_commissionLabel));
    CGFloat commissionFloat =[goodsModel.assistant_rebate floatValue];// [goodsModel.sell_price floatValue] * 0.04;
    self.commissionLabel.text = [NSString stringWithFormat:@"返佣:¥%0.2f", commissionFloat];
    
    if ([[[LXUserTool sharedUserTool] getuserGroup] isEqualToString:@"assistant"]){
        self.commissionLabel.hidden = NO;
    } else {
        self.commissionLabel.hidden = YES;
    }

    self.onAndOffIcon.frame = CGRectMake( ViewRight(self.titleLabel) + 5, ViewHeight(self) / 2 - self.onAndOffIcon.image.size.height / 2, self.onAndOffIcon.image.size.width, self.onAndOffIcon.image.size.height);
    self.onAndOffIcon.transform = CGAffineTransformMakeRotation(M_PI_4);

    self.priceLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:16px;color:#E53333;>¥<span style=font-size:18px;>%@</span><span style=font-size:10px;color:#E53333;>起</span>", [self judgeReturnString:goodsModel.sell_price withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [self.priceLabel sizeToFit];
    
}


- (void)tapTicketView:(UITapGestureRecognizer *)tap {
    if (self.inforView == nil) {
        ZFJInforView * inforView = [[ZFJInforView alloc] initWithFrame:CGRectMake(0, ViewBelow(tap.view), windowContentWidth, 0) withInforSte:@"<h3>门票</h3>"];
        inforView.hidden = YES;
        [self addSubview:inforView];
    } else {
        
    }
    
}



- (void)reserveBut:(UIButton *)button{
    self.tapReserveBut(button);
}
- (void)reserveTicket:(TapReserveBut)reserveBut{
    self.tapReserveBut = reserveBut;
}

- (void)returnInforViewHeight:(OnAndOffInforView)inforViewHeight {
    self.onAndOffInforView = inforViewHeight;
}

@end
