//
//  JYCRouteVC.h
//  WelLv
//
//  Created by lyx on 15/11/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriveModel.h"
@interface JYCRouteVC : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKRouteSearchDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService* _locService;
    BMKRouteSearch* _routesearch;
}
@property(nonatomic,assign)CGFloat lati;
@property(nonatomic,assign)CGFloat longti;
@property(nonatomic,strong)DriveModel *model;
@end
