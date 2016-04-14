//
//  zxdChoseOtherViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class zxdChoseOtherViewController;
@protocol zxdChoseOtherViewControllerDelegate <NSObject>

-(void)zxdViewController3:(zxdChoseOtherViewController*)zxdVC text:(NSString *)string number:(NSInteger)number;

@end
@interface zxdChoseOtherViewController : XCSuperObjectViewController
{
    
}
@property(nonatomic,strong)NSMutableArray *arrSelect;
@property(nonatomic,strong)NSMutableArray *arrAllImage;
@property(assign,nonatomic)NSInteger type;
@property(nonatomic,strong)NSString *starString;
@property(nonatomic,strong)NSString *uid;
@property(assign,nonatomic)id <zxdChoseOtherViewControllerDelegate>delegate;
@end
