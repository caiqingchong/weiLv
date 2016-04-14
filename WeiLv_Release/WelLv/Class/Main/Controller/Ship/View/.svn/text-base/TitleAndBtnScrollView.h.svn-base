//
//  TitleAndBtnScrollView.h
//  WelLv
//
//  Created by 吴伟华 on 16/3/8.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseBtnClick)(NSInteger selectBtn);

@interface TitleAndBtnScrollView : UIView

//表示游轮航线
-(instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName andtitleImage:(NSString *)titleImage andBtnNameArray:(NSArray *)btnNameArray btnImgArray:(NSArray *)btnImgArray andChooseBlock:(ChooseBtnClick)chooseBtnClick;

//表示游轮品牌
-(instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName andtitleImage:(NSString *)titleImage btnImgArray:(NSArray *)btnImgArray andChooseBlock:(ChooseBtnClick)chooseBtnClick;

//热推航线
-(instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName andtitleImage:(NSString *)titleImage;
@end
