//
//  MineViewController.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CusInfoViewController.h"
#import "ChangePasswordViewController.h"
#import "settingViewController.h"
#import "helpCenterController.h"
#import "payRequsestHandler.h"
#import "GTMBase64.h"
#import "GuanJiaSelfInfoViewController.h"
#import "WLMyHehuoView.h"
//#import "NewGJTViewController.h" //会员没有绑定管家的时候

@interface MineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *_bgView;
    UIImageView *_phoneImageView;
    UITableView *_tableView;
    NSDictionary *_dic;
    UILabel *_realName;        //用户名字
    
}
@end


@interface setCell : UITableViewCell

{
    UIImageView *_leftImageVIew;
    UILabel *_nameLabel;
}
@property (nonatomic,strong) UIImageView *leftImageVIew;
@property (nonatomic,strong) UILabel *nameLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isJump:(BOOL)isShow;
@end