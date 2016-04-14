//
//  zxdChoseLoveViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class zxdChoseLoveViewController;
@protocol zxdChoseLoveViewControllerDelegate<NSObject>

-(void)zxdViewController:(zxdChoseLoveViewController *)zxdVC text:(NSString *)string Number:(NSInteger)number;

@end
@interface zxdChoseLoveViewController : XCSuperObjectViewController<UITextFieldDelegate>
{
    UITextField *_zxdTextField;
    //UITextField *_zxdTextField2;
    NSInteger _arrindex1;
    //NSInteger _arrindex2;
    NSString *_strtext;
    NSInteger _type;
    
}
@property(nonatomic,strong)UITextField *zxdTextField;
//@property(nonatomic,strong)UITextField *zxdTextField2;
@property(nonatomic,strong)NSString *strtext;
@property(nonatomic,assign)NSInteger arrindex1;
//@property(nonatomic,assign)NSInteger arrindex2;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,assign)id<zxdChoseLoveViewControllerDelegate>delegate;
@end
