//
//  ZFJTicketReserveView.h
//  WelLv
//
//  Created by 张发杰 on 15/8/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapReserveBut)(UIButton * but);
typedef void(^OnAndOffInforView)(CGFloat viewHeight);

@interface ZFJTicketReserveView : UIView

//
//@property (nonatomic, strong) UILabel *  titleLabel;
//@property (nonatomic, strong) UIImageView *  onAndOffIcon;
//@property (nonatomic, strong) UILabel * priceLabel;
//@property (nonatomic, strong) UIButton * reserveBut;

@property (nonatomic, strong) UIView * inforView;
@property (nonatomic, strong) UIImageView * inforImage;
@property (nonatomic, strong) UILabel * inforLabel;
@property (nonatomic, copy) TapReserveBut tapReserveBut;
@property (nonatomic, copy) OnAndOffInforView onAndOffInforView;

- (id)initWithFrame:(CGRect)frame withTicketArray:(NSArray *)ticketArr;
- (void)reserveTicket:(TapReserveBut)reserveBut;
- (void)returnInforViewHeight:(OnAndOffInforView)inforViewHeight;

@end
