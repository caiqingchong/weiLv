//
//  WLMyHehuoView.h
//  WelLv
//
//  Created by mac for csh on 16/1/26.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//  auther 
/**
 *  弹出试图 显示取消合伙人资格
 */
#import <UIKit/UIKit.h>

@interface WLMyHehuoView : UIView
{
    UIView *_hehuoView;

}
@property (nonatomic,strong)UILabel *titLabel;
@property (nonatomic,strong)UIButton *cancleBtn; //取消
@property (nonatomic,strong)UIButton *okBtn;


@end
