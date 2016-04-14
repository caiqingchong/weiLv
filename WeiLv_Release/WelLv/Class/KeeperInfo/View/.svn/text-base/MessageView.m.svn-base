//
//  MessageView.m
//  WelLv
//
//  Created by mac for csh on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MessageView.h"
#import "LXCommonTools.h"

@implementation MessageView
@synthesize dateLabel,mesmodel,contntLabel;
- (id)initWithModel:(MessageModel *)mesgmodel{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 70);
        self.backgroundColor = [UIColor whiteColor];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width-20, 15)];
        dateLabel.text = mesgmodel.dateString;
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.font = [UIFont systemFontOfSize:15];
        
        CGFloat height=[[LXCommonTools sharedMyTools] textHeight:mesgmodel.contentString Afont:15 width:[[UIScreen mainScreen] bounds].size.width-20];
        contntLabel = [[UILabel alloc] init];
        contntLabel.text = mesgmodel.contentString;
        contntLabel.textColor = [UIColor grayColor];
        contntLabel.textAlignment = NSTextAlignmentLeft;
        contntLabel.font = [UIFont systemFontOfSize:15];
        contntLabel.numberOfLines = 0;
        [contntLabel setFrame:CGRectMake(10, 10+15+10, [[UIScreen mainScreen] bounds].size.width-20, height)];

        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, ViewHeight(contntLabel)+ViewY(contntLabel), [[UIScreen mainScreen] bounds].size.width-20, 1)];
        lab.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];//[kColor(110, 115, 120) CGColor];
        lab.layer.borderWidth = 0.5;
        
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, ViewY(lab)+1);
        
        [self addSubview:dateLabel];
        [self addSubview:contntLabel];
        [self addSubview:lab];
        
        
    }
    
    
    return self;
}


@end
