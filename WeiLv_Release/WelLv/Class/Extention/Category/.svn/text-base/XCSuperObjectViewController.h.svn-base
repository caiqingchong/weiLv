//
//  XCSuperObjectViewController.h
//  xmData
//
//  Created by wxc on 13-10-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    isPush,
    isModel
}XCPushType;

@class BackBtn;
@interface XCSuperObjectViewController : UIViewController
{
     XCPushType _pushType;
    
}
@property (nonatomic,assign) XCPushType pushType;
@property (nonatomic,strong)NSString *backTitle;
@property (nonatomic,strong)BackBtn *backBtn;

///**
// *  1旅游 2邮轮 3签证 4管家
// */
//@property (nonatomic,assign)NSInteger searchType;
- (void)close;
- (void)addGes;
@end

@interface BackBtn : UIButton

@property (nonatomic,strong)UIImageView *leftView;
@property (nonatomic,strong)UILabel *titleLab;
@end