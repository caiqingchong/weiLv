//
//  JYClocationViewController.m
//  WelLv
//
//  Created by lyx on 15/10/30.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYClocationViewController.h"
#import <CoreLocation/CoreLocation.h>
//#import "MyAnimatedAnnotationView.h"
#define PATH @"http://api.map.baidu.com/geocoder?output=json&location=%f,%f&key=dc40f705157725fc98f1fee6a15b6e60"
#import "ShopLocationModel.h"
#import "OpenShopViewController.h"
@interface JYClocationViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    BMKPointAnnotation* pointAnnotation;
    BMKPointAnnotation* animatedAnnotation;
    UILabel *driverName;
    UILabel *carName;
    UIButton *btn;
    UILabel *paopaoLabel;
    UITextField *botomField;
    CGFloat height;
    CGFloat latitude;
    CGFloat longitude;
    NSString *chuLatitude;
    NSString *chuLongitude;
    NSString *chuProv;
    NSString *chuCity;
    NSString *chuStr;
    
    
}
@property(nonatomic,copy)NSString *paopaoStr;
@end

@implementation JYClocationViewController
@synthesize arrayIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initMapView];
    [self addGes];
  
}
-(void)initMapView
{
    _locService = [[BMKLocationService alloc]init];
    
    [_locService startUserLocationService];
    //    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    //    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    //    _mapView.showsUserLocation = YES;//显示定位图层
    _geocodesearch=[[BMKGeoCodeSearch alloc]init];
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-40-64)];
    
    //自定义手势，再点击地图时，让textfield失去第一响应者
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 0;
    doubleTap.cancelsTouchesInView = NO;
    doubleTap.delaysTouchesEnded = NO;
    
    [_mapView addGestureRecognizer:doubleTap];
    
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    singleTap.delaysTouchesEnded = NO;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    //[self.view addGestureRecognizer:singleTap];
    [_mapView addGestureRecognizer:singleTap];
    //[_mapView setZoomLevel:11];
    [self.view addSubview:_mapView];
   
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    btn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-60, 84,47, 47)];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"定位btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
     [[[UIApplication sharedApplication] keyWindow] addSubview:btn];
    botomField=[[UITextField alloc]initWithFrame:CGRectMake(0, windowContentHeight-40-64,windowContentWidth, 40)];
    //[botomField becomeFirstResponder];
    botomField.backgroundColor=[UIColor whiteColor];
    botomField.placeholder=@"请输入您的店铺地址";
    botomField.delegate=self;
    //botomField.tag=101;
    [self.view addSubview:botomField];
    paopaoLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,300, 60)];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)rightBtn
{
    if (!botomField.text) {
        chuStr=paopaoLabel.text;
    }
    chuStr=botomField.text;
    ShopLocationModel *model=[[ShopLocationModel alloc]init];
    model.latitude=chuLatitude;
    model.longitude=chuLongitude;
    model.province=chuProv;
    model.city=chuCity;
    model.shopDir=chuStr;
    
    NSDictionary *dic = @{@"type":@"3",@"index":[NSString stringWithFormat:@"%ld",(long)self.arrayIndex],@"text":model};
    NSNotification *notification =[NSNotification notificationWithName:@"ZXDTongzhi" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)btnClick
{
    _mapView.region=BMKCoordinateRegionMake(CLLocationCoordinate2DMake(latitude, longitude), BMKCoordinateSpanMake(0.01, 0.01));
    CLLocationCoordinate2D coor;
    coor.latitude = latitude;
    coor.longitude = longitude;
    pointAnnotation.coordinate = coor;
       // NSLog(@"%f",reverseGeocodeSearchOption.reverseGeoPoint.latitude);
    
    [self geoCodeWith:coor];
    
}

-(void)geoCodeWith:(CLLocationCoordinate2D)coor
{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pointAnnotation.coordinate;

    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }

}
-(void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect]; //调整放置有textView的view的位置
    //设置动画
    

    height=keyboardRect.size.height;
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
    [UIView setAnimationDuration:0.2];
    //设置view的frame，往上平移
    
    
    [botomField setFrame:CGRectMake(0, windowContentHeight-height-64-40, windowContentWidth, 40)];

    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
   
   
    [botomField setFrame:CGRectMake(0,windowContentHeight-40-64, windowContentWidth, 40)];
    
    //[self.view addSubview:botomField];
    [UIView commitAnimations];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    
   // [field resignFirstResponder];
    [botomField resignFirstResponder];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
   // [field resignFirstResponder];
    [botomField resignFirstResponder];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
   // botomField.hidden=NO;
