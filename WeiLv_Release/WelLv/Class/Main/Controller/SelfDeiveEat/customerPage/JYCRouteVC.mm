//
//  JYCRouteVC.m
//  WelLv
//
//  Created by lyx on 15/11/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCRouteVC.h"
#import "UIImage+Rotate.h"
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end




@interface JYCRouteVC ()
{
    BMKPointAnnotation* pointAnnotation;
    UIButton * backBtn;
    UIButton * moreBtn;
    UIButton * locationBtn;
    CGFloat latitude;
    CGFloat longitude;
    UILabel *topLabel;
    UILabel *botomLabel;
    UIButton *timeBtn;
    UIButton *distanceBtn;
    BMKPinAnnotationView *annotationView;
    BOOL up;
    UIButton *UpBtn;
    UILabel *orangeLabel;
    UIView *botomView;
    UILabel *distanceLabel;
    UILabel *timeLabel;
}
@property(nonatomic,copy)NSString *botomStr;
@property(nonatomic,assign)BOOL time;//路线类型
@end

@implementation JYCRouteVC

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.title=@"";
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    [self initMapView];
}
-(void)initMapView
{
   
    
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    [self.view addSubview:_mapView];
    backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 30,47, 47)];
    backBtn.tag=101;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backBtn];
    locationBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-47, 30,47, 47)];
    locationBtn.tag=102;
    [locationBtn setBackgroundImage:[UIImage imageNamed:@"回到定位点"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[[UIApplication sharedApplication] keyWindow] addSubview:locationBtn];
    
    _routesearch = [[BMKRouteSearch alloc]init];
    _locService = [[BMKLocationService alloc]init];
    
    [_locService startUserLocationService];
    
    [self addBotomView];
   
    

}
-(void)addBotomView
{
    botomView=[[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight-80, windowContentWidth, 80)];
    botomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:botomView];
    
    
    timeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth/2, 40)];
    [timeBtn setTitle:@"距离最近" forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [timeBtn setBackgroundColor:[UIColor whiteColor]];
    timeBtn.tag=103;
    [botomView addSubview:timeBtn];
    
    
    distanceBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, 40)];
    [distanceBtn setTitle:@"时间最短" forState:UIControlStateNormal];
    [distanceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    distanceBtn.tag=104;
    [distanceBtn setBackgroundColor:[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1]];
    [distanceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [botomView addSubview:distanceBtn];
    
    distanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, 82, 20)];
    distanceLabel.textColor=[UIColor grayColor];
    distanceLabel.font=systemFont(15);
    [botomView addSubview:distanceLabel];
    
    timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 50, 100, 20)];
    //timeLabel.text=@"120分钟";
    timeLabel.textColor=[UIColor grayColor];
    timeLabel.font=systemFont(15);
    [botomView addSubview:timeLabel];
    
    UpBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-12, 55, 12, 10)];
    [UpBtn setBackgroundImage:up?[UIImage imageNamed:@"矩形-36-副本"]:[UIImage imageNamed:@"矩形-36"] forState:UIControlStateNormal];
    [UpBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
   // UpBtn.tag=105;
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-12-30, 40, 52, 40)];
    [but addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    but.tag=105;
    [botomView addSubview:UpBtn];
    [botomView addSubview:but];
    orangeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, windowContentWidth, 80)];
    orangeLabel.backgroundColor=[UIColor orangeColor];
    orangeLabel.textColor=[UIColor whiteColor];
    orangeLabel.font=systemFont(15);
    
}

