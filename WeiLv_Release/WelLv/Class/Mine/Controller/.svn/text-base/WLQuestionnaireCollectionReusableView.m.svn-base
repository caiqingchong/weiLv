//
//  QuestionnaireCollectionReusableView.m
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WLQuestionnaireCollectionReusableView.h"
#import "QuestionnaireViewController.h"

@implementation WLQuestionnaireCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setSubviews];
    }
    
    return self;
}

- (void)setSubviews {
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
    
    titleLabel.font = [UIFont systemFontOfSize:13.0 weight:normal];
    
    titleLabel.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
    
    [self addSubview:titleLabel];
    
    self.titleLabel = titleLabel;
    
    //中国
    CGFloat buttonWidth = 50.0;
    
    CGFloat buttonHeight = 28.0;
    
    UILabel *domesticBtn = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - buttonWidth * 2 - 10) / 2, (self.frame.size.height - buttonHeight) / 2, buttonWidth, buttonHeight)];
    
    domesticBtn.tag = 666;
    
    domesticBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapDomesticBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAreaBtn:)];
    
    [domesticBtn addGestureRecognizer:tapDomesticBtn];
    
    domesticBtn.hidden = YES;
    
    domesticBtn.text = @"中国";
    
    domesticBtn.font = [UIFont systemFontOfSize:14.0];
    
    domesticBtn.textAlignment = NSTextAlignmentCenter;
    
    domesticBtn.textColor = [UIColor whiteColor];
    
    domesticBtn.layer.borderWidth = 1.0;
    
    domesticBtn.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1].CGColor;
    
    domesticBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
    
    domesticBtn.layer.masksToBounds = YES;
    
    domesticBtn.layer.cornerRadius = 8.0;
    
    [self addSubview:domesticBtn];
    
    self.domesticBtn = domesticBtn;
    
    //地球
    UILabel *abroadBtn = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(domesticBtn.frame) + 10, (self.frame.size.height - buttonHeight) / 2, buttonWidth, buttonHeight)];
    
    abroadBtn.tag = 888;
    
    abroadBtn.userInteractionEnabled = YES;
    
    //添加轻击手势
    UITapGestureRecognizer *tapAbroadBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAreaBtn:)];
    
    [abroadBtn addGestureRecognizer:tapAbroadBtn];
    
    abroadBtn.hidden = YES;
    
    abroadBtn.text = @"地球";
    
    abroadBtn.font = [UIFont systemFontOfSize:14.0];
    
    abroadBtn.textAlignment = NSTextAlignmentCenter;
    
    abroadBtn.textColor = [UIColor colorWithRed:255.0/255.0 green:131.0/255.0 blue:0.0/255.0 alpha:1];
    
    abroadBtn.layer.borderWidth = 1.0;
    
    abroadBtn.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1].CGColor;
    
    abroadBtn.layer.masksToBounds = YES;
    
    abroadBtn.layer.cornerRadius = 8.0;
    
    [self addSubview:abroadBtn];
    
    self.abroadBtn = abroadBtn;
    
    //底边框
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, self.frame.size.width, 2)];
    
    bottomLine.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:190.0/255.0 blue:25.0/255.0 alpha:1];
    
    [self addSubview:bottomLine];
}

- (void)setContent:(NSString *)content andContentType:(NSInteger)type{
    
    self.titleLabel.text = content;
    
    if(type == ContentTypeVisited || type == ContentTypeWanted){
        
        self.domesticBtn.hidden = NO;
        
        self.abroadBtn.hidden = NO;
    }
}

- (void)onTapAreaBtn:(UITapGestureRecognizer *)tap {
    
    NSInteger tag = tap.view.tag;
    
    if(tag == 666){
        
        self.domesticBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
        
        self.domesticBtn.textColor = [UIColor whiteColor];
        
        self.abroadBtn.backgroundColor = [UIColor whiteColor];
        
        self.abroadBtn.textColor = [UIColor colorWithRed:255.0/255.0 green:131.0/255.0 blue:0.0/255.0 alpha:1];
        
    }else{
        
        self.abroadBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
        
        self.abroadBtn.textColor = [UIColor whiteColor];
        
        self.domesticBtn.backgroundColor = [UIColor whiteColor];
        
        self.domesticBtn.textColor = [UIColor colorWithRed:255.0/255.0 green:131.0/255.0 blue:0.0/255.0 alpha:1];
    }
    
    [self.delegate didSelectedAreaButtonWithTag:tap.view.tag];
}

@end








