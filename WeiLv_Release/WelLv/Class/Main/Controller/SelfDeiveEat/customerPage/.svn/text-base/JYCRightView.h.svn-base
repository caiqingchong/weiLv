//
//  JYCRightView.h
//  WelLv
//
//  Created by lyx on 15/11/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriveModel.h"

@protocol clickRightBtndelegate <NSObject>

-(void)clickPush:(NSDictionary *)dict;

@end

@interface JYCRightView : UIView
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,copy)NSString  *shopId;
@property(nonatomic,copy)NSString *memberId;
@property(nonatomic,assign)id<clickRightBtndelegate>delegate;
- (id)initWithFrame:(CGRect)frame with:(NSString *)shopId;
@end
