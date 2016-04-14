//
//  WLResultView.m
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WLResultView.h"
#import "PersonalTravelsViewController.h"
#import "QuestionnaireViewController.h"

@implementation WLResultView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        
        self.hidden = YES;
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapResultView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapResultView:)];
        
        [self addGestureRecognizer:tapResultView];
        
        [self setSubviews];
    }
    
    return self;
}

- (void)setSubviews {
    
    //测试结果提示
    CGFloat tipSize = 24;
    
    UILabel *tipLabel = [[UILabel alloc] init];
    
    tipLabel.text = @"测试结果";
    
    tipLabel.font = [UIFont systemFontOfSize:tipSize weight:bold];
    
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    tipLabel.textColor = kColor(255.0, 136.0, 56.0);
    
    [self addSubview:tipLabel];
    
    //表情
    CGFloat expressionSize = 100.0;
    
    UIImageView *expressionImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - expressionSize) / 2, (SCREEN_HEIGHT - 64 - expressionSize - 30 - 15) / 2, expressionSize, expressionSize)];
    
    [self addSubview:expressionImageView];
    
    self.expressionImageView = expressionImageView;
    
    tipLabel.frame = CGRectMake(0, expressionImageView.frame.origin.y - (expressionImageView.frame.origin.y - tipSize) * 0.4, SCREEN_WIDTH, tipSize);
    
    //测试结果
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(expressionImageView.frame) + 30, SCREEN_WIDTH, 15)];
    
    resultLabel.font = [UIFont systemFontOfSize:14.0 weight:bold];
    
    resultLabel.textColor = [UIColor whiteColor];
    
    resultLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:resultLabel];
    
    self.resultLabel = resultLabel;
    
    //无数据时显示的背景图片
    UIImageView *noDataImage = [[UIImageView alloc]init];
    
    [self addSubview:noDataImage];
    
    self.noDataImage = noDataImage;
    
    
    //跳转测试按钮
    UIButton *pushBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    if (windowContentHeight == 480)
    {
        //iPhone4
        [pushBtn setBackgroundImage:[UIImage imageNamed:@"添加按钮640@2x"] forState:UIControlStateNormal];
        
        
    }
    else if(windowContentHeight == 568)
    {
        //iPhone5,iPhone5s,iPhone6
        [pushBtn setBackgroundImage:[UIImage imageNamed:@"添加按钮640@2x"] forState:UIControlStateNormal];
        
    }
    else if (windowContentHeight == 667)
    {
        //iPhone6
        [pushBtn setBackgroundImage:[UIImage imageNamed:@"添加按钮750@2x"] forState:UIControlStateNormal];
        
    }
    else{
        
        //iPhone6p
        [pushBtn setBackgroundImage:[UIImage imageNamed:@"添加按钮6p@2x"] forState:UIControlStateNormal];
        
    }
    
    
    [pushBtn addTarget:self action:@selector(pushBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:pushBtn];
    
    self.pushBtn = pushBtn;
}

