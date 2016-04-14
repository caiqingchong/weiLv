//
//  WLMyHehuoView.m
//  WelLv
//
//  Created by mac for csh on 16/1/26.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//  

#import "WLMyHehuoView.h"

#define kSpace 20
@implementation WLMyHehuoView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
    }
    return self;
}
-(void)setupView
{
    NSString *titleStr = @"您确定要取消合伙人资格么？";
    NSDictionary *addDict = @{NSFontAttributeName:[UIFont systemFontOfSize:25]};
    CGRect  addFrame = [titleStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:addDict context:nil];
    self.titLabel = [[UILabel alloc]init];
    if (IS_IPHONE_4_OR_LESS) {
        
        self.titLabel.frame = CGRectMake(35, 5, addFrame.size.width, addFrame.size.height);
        self.titLabel.text = titleStr;
        
    }else if (IS_IPHONE_5)
    {
        self.titLabel.frame = CGRectMake(35, 5, addFrame.size.width, addFrame.size.height);
        self.titLabel.text = titleStr;
    }else if (IS_IPHONE_6)
    {
        self.titLabel.frame = CGRectMake(45, 5, addFrame.size.width, addFrame.size.height);
        self.titLabel.text = titleStr;
        
    }else if (IS_IPHONE_6P)
    {
        self.titLabel.frame = CGRectMake(60, 5, addFrame.size.width, addFrame.size.height);
        self.titLabel.text = titleStr;
        
    }
    self.titLabel.textColor = [UIColor colorWithRed:253/255.0 green:150/255.0 blue:0 alpha:1];
    [self addSubview:self.titLabel];
    /**
     *  取消button 和确定button
     */
    self.cancleBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_4_OR_LESS) {
        
         self.cancleBtn.frame = CGRectMake(ViewX(self.titLabel), ViewY(self.titLabel)+ViewHeight(self.titLabel)+40, 100, 30);
    }else if (IS_IPHONE_5)
    {
      self.cancleBtn.frame = CGRectMake(ViewX(self.titLabel), ViewY(self.titLabel)+ViewHeight(self.titLabel)+40, 100, 30);
    
    }else if (IS_IPHONE_6)
    {
        self.cancleBtn.frame = CGRectMake(ViewX(self.titLabel), ViewY(self.titLabel)+ViewHeight(self.titLabel)+40, 100, 30);
    
    }else if (IS_IPHONE_6P)
    {
    
        self.cancleBtn.frame = CGRectMake(ViewX(self.titLabel), ViewY(self.titLabel)+ViewHeight(self.titLabel)+40, 100, 30);
    }
 
    [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self addSubview:self.cancleBtn];
    
    self.okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  
    self.okBtn.frame = CGRectMake(ViewX(self.cancleBtn)+ViewWidth(self.cancleBtn)+20, ViewY(self.cancleBtn),100, 30);
    [self.okBtn setBackgroundImage:[UIImage imageNamed:@"确定-1"] forState:UIControlStateNormal];
    [self.okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.okBtn];
   
}



@end
