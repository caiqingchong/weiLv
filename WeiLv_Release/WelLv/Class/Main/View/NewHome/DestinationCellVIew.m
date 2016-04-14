//
//  DestinationCellVIew.m
//  WelLv
//
//  Created by mac for csh on 15/11/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "DestinationCellVIew.h"

@implementation DestinationCellVIew
@synthesize imageView,cityLabel,btn;

-(id)initWithFrame:(CGRect)frame AndImageString:(NSString *)imageString AndCityTitle:(NSString *)cityString{
    if (self = [super initWithFrame:frame]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self GetImageUrLStringWithString:imageString]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
        [self addSubview:imageView];
       
        //小框和大图比例:28/71
        float proportion = 28.0/71.0;
        float wid = ViewWidth(imageView) * proportion;
        float hei = ViewHeight(imageView) * proportion;
        
        cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(imageView)/2 - wid/2, ViewHeight(imageView)/2 - hei/2, wid, hei)];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        cityLabel.text = cityString;
        cityLabel.font = [UIFont fontWithName:@"STZhongsong" size:30.0];
        cityLabel.textColor = [UIColor whiteColor];
        //cityLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        //cityLabel.layer.borderWidth = 3;
       // cityLabel.alpha = 0.7;
        UIImageView * ig = [[UIImageView alloc] initWithFrame:cityLabel.frame];
        ig.image = [UIImage imageNamed:@"destina-首页"];
        [self addSubview:ig];
        [self addSubview:cityLabel];
      
        btn= [[UIButton alloc] initWithFrame:imageView.frame];
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
        
    }


    return self;
}

-(NSString *)GetImageUrLStringWithString:(NSString *)string{
    NSString *newStr;
    if ([string hasPrefix:@"http://"] || [string hasPrefix:@"https://"]) {
        newStr = string;
    }else if (![string containsString:@"upload/advert"]){
        //NSString *str=[NSString stringWithFormat:@"%@/upload/advert/",WLHTTP];
        newStr = [[NSString stringWithFormat:@"%@/upload/advert/",WLHTTP] stringByAppendingString:string];
        //@"https://www.weilv100.com/upload/advert/"
    }else{
        newStr = [[NSString stringWithFormat:@"%@/",WLHTTP] stringByAppendingString:string];
    }
    
    return newStr;
}

@end
