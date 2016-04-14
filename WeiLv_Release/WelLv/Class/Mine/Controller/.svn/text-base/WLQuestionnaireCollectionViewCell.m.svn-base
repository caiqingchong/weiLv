//
//  QuestionnaireCollectionViewCell.m
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WLQuestionnaireCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "QuestionnaireViewController.h"

@interface WLQuestionnaireCollectionViewCell ()

@property(strong, nonatomic) NSIndexPath *indexPath;

@property(strong, nonatomic) NSString *jid;

@end

@implementation WLQuestionnaireCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setSubviews];
    }
    
    return self;
}

- (void)setSubviews {
    
    //景点名称
    UILabel *placeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 15)];
    
    placeNameLabel.font = [UIFont systemFontOfSize:14.0];
    
    placeNameLabel.textColor = [UIColor colorWithRed:106.0/255.0 green:106.0/255.0 blue:106.0/255.0 alpha:1];
    
    [self.contentView addSubview:placeNameLabel];
    
    self.placeNameLabel = placeNameLabel;
    
    //选择框
    UIView *chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 26, self.frame.size.width, 25)];
    
    chooseView.layer.borderWidth = 1.0;
    
    chooseView.layer.borderColor = [UIColor colorWithRed:234.0/255.0 green:233.0/255.0 blue:234.0/255.0 alpha:1].CGColor;
    
    [self.contentView addSubview:chooseView];
    
    self.chooseView = chooseView;
    
    //去过
    UIView *visitedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, chooseView.frame.size.width / 2, 25)];
    
    visitedView.userInteractionEnabled = YES;
    
    CGFloat visitedIconWidth = 10;
    
    CGFloat visitedIconOriginX = (visitedView.frame.size.width - visitedIconWidth - 5 - 26) / 2;
    
    UIImageView *visitedIcon = [[UIImageView alloc] initWithFrame:CGRectMake(visitedIconOriginX, (visitedView.frame.size.height - 14) / 2, visitedIconWidth, 14)];
    
    visitedIcon.image = [UIImage imageNamed:@"去过-默认"];
    
    [visitedView addSubview:visitedIcon];
    
    self.visitedIcon = visitedIcon;
    
    UILabel *visitedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(visitedIcon.frame) + 5, visitedIcon.frame.origin.y, 26, 14)];
    
    visitedLabel.text = @"去过";
    
    visitedLabel.font = [UIFont systemFontOfSize:13.0];
    
    visitedLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    [visitedView addSubview:visitedLabel];
    
    [chooseView addSubview:visitedView];
    
    self.visitedView = visitedView;
    
    //想去
    UIView *wantedView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(visitedView.frame), 0, chooseView.frame.size.width / 2, 25)];
    
    wantedView.userInteractionEnabled = YES;
    
    CGFloat wantedIconWidth = 15;
    
    CGFloat wantedIconOriginX = (wantedView.frame.size.width - wantedIconWidth - 5 - 26) / 2;
    
    UIImageView *wantedIcon = [[UIImageView alloc] initWithFrame:CGRectMake(wantedIconOriginX, (wantedView.frame.size.height - 14) / 2, wantedIconWidth, 14)];
    
    wantedIcon.image = [UIImage imageNamed:@"想去-默认"];
    
    [wantedView addSubview:wantedIcon];
    
    self.wantedIcon = wantedIcon;
    
    UILabel *wantedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wantedIcon.frame) + 5, wantedIcon.frame.origin.y, 26, 14)];
    
    wantedLabel.text = @"想去";
    
    wantedLabel.font = [UIFont systemFontOfSize:13.0];
    
    wantedLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    [wantedView addSubview:wantedLabel];
    
    [chooseView addSubview:wantedView];
    
    self.wantedView = wantedView;
    
    //景点照片
    UIImageView *placeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(placeNameLabel.frame) + 5, self.frame.size.width, self.frame.size.height - 45)];
    
    [self.contentView addSubview:placeImageView];
    
    self.placeImageView = placeImageView;
    
    //景点简介
    UILabel *placeBriefLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(placeImageView.frame) - 20, self.frame.size.width - 10, 20)];
    
    placeBriefLabel.font = [UIFont systemFontOfSize:13.0];
    
    placeBriefLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:placeBriefLabel];
    
    self.placeBriefLabel = placeBriefLabel;
}