//    if (textField.tag==101) {
//     a=YES;
    [UIView animateWithDuration:0.2 animations:^{
        
    [botomField setFrame:CGRectMake(0, windowContentHeight-height-64-40, windowContentWidth, 40)];
    }];
        
 
}
-(void)addGes
{
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.delegate = self;
    _locService.delegate=self;
    _geocodesearch.delegate = self;
   // [self addPointAnnotation];
  

    
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    [btn removeFromSuperview];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
  
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
     //  paopaoLabel.text=self.paopaoStr;
    if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            annotationView.image=[UIImage imageNamed:[NSString stringWithFormat:@"标点"]];
        
           // 从天上掉下效果
            //annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = YES;
            
        
           
            UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,300, 60)];
            UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"输入地址框"]];
            [image setAlpha:0.5];
            image.frame = CGRectMake(0, 0, 300, 60);
            [popView addSubview:image];
            //paopaoView.text=[NSString stringWithFormat:@"%f",latitude];
            paopaoLabel.textColor=[UIColor blackColor];
            [popView addSubview:paopaoLabel];
            BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
            pView.frame = CGRectMake(0, 0, 300, 60);
            // annotationView.paopaoView = nil;
            annotationView.calloutOffset=CGPointMake(0, 0);
            annotationView.selected=YES;
            annotationView.paopaoView = pView;
           
            
            
        }
        return annotationView;
    }


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (!userLocation.updating) {
        [_locService stopUserLocationService];
    }
    latitude=userLocation.location.coordinate.latitude;
    longitude=userLocation.location.coordinate.longitude;
    chuLatitude=[NSString stringWithFormat:@"%f",latitude];
    chuLongitude=[NSString stringWithFormat:@"%f",longitude];
    CLLocationCoordinate2D coor;
    if (pointAnnotation == nil) {
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        
        coor.latitude = latitude;
        coor.longitude = longitude;
        pointAnnotation.coordinate = coor;
        
    }
    
    [_mapView addAnnotation:pointAnnotation];
     _mapView.region=BMKCoordinateRegionMake(CLLocationCoordinate2DMake(latitude, longitude), BMKCoordinateSpanMake(0.01, 0.01));
    [self geoCodeWith:pointAnnotation.coordinate];
}
// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    
    botomField.text=paopaoLabel.text;
   
    
}
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState fromOldState:(BMKAnnotationViewDragState)oldState

{
    
    switch (newState) {
            
        case BMKAnnotationViewDragStateStarting: {
            
            NSLog(@"拿起");
            
            return;
            
        }
            
        case BMKAnnotationViewDragStateDragging: {
            
            NSLog(@"开始拖拽");
            
            return;
            
        }
            
        case BMKAnnotationViewDragStateEnding: {
            
            NSLog(@"放下,并将大头针");
            
            CLLocationCoordinate2D destCoordinate=view.annotation.coordinate;
            view.selected=YES;
            chuLatitude=[NSString stringWithFormat:@"%f",destCoordinate.latitude];
            chuLongitude=[NSString stringWithFormat:@"%f",destCoordinate.longitude];

            pointAnnotation.coordinate=destCoordinate;
           // paopaoLabel.text=[NSString stringWithFormat:@"%f",destCoordinate.latitude];
            NSLog(@"12--%f",destCoordinate.latitude);
          
           _mapView.region=BMKCoordinateRegionMake(CLLocationCoordinate2DMake(destCoordinate.latitude, destCoordinate.longitude), BMKCoordinateSpanMake(0.01, 0.01));
            
            [self geoCodeWith:destCoordinate];
            

            return;
            
        }
            
        default:
            
            return;
            
    }
    
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    
    
    if (error == 0) {
    paopaoLabel.text = result.address;
     
        BMKAddressComponent *mo=result.addressDetail;
        chuProv=mo.province;
        chuCity=mo.city;
        
        NSLog(@"%@---%@+++%@",paopaoLabel.text,result.addressDetail,result.addressDetail);
       
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
