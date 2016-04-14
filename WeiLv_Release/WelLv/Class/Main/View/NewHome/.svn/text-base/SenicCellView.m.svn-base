//
//  SenicCellView.m
//  WelLv
//
//  Created by mac for csh on 15/11/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "SenicCellView.h"

@implementation SenicCellView
@synthesize imageView,titleLabel,detailLabelLabel,btn;

-(id)initWithFrame:(CGRect)frame
    AndImageString:(NSString *)imageString
          AndTitle:(NSString *)titleString
AndDetailTitleString:(NSString *)detailTitieString
{
    if (self = [super initWithFrame:frame]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self GetImageUrLStringWithString:imageString]] placeholderImage:[UIImage imageNamed:@"默认图4"]];
        [self addSubview:imageView];
        
        float edgeWidth = 7;
        titleLabel =  [[UILabel alloc] initWithFrame:CGRectMake(15/2, ViewHeight(imageView)-edgeWidth -13 , windowContentWidth - edgeWidth*2, 13)];//[[UILabel alloc] initWithFrame:CGRectMake(15/2, ViewHeight(imageView)-edgeWidth -10 - edgeWidth - 13, windowContentWidth - edgeWidth*2, 13)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = titleString;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        
        detailLabelLabel = [[UILabel alloc] initWithFrame:CGRectMake(15/2, ViewHeight(imageView)-edgeWidth -10 , windowContentWidth - edgeWidth*2, 10)];
        detailLabelLabel.textAlignment = NSTextAlignmentLeft;
        detailLabelLabel.text = detailTitieString;
        detailLabelLabel.font = [UIFont systemFontOfSize:10];
        detailLabelLabel.textColor = [UIColor whiteColor];
       // [self addSubview:detailLabelLabel];
       
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
        newStr = [[NSString stringWithFormat:@"%@/upload/advert/",WLHTTP]stringByAppendingString:string];
    }else{
        newStr = [WLHTTP stringByAppendingString:string];
    }
    
    return newStr;
}

@end