- (void)setContentWithArray:(NSArray *)content indexPath:(NSIndexPath *)indexPath contentType:(NSInteger)type selectStates:(BOOL)isSelected andSelectedOption:(NSString *)option {
    
    if(indexPath.row % 2 != 0){
        
        self.placeNameLabel.textAlignment = NSTextAlignmentRight;
    }
    
    self.indexPath = indexPath;
    
    NSDictionary *dataDict = [content objectAtIndex:indexPath.row];
    
    if(type == ContentTypeQuestionnaire){
        
        self.jid = [dataDict objectForKey:@"jid"];
        
        self.placeNameLabel.text = [dataDict objectForKey:@"title"];
        
        NSURL *url = [NSURL URLWithString:[dataDict objectForKey:@"pic"]];
        
        [self.placeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认图4"]];
        
        self.placeBriefLabel.text = [dataDict objectForKey:@"desc"];
        
        UITapGestureRecognizer *tapVisitedView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapVisited:)];
        
        [self.visitedView addGestureRecognizer:tapVisitedView];
        
        UITapGestureRecognizer *tapWantedView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapWanted:)];
        
        [self.wantedView addGestureRecognizer:tapWantedView];
        
        if(isSelected){
            
            if([option isEqualToString:@"1"]){
                
                self.visitedIcon.image = [UIImage imageNamed:@"去过-选中"];
                
                self.visitedIcon.tag = 1;
            }
            
            if([option isEqualToString:@"2"]){
                
                self.wantedIcon.image = [UIImage imageNamed:@"想去-选中"];
                
                self.wantedIcon.tag = 1;
            }
            
        }else{
            
            self.visitedIcon.image = [UIImage imageNamed:@"去过-默认"];
            
            self.visitedIcon.tag = 0;
            
            self.wantedIcon.image = [UIImage imageNamed:@"想去-默认"];
            
            self.wantedIcon.tag = 0;
        }
    }
    
    if(type == ContentTypeVisited){
        
        self.placeNameLabel.text = [dataDict objectForKey:@"title"];
        
        NSURL *url = [NSURL URLWithString:[dataDict objectForKey:@"pic"]];
        
        [self.placeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认图4"]];
        
        self.placeBriefLabel.text = [dataDict objectForKey:@"desc"];
        
        self.visitedIcon.image = [UIImage imageNamed:@"去过-选中"];
        
        self.wantedView.hidden = YES;
    }
    
    if(type == ContentTypeWanted){
        
        self.placeNameLabel.text = [dataDict objectForKey:@"title"];
        
        NSURL *url = [NSURL URLWithString:[dataDict objectForKey:@"pic"]];
        
        [self.placeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认图4"]];
        
        self.placeBriefLabel.text = [dataDict objectForKey:@"desc"];
        
        self.wantedIcon.image = [UIImage imageNamed:@"想去-选中"];
        
        self.wantedView.frame = self.visitedView.frame;
        
        self.visitedView.hidden = YES;
    }
}

- (void)onTapVisited:(UITapGestureRecognizer *)tap {
    
    if(self.visitedIcon.tag){
        
        self.visitedIcon.image = [UIImage imageNamed:@"去过-默认"];
        
        self.visitedIcon.tag = 0;
        
    }else{
        
        self.visitedIcon.image = [UIImage imageNamed:@"去过-选中"];
        
        self.visitedIcon.tag = 1;
        
        self.wantedIcon.image = [UIImage imageNamed:@"想去-默认"];
        
        self.wantedIcon.tag = 0;
    }
    
    [self.delegate didSelectedOptionWithIndexPath:self.indexPath optionData:@{@"journey_id": self.jid, @"sel_type": @"1"} andSelectStates:self.visitedIcon.tag];
}

- (void)onTapWanted:(UITapGestureRecognizer *)tap {
    
    if(self.wantedIcon.tag){
        
        self.wantedIcon.image = [UIImage imageNamed:@"想去-默认"];
        
        self.wantedIcon.tag = 0;
        
    }else{
        
        self.wantedIcon.image = [UIImage imageNamed:@"想去-选中"];
        
        self.wantedIcon.tag = 1;
        
        self.visitedIcon.image = [UIImage imageNamed:@"去过-默认"];
        
        self.visitedIcon.tag = 0;
    }
    
    [self.delegate didSelectedOptionWithIndexPath:self.indexPath optionData:@{@"journey_id": self.jid, @"sel_type": @"2"} andSelectStates:self.wantedIcon.tag];
}

@end







