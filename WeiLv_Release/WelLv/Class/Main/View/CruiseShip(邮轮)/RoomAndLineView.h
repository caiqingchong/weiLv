//
//  RoomAndLineView.h
//  WelLv
//
//  Created by 吴伟华 on 16/3/21.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFJShipDetailModel;
@protocol RoomAndLineViewDelegate <NSObject>
//产品特色点击
-(void)feartureBtnClick:(UIView *)roomAndLineView andWebViewHigh:(CGFloat)webViewHigh;
//行程与舱房点击
-(void)RoomAndLineBtnClick:(UIView *)roomAndLineView andViewHigh:(CGFloat)viewHigh;

@end

@interface RoomAndLineView : UIView

@property (nonatomic,weak)id<RoomAndLineViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame andShipDetailModel:(ZFJShipDetailModel *)shipDetailModel;
@end
