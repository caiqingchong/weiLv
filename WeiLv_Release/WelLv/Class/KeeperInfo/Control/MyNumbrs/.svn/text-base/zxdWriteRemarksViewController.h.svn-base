//
//  zxdWriteRemarksViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class zxdWriteRemarksViewController ;
@protocol zxdWriteRemarksViewControllerDelegate <NSObject>

-(void)viewController:(zxdWriteRemarksViewController *)vc text:(NSString *)string zxddate:(NSMutableArray *)zxdDate isChange:(NSInteger)icChange;

@end
@interface zxdWriteRemarksViewController : XCSuperObjectViewController
{
    //id <zxdWriteRemarksViewControllerDelegate> delegate;
}
@property(assign,nonatomic)NSInteger disSelect;
@property(nonatomic,strong)NSString *assId;
@property(nonatomic,strong)NSString *uid;
// 必须用 assign
//代理设计模式中  A引用B B也引用A，是相互引用，这时 必须一强一弱，如果是两个强引用 那么会导致死锁 对象不能销毁
//我们一般把设置代理的地方写成弱引用

@property(nonatomic,assign)id <zxdWriteRemarksViewControllerDelegate>delegate;
@end
