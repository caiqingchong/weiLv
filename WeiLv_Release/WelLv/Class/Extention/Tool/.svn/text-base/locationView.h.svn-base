//
//  locationView.h
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXLocationManage.h"

typedef void (^location)(NSString *str);

@interface locationView : UIView<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_city;
    UITableView *_provinceTab;//省
    UITableView *_cityTab;//市
    UIView *_maskView;
    NSDictionary *_dict;
    NSIndexPath *_lastIndexPath;
    NSInteger _selectCell;
}
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)UILabel *city;
@property (nonatomic,strong)NSArray *provinceArray;
@property (nonatomic,strong)NSMutableArray *cityArray;
@property (nonatomic,strong)NSArray *selectArray;
@property (nonatomic, strong)location block;
@property (nonatomic, strong)UIButton * but;
@property (nonatomic, strong)UIImageView *locaImage;

@end
