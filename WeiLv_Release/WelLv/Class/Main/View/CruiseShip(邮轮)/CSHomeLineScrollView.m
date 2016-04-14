//
//  CSHomeLineScrollView.m
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSHomeLineScrollView.h"

@interface CSHomeLineScrollView ()

@property(weak, nonatomic) UILabel *lineNameLabel;

@end

@implementation CSHomeLineScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if(self){
    
        self.backgroundColor = [UIColor whiteColor];
        
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

- (void)setLayoutWithLineContents:(NSArray *)contents {
    
    self.contentSize = CGSizeMake(LINE_ITEM_WIDTH * contents.count, self.contentSize.height);
    
    for(int i = 0; i < contents.count; i++){
    
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(LINE_ITEM_WIDTH * i, 0, LINE_ITEM_WIDTH, LINE_ITEM_HEIGHT)];
        
        itemView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapItemView:)];
        
        [itemView addGestureRecognizer:tapGesture];
        
        [self addSubview:itemView];
        
        //邮轮航线图标
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LINE_ITEM_WIDTH, LINE_IMAGE_VIEW_HEIGHT)];
        
        lineImageView.image = [UIImage imageNamed:[[contents objectAtIndex:i] objectForKey:@"image"]];
        
        [itemView addSubview:lineImageView];
        
        //邮轮航线名称
        UILabel *lineNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineImageView.frame) + 8, LINE_ITEM_WIDTH, 20)];
        
        lineNameLabel.text = [[contents objectAtIndex:i] objectForKey:@"name"];
        
        lineNameLabel.font = [UIFont systemFontOfSize:13.0];
        
        lineNameLabel.textAlignment = NSTextAlignmentCenter;
        
        lineNameLabel.textColor = [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1];
        
        [itemView addSubview:lineNameLabel];
        
        self.lineNameLabel = lineNameLabel;
    }
}

- (void)onTapItemView:(UITapGestureRecognizer *)tap {
    
    for(id obj in tap.view.subviews){
    
        if([obj isMemberOfClass:[UILabel class]]){
        
            UILabel *lineNameLabel = (UILabel *)obj;
            
            [self.sdelegate didSelectLineItemWithLineId:nil andLineName:lineNameLabel.text];
        }
    }
}

@end








