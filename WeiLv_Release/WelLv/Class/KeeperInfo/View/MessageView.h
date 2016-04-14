//
//  MessageView.h
//  WelLv
//
//  Created by mac for csh on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageView : UIView

@property (nonatomic , strong) UILabel *dateLabel;
@property (nonatomic , strong) UILabel *contntLabel;

@property (nonatomic,strong) MessageModel *mesmodel;

- (id)initWithModel:(MessageModel *)mesgmodel;

@end
