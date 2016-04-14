//
//  LXStudyTourView.m
//  WelLv
//
//  Created by 刘鑫 on 15/8/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXStudyTourView.h"
#import "LXSTModel.h"
@implementation LXStudyTourView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame showType:(ShowType)type data:(NSMutableArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        if (type==HotCountry) {
            [self initHotCountryView:dataArray];
        }else if (type==Theme){
            [self initThemeView:dataArray];
        }
        
    }
    
    return self;
}

-(void)initHotCountryView:(NSMutableArray *)dataArray
{
    float w = 70;
    float X = 10;
    float space = (windowContentWidth - w*4-2*X)/3;
    for (int i = 0; i<dataArray.count; i++) {
        LXSTModel *model=[dataArray objectAtIndex:i];
        
        UIButton *traveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        traveBtn.frame = CGRectMake(X+(w+space)*(i%4), 10+35*(i/4)+i/4*w, w, w);
        //[traveBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",WLHTTP,model.picture]] forState:UIControlStateNormal];
        [traveBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WLHTTP,model.picture]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图1"]];
        //traveBtn.backgroundColor=[UIColor redColor];
        [traveBtn.layer setCornerRadius:3];
        traveBtn.tag = i;
        [traveBtn addTarget:self action:@selector(hotCountryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:traveBtn];
        
        
        UILabel *title = [YXTools allocLabel:model.title font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(traveBtn), ViewY(traveBtn)+ViewHeight(traveBtn), ViewWidth(traveBtn), 30) textAlignment:1];
        [self addSubview:title];
        
        if (i>=7) {
            return;
        }
    }
    
}

-(void)initThemeView:(NSMutableArray *)dataArray
{
    float space = 5;
    float w = (windowContentWidth-20-5)/2;
    float height =w*.63;
    float X = 10;
    
    for (int i = 0; i<dataArray.count; i++) {
         LXSTModel *model=[dataArray objectAtIndex:i];
        
        UIButton *traveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        traveBtn.frame = CGRectMake(X+(w+space)*(i%2), 10+space*(i/2)+i/2*height, w, height);
       // [traveBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",WLHTTP,model.picture]] forState:UIControlStateNormal];
        [traveBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WLHTTP,model.picture]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图1"]];
        //traveBtn.backgroundColor=[UIColor redColor];
        //[traveBtn.layer setCornerRadius:3];
        traveBtn.tag = i;
        [traveBtn addTarget:self action:@selector(traveClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:traveBtn];
        
//        UILabel *title = [YXTools allocLabel:model.title font:systemFont(16) textColor:[UIColor whiteColor] frame:CGRectMake(3, ViewHeight(traveBtn)-23, ViewWidth(traveBtn)-3, 20) textAlignment:0];
//        [traveBtn addSubview:title];
        
        if (i>=3) {
            return;
        }
    }
}

-(void)hotCountryClick:(UIButton *)btn
{
    [self.delegate selectHotCountry:btn.tag];
}

-(void)traveClick:(UIButton *)btn
{
    [self.delegate selectTheme:btn.tag];
}


@end
