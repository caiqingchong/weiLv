//
//  addViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/28.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class addViewController;
@protocol addViewControllerDelegate <NSObject>

-(void)tourViewController:(addViewController *)vc zxdArr:(NSMutableArray *)zxdDataArr;

@end
@interface addViewController : XCSuperObjectViewController
@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)NSString *strPhone;
@property(nonatomic,strong)NSString *strQQ;
@property(nonatomic,strong)NSString *strd;
@property(nonatomic,strong)NSString *strUid;
@property(nonatomic,strong)UITextField *zxdTextField1;
@property(nonatomic,strong)UITextField *zxdTextField2;
@property(nonatomic,strong)UITextField *zxdTextField3;

@property(nonatomic,assign) id<addViewControllerDelegate>delegate;
@end