-(void)btnClick:(UIButton *)button
{
   
    if (button.tag==101) {
        backBtn.hidden=YES;
        locationBtn.hidden=YES;
         [self.navigationController popViewControllerAnimated:YES];
        
    }else if(button.tag==102)
    {
      //  [_mapView addAnnotation:pointAnnotation];
        
        _mapView.region=BMKCoordinateRegionMake(CLLocationCoordinate2DMake(latitude, longitude), BMKCoordinateSpanMake(0.01, 0.01));
    }else if(button.tag==103)
    {
        self.time = NO;
        
        _routesearch = [[BMKRouteSearch alloc]init];
        _routesearch.delegate=self;
        [self onClickDriveSearch];
        
        _routesearch = [[BMKRouteSearch alloc]init];
        [distanceBtn setBackgroundColor:[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1]];
        [timeBtn setBackgroundColor:[UIColor whiteColor]];
        
    }else if(button.tag==104)
    {
        
        self.time=YES;
        
        _routesearch = [[BMKRouteSearch alloc]init];
        _routesearch.delegate=self;
        [self onClickDriveSearch];
        
        [distanceBtn setBackgroundColor:[UIColor whiteColor]];
        [timeBtn setBackgroundColor:[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1]];
        
    }else if(button.tag==105)
    {
       up=!up;
        [UpBtn setBackgroundImage:up?[UIImage imageNamed:@"矩形-36-副本"]:[UIImage imageNamed:@"矩形-36"] forState:UIControlStateNormal];
        if (up==NO) {
            [botomView setFrame:CGRectMake(0, windowContentHeight-80, windowContentWidth, 80)];
            orangeLabel.hidden=YES;
        }else if(up==YES)
        [botomView setFrame:CGRectMake(0, windowContentHeight-160, windowContentWidth, 160)];
        [botomView addSubview:orangeLabel];
        orangeLabel.hidden=NO;
        orangeLabel.text=self.model.shop_dir;
    }else if(button.tag==106)
    {
        NSString *str=self.model.main_phone;
        NSString * telString = [NSString stringWithFormat:@"tel:%@", str];
        NSURL * telUrl = [NSURL URLWithString:telString];
        [[UIApplication sharedApplication] openURL:telUrl];
 
    }else if(button.tag==107)
    {
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.delegate = self;
    _locService.delegate=self;
     _routesearch.delegate = self;
    backBtn.hidden=NO;
    locationBtn.hidden=NO;
  }

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _routesearch.delegate = nil;
   
    
}
- (void)dealloc {
    
    if (_routesearch != nil) {
        _routesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
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
    [self onClickDriveSearch];
}
-(void)onClickDriveSearch
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    CLLocationCoordinate2D coor1;
    coor1.latitude=latitude;
    coor1.longitude=longitude;
    start.pt=coor1;
    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    CLLocationCoordinate2D coor2;
    coor2.latitude=self.lati;
    coor2.longitude=self.longti;
    end.pt=coor2;
    
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
    
}

#pragma mark -自定义泡泡
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            //if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
                
                UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,300, 80)];
                
                UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"输入地址框"]];
                [image setAlpha:0.5];
                image.frame = CGRectMake(0, 0, 300, 80);
                [popView addSubview:image];
                
                UIButton *telBtn=[[UIButton alloc]initWithFrame:CGRectMake(270, 0, 30,33.5)];
                [telBtn setBackgroundImage:[UIImage imageNamed:@"服务电话"] forState:UIControlStateNormal];
                [telBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                telBtn.tag=106;
                telBtn.backgroundColor=[UIColor whiteColor];
                [popView addSubview:telBtn];
                
                UIButton *weixinBtn=[[UIButton alloc]initWithFrame:CGRectMake(270, 33.5, 30,33.5)];
                [weixinBtn setBackgroundImage:[UIImage imageNamed:@"微信地图"] forState:UIControlStateNormal];
                weixinBtn.tag=107;
                [weixinBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                weixinBtn.backgroundColor=[UIColor whiteColor];
                [popView addSubview:weixinBtn];
                
                UILabel *topLeftLabel=[[UILabel alloc]initWithFrame:CGRectMake(170, 10, 75, 20)];
                topLeftLabel.font=systemFont(18);
                topLeftLabel.text=[NSString stringWithFormat:@"%0.1f公里",[self.model.distance floatValue]/1000];
                topLeftLabel.textColor=[UIColor whiteColor];
                [popView addSubview:topLeftLabel];
                
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(153, 11, 12, 14)];
                imageView.image=[UIImage imageNamed:@"location黑色"];
                [popView addSubview:imageView];
                
                topLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
                topLabel.font=systemFont(15);
                topLabel.text=[NSString stringWithFormat:@"%@",self.model.partner_shop_name];
                topLabel.textColor=[UIColor whiteColor];
                [popView addSubview:topLabel];
                
                botomLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, ViewBelow(topLabel)+5, 250, 15)];
                botomLabel.font=systemFont(10);
                botomLabel.textColor=[UIColor whiteColor];
                botomLabel.text=[NSString stringWithFormat:@"%@",self.model.shop_dir];
                [popView addSubview:botomLabel];
                
                BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
                pView.frame = CGRectMake(0, 0, 300, 80);
                
                //annotationView.calloutOffset=CGPointMake(0, 0);
                
                view.paopaoView=pView;
            //}
            
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark -驾车返回结果
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    

    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    BMKDrivingRouteLine *plan;
    
    if (error == BMK_SEARCH_NO_ERROR) {
        if (result.routes.count==1) {
           plan= (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
           
        }else if(result.routes.count>=2){
        
        if (self.time==NO) {
          plan= (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        }else{
          plan= (BMKDrivingRouteLine*)[result.routes objectAtIndex:1];
        }
        
        }
        distanceLabel.text=[NSString stringWithFormat:@"约%0.1f公里",plan.distance/1000.0];
        float a=plan.duration.hours*60+plan.duration.minutes+plan.duration.seconds/60.0;
        timeLabel.text=[NSString stringWithFormat:@"约%0.1f分钟",a];
        // 计算路线方案中的路段数目
        
        int size =(int)[plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints =new BMKMapPoint[planPointCounts];;
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
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
