//
//  DestinationCellVIew.h
//  WelLv
//
//  Created by mac for csh on 15/11/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationCellVIew : UIView
{
    UIImageView *imageView;
    UILabel *cityLabel;
    UIButton *btn;
}

@property(nonatomic , strong) UIImageView *imageView;
@property(nonatomic , strong) UILabel *cityLabel;
@property(nonatomic , strong) UIButton *btn;

-(id)initWithFrame:(CGRect)frame AndImageString:(NSString *)imageString AndCityTitle:(NSString *)cityString;


@end
