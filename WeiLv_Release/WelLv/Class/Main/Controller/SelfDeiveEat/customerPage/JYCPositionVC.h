//
//  JYCPositionVC.h
//  WelLv
//
//  Created by lyx on 15/11/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^popBlock)(NSString *str);
@interface JYCPositionVC : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService* _locService;
}
@property(nonatomic,strong)NSMutableArray *annotationArr;
@property(nonatomic,strong)popBlock Popblock;
@end
