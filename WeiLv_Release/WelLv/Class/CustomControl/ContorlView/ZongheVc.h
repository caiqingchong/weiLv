//
//  ZongheVc.h
//  Lvyou
//
//  Created by 赵冉 on 16/1/13.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Zonghedelegate
//回调函数
- (void)Returnstr:(NSString *)str;

@end

@interface ZongheVc : UIView
//背景视图
@property(nonatomic,strong)UIView *backgroundView;
//综合排序  传值
@property(nonatomic,copy)NSString * str;
// 按钮背景图片 
@property(nonatomic,strong)UIImageView * imgeVcone;
@property(nonatomic,strong)UIImageView * imgeVctwo;
@property(nonatomic,strong)UIImageView * imgeVcthree;
@property(nonatomic,strong)UIImageView * imgeVcfour;

@property(nonatomic,strong)UIButton * button;
//存放点击行数
@property(nonatomic,strong)NSMutableArray * arrm;
//代理
@property(retain,nonatomic)id<Zonghedelegate>delegate;
@end
