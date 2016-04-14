//
//  JYCPositionVC.m
//  WelLv
//
//  Created by lyx on 15/11/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCPositionVC.h"
#import <CoreLocation/CoreLocation.h>
#import "DriveModel.h"
#import "JYCSelfDriveEatViewController.h"
#import "JYCRouteVC.h"
#import "DriveModel.h"
@interface JYCPositionVC ()
{
    BMKPointAnnotation* pointAnnotation;
    UIButton * backBtn;
    UIButton * moreBtn;
    UIButton * locationBtn;
    CGFloat latitude;
    CGFloat longitude;
    UILabel *topLabel;
    UILabel *botomLabel;
    UIButton *routeBtn;
    BMKPinAnnotationView *annotationView;
    
    
}
@property(nonatomic,strong)NSMutableArray *annotaArrs;
@end

@implementation JYCPositionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationItem.title=@"";
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    _annotaArrs=[[NSMutableArray alloc]init];
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    [self initMapView];
   // NSLog(@"%lu",self.annotationArr.count);
    
}

-(void)initMapView
{
    _locService = [[BMKLocationService alloc]init];
    
    [_locService startUserLocationService];
    
    [self.view addSubview:_mapView];
    backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 30,47, 47)];
    backBtn.tag=101;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backBtn];
    moreBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-47, 30,47, 47)];
    moreBtn.tag=102;
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"列表"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[[UIApplication sharedApplication] keyWindow] addSubview:moreBtn];
    locationBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-47, ViewBelow(moreBtn)+10,47, 47)];
    locationBtn.tag=103;
    [locationBtn setBackgroundImage:[UIImage imageNamed:@"回到定位点"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[[UIApplication sharedApplication] keyWindow] addSubview:locationBtn];
    
   // [self addAnnotations];
   
}
-(void)addAnnotations
{
    
    for (int i=0; i<self.annotationArr.count; i++) {
        DriveModel *model=[[DriveModel alloc]init];
        model=self.annotationArr[i];
       
        
        CLLocationCoordinate2D coor;
        coor.latitude=[model.latitude floatValue];
        coor.longitude=[model.longitude floatValue];
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate=coor;
        [self.annotaArrs addObject:annotation];
    }

    
    [_mapView addAnnotations:self.annotaArrs];
    [_mapView showAnnotations:self.annotaArrs animated:YES];
    [_mapView setZoomLevel:11];
   
}
-(void)btnClick:(UIButton *)button
{
    if (button.tag==101) {
        backBtn.hidden=YES;
        moreBtn.hidden=YES;
        locationBtn.hidden=YES;
        self.navigationController.navigationBarHidden=NO;
        [self.navigationController popViewControllerAnimated:YES];
    }else if(button.tag==102)
    {
        backBtn.hidden=YES;
        moreBtn.hidden=YES;
        locationBtn.hidden=YES;
        //JYCSelfDriveEatViewController *Dvc=[[JYCSelfDriveEatViewController alloc]init];
        //Dvc.type=@"2";
        self.Popblock(@"2");
        self.navigationController.navigationBarHidden=NO;
        [self.navigationController popViewControllerAnimated:YES];
    }else if(button.tag==103)
    {
        
       [_mapView removeAnnotations:self.annotaArrs];
        [self.annotaArrs removeAllObjects];
       [self.annotaArrs addObject:pointAnnotation];
         [_mapView showAnnotations:self.annotaArrs animated:YES];
        [_mapView addAnnotations:self.annotaArrs];
        _mapView.region=BMKCoordinateRegionMake(CLLocationCoordinate2DMake(latitude, longitude), BMKCoordinateSpanMake(0.01, 0.01));
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.delegate = self;
    _locService.delegate = self;
 
    // [self addPointAnnotation];
    
    backBtn.hidden = NO;
    moreBtn.hidden = NO;
    locationBtn.hidden = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    
   
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (!userLocation.updating) {
        [_locService stopUserLocationService];
    }
    latitude=userLocation.location.coordinate.latitude;
    longitude=userLocation.location.coordinate.longitude;
    CLLocationCoordinate2D coor;
    if (pointAnnotation == nil) {
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        
        coor.latitude = latitude;
        coor.longitude = longitude;
        pointAnnotation.coordinate = coor;
        
       
    
        
    }
   // NSLog(@"%f++++%f",latitude,longitude);
    [self addAnnotations];
    //34.770693
    //113.729124
   
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    NSString *AnnotationViewID = @"renameMark";
    annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    //  paopaoLabel.text=self.paopaoStr;
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        //annotationView.pinColor = BMKPinAnnotationColorPurple;
        annotationView.image=[UIImage imageNamed:[NSString stringWithFormat:@"标点2"]];
        annotationView.canShowCallout=YES;
        // 从天上掉下效果
        //annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,300, 80)];
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"输入地址框"]];
        [image setAlpha:0.5];
        image.frame = CGRectMake(0, 0, 300, 80);
        [popView addSubview:image];
        routeBtn=[[UIButton alloc]initWithFrame:CGRectMake(250, 0, 50, 67)];
        NSString *rateString = @"查看\n路线";
        [routeBtn setTitle:rateString forState:UIControlStateNormal];
        routeBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [routeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [routeBtn addTarget:self action:@selector(routeClick:) forControlEvents:UIControlEventTouchUpInside];
        [routeBtn setBackgroundColor:[UIColor whiteColor]];
        [popView addSubview:routeBtn];
        topLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 20)];
        topLabel.font=systemFont(15);
        
        topLabel.textColor=[UIColor whiteColor];
        [popView addSubview:topLabel];
        botomLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, ViewBelow(topLabel)+5, 250, 15)];
        botomLabel.font=systemFont(10);
        botomLabel.textColor=[UIColor whiteColor];
        
        [popView addSubview:botomLabel];

        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
        pView.frame = CGRectMake(0, 0, 300, 80);
       
        annotationView.calloutOffset=CGPointMake(0, 0);
       
        annotationView.paopaoView = pView;
        
    
        
    }
    return annotationView;
}
-(void)routeClick:(UIButton *)button
{
     BMKPointAnnotation* annotation;
     annotation=self.annotaArrs[button.tag-101];
    
    DriveModel *model=[[DriveModel alloc]init];
    model=self.annotationArr[button.tag-101];
    
    JYCRouteVC *vc=[[JYCRouteVC alloc]init];
    vc.lati=annotation.coordinate.latitude;
    vc.longti=annotation.coordinate.longitude;
    vc.model=model;
    
    backBtn.hidden=YES;
    moreBtn.hidden=YES;
    locationBtn.hidden=YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.navigationBarHidden=YES;
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
   
    for (BMKPinAnnotationView *mkaview in views)
        
    {
       
        if (mkaview.annotation.coordinate.latitude==pointAnnotation.coordinate.latitude&&mkaview.annotation.coordinate.longitude==pointAnnotation.coordinate.longitude) {
           annotationView.canShowCallout=NO;
            annotationView.image=[UIImage imageNamed:[NSString stringWithFormat:@"标点"]];
        }

        
        BMKPointAnnotation* annotation;
        // 当前位置 的大头针设为紫色，并且没有右边的附属按钮
        for (int i=0; i<self.annotaArrs.count; i++) {
            //DriveModel *moele=[[DriveModel alloc]init];
            //moele=self.annotationArr[i];
            annotation=self.annotaArrs[i];
            DriveModel *model=[[DriveModel alloc]init];
            model=self.annotationArr[i];
            
            if (mkaview.annotation.coordinate.latitude == annotation.coordinate.latitude&&mkaview.annotation.coordinate.longitude==annotation.coordinate.longitude){
                topLabel.text=[NSString stringWithFormat:@"%@",model.partner_shop_name];
                botomLabel.text=[NSString stringWithFormat:@"%@",model.shop_dir];
                routeBtn.tag=101+i;
                continue;
            }
               
          
        }
    }
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
