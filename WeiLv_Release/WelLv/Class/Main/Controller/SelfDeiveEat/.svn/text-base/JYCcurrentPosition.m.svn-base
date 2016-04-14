//
//  JYCcurrentPosition.m
//  WelLv
//
//  Created by lyx on 15/11/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCcurrentPosition.h"

@interface JYCcurrentPosition ()
{
    UIButton *backBtn;
}
@end

@implementation JYCcurrentPosition

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationItem.title=@"";
    self.navigationController.navigationBarHidden=YES;
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
    
  
}
-(void)btnClick:(UIButton *)btn
{
    backBtn.hidden=YES;
   // moreBtn.hidden=YES;
    //locationBtn.hidden=YES;
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.delegate = self;
   // _locService.delegate = self;
    
     [self addPointAnnotation];
    
    backBtn.hidden = NO;
   // moreBtn.hidden = NO;
    //locationBtn.hidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    //_locService.delegate = nil;
    
    
}
-(void)addPointAnnotation
{
    CLLocationCoordinate2D coor;
    coor.latitude=self.latitude;
    coor.longitude=self.longitude;
    NSLog(@"%f---%f",coor.latitude,coor.longitude);
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate=coor;
     _mapView.region=BMKCoordinateRegionMake(CLLocationCoordinate2DMake(coor.latitude, coor.longitude), BMKCoordinateSpanMake(0.01, 0.01));
    [_mapView addAnnotation:annotation];
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
        
        
        
//        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,300, 60)];
//        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"输入地址框"]];
//        [image setAlpha:0.5];
//        image.frame = CGRectMake(0, 0, 300, 60);
//        [popView addSubview:image];
//        //paopaoView.text=[NSString stringWithFormat:@"%f",latitude];
//        paopaoLabel.textColor=[UIColor blackColor];
//        [popView addSubview:paopaoLabel];
//        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
//        pView.frame = CGRectMake(0, 0, 300, 60);
//        // annotationView.paopaoView = nil;
//        annotationView.calloutOffset=CGPointMake(0, 0);
//        annotationView.selected=YES;
//        annotationView.paopaoView = pView;
        
        
        
    }
    return annotationView;
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