- (void)setContentWithExpression:(UIImage *)expression content:(NSString *)content userType:(NSInteger)userType status:(NSInteger)status andContentType:(NSInteger)type{
    
    if(type == ContentTypeQuestionnaire){
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        self.pushBtn.hidden = YES;
        
        self.expressionImageView.image = expression;
        
        if(status == 1){
            
            self.resultLabel.text = content;
        }
        
        if(status == 2){
            
            self.resultLabel.text = content;
            
            self.resultLabel.textColor = kColor(137.0, 199.0, 77.0);
        }
        
        if(status == 3){
            
            self.resultLabel.text = content;
            
            self.resultLabel.textColor = kColor(255.0, 131.0, 56.0);
        }
    }
    
    if(type == ContentTypeVisited){
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        
        if(userType == UserTypeMember){
            
            CGFloat noDataImageSize = 280;
            
            if (windowContentHeight == 480)
            {
                //iPhone4
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize + 50) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize +5) / 2 - 60, noDataImageSize - 50, noDataImageSize - 10);
                
                self.noDataImage.image = [UIImage imageNamed:@"去过的地方640@2x"];
                
            }
            else if (windowContentHeight == 568){
                
                //iPhone5,iPhone5s
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize + 30) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 15) / 2 - 80, noDataImageSize - 30, noDataImageSize + 20);
                
                self.noDataImage.image = [UIImage imageNamed:@"去过的地方640@2x"];
                
            }
            else if(windowContentHeight == 667)
            {
                //iPhone6,iPhone6s
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 30 - 15) / 2 - 80, noDataImageSize, noDataImageSize + 50);
                
                self.noDataImage.image = [UIImage imageNamed:@"去过的地方640@2x"];
                
            }
            else{
                
                //iPhone6p,iPhone6sp
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 30 - 15) / 2 - 80, noDataImageSize, noDataImageSize + 50);
                
                self.noDataImage.image = [UIImage imageNamed:@"去过的地方750@2x"];
                
            }
            
            
            self.pushBtn.frame = CGRectMake((SCREEN_WIDTH - 80) / 2, CGRectGetMaxY(self.noDataImage.frame) + 30, 80, 80);
            
        }else{
            
            CGFloat noDataImageSize = 280;
            
            if (windowContentHeight == 480)
            {
                //iPhone4
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize + 50) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize + 5) / 2 - 20, noDataImageSize - 50, noDataImageSize - 30);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有任何足迹640@2x"];
                
            }
            else if (windowContentHeight == 568){
                
                //iPhone5,iPhone5s,
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize + 30) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 15) / 2 - 40, noDataImageSize - 30, noDataImageSize - 15);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有任何足迹640@2x"];
                
            }
            else if(windowContentHeight == 667)
            {
                //iPhone6,iPhone6s
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 30 - 15) / 2 - 50, noDataImageSize, noDataImageSize + 20);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有任何足迹640@2x"];
                
            }
            else{
                
                //iPhone6p,iPhone6sp
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize - 30) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 30 - 15) / 2 - 50, noDataImageSize + 30, noDataImageSize + 50);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有任何足迹750@2x"];
                
            }
            
        }
    }
    
    if(type == ContentTypeWanted){
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        
        if(userType == UserTypeMember){
            
            CGFloat noDataImageSize = 280;
            
            
            if (windowContentHeight == 480)
            {
                //iPhone4
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize + 50) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize + 5) / 2 - 45, noDataImageSize - 50, noDataImageSize - 50);
                
                self.noDataImage.image = [UIImage imageNamed:@"想去的地方640@2x"];
                
            }
            else if (windowContentHeight == 568){
                
                //iPhone5,iPhone5s
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize + 30) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 15) / 2 - 60, noDataImageSize -30, noDataImageSize - 30);
                
                self.noDataImage.image = [UIImage imageNamed:@"想去的地方640@2x"];
            }
            else if(windowContentHeight == 667)
            {
                //iPhone6,iPhone6s
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 30 - 15) / 2 - 80, noDataImageSize, noDataImageSize + 10);
                
                self.noDataImage.image = [UIImage imageNamed:@"想去的地方640@2x"];
                
            }
            else{
                
                //iPhone6p,iPhone6sp
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize - 30 - 15) / 2 - 50, noDataImageSize, noDataImageSize + 10);
                
                self.noDataImage.image = [UIImage imageNamed:@"想去的地方750@2x"];
                
            }
            
            self.pushBtn.frame = CGRectMake((SCREEN_WIDTH - 80) / 2, CGRectGetMaxY(self.noDataImage.frame) + 30, 80, 80);
            
        }else{
            
            CGFloat noDataImageSize = 280;
            
            if (windowContentHeight == 480)
            {
                //iPhone4
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize) / 2 + 20, (SCREEN_HEIGHT - 64 - noDataImageSize) / 2 - 10, noDataImageSize - 50, noDataImageSize - 60);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有想去的地方640@2x"];
                
            }
            else if (windowContentHeight == 568){
                
                //iPhone5,iPhone5s
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize + 30) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize ) / 2 - 20, noDataImageSize - 30, noDataImageSize - 60);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有想去的地方640@2x"];
                
            }
            else if(windowContentHeight == 667)
            {
                //iPhone6,iPhone6s
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize) / 2 - 50, noDataImageSize, noDataImageSize - 30);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有想去的地方640@2x"];
                
            }
            else{
                
                //iPhone6p,iPhone6sp
                self.noDataImage.frame = CGRectMake((SCREEN_WIDTH - noDataImageSize - 30) / 2, (SCREEN_HEIGHT - 64 - noDataImageSize) / 2 - 35, noDataImageSize + 30, noDataImageSize - 5);
                
                self.noDataImage.image = [UIImage imageNamed:@"Ta还没有想去的地方750@2x"];
                
            }
        }
    }
}

- (void)onTapResultView:(UITapGestureRecognizer *)tap {
    
    [self.delegate didClickedResultView];
}

- (void)pushBtn:(UIButton *)btn {
    
    [self.delegate pushToSubmitTest];
}

@end








