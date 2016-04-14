//
//  QRViewController.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import "ZFJQRResultVC.h"

#define M_QR_TOP 110
#define M_QR_WIGHT 240
#define M_QR_GAP (windowContentWidth - M_QR_WIGHT) / 2

static NSTimeInterval kQrLineanimateDuration = 0.02;

@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (assign, nonatomic) BOOL lifhtON;
@property (strong, nonatomic) UIImageView * qrIcon;
@property (assign, nonatomic) CGFloat qrIconLineY;

@end

@implementation QRViewController

- (id)initWithQRURL:(QRUrlBlock)qrURL{
    if (self = [super init]) {
        self.qrUrlBlock = qrURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input  = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code];
    self.output.rectOfInterest = CGRectMake(M_QR_TOP / windowContentHeight, M_QR_GAP / windowContentWidth, M_QR_WIGHT / windowContentHeight, M_QR_WIGHT / windowContentWidth);
    
    //[self.output setRectOfInterest:CGRectMake(110 / windowContentHeight, 40 / windowContentWidth , M_QR_WIGHT / windowContentHeight , M_QR_WIGHT / windowContentWidth];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity =AVLayerVideoGravityResize;
    self.preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    [self.session startRunning];
    
    
    
    
    self.qrIcon = [[UIImageView alloc] initWithFrame:CGRectMake(M_QR_GAP, M_QR_TOP, M_QR_WIGHT, 2)];
    //self.qrIcon.backgroundColor = [UIColor orangeColor];
    self.qrIcon.image = [UIImage imageNamed:@"qr_scan_line"];
    self.qrIcon.contentMode = UIViewContentModeScaleAspectFill;
    self.qrIconLineY = ViewY(self.qrIcon);
    [self.view addSubview:self.qrIcon];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:kQrLineanimateDuration target:self selector:@selector(show) userInfo:nil repeats:YES];
    [timer fire];
    /**/
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_QR_TOP)];
    topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:topView];
    
    UIButton *pop = [UIButton buttonWithType:UIButtonTypeCustom];
    pop.frame = CGRectMake(20, 30, 15.5, 26);
    [pop setBackgroundImage:[UIImage imageNamed:@"矩形-22-副本"] forState:UIControlStateNormal];
    [pop addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:pop];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    backBut.frame = CGRectMake(0, 30, 50, 30);
    [backBut addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBut];
    
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(topView), M_QR_GAP, M_QR_WIGHT)];
    leftView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:leftView];
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth - M_QR_GAP, ViewBelow(topView), M_QR_GAP, M_QR_WIGHT)];
    rightView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:rightView];
    
    
    UIView * belowView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(rightView), windowContentWidth, windowContentHeight - ViewBelow(rightView))];
    belowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [self.view addSubview:belowView];
    
    
    UIButton * lightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    lightBut.frame = CGRectMake(windowContentWidth / 2 - 40, 80, 80, 35);
    [lightBut setBackgroundImage:[UIImage imageNamed:@"common_scanner_light_off"] forState:UIControlStateNormal];
    [lightBut addTarget:self action:@selector(offOrOnLight:) forControlEvents:UIControlEventTouchUpInside];
    [belowView addSubview:lightBut];
    
    
    UILabel * noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(lightBut) + 20, windowContentWidth, 25)];
    noticeLabel.text = @"请将二维码对准扫描区域";
    noticeLabel.font = [UIFont systemFontOfSize:15];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.textColor = [UIColor whiteColor];
    [belowView addSubview:noticeLabel];
    
    
    
    UIView * leftTopOne = [[UIView alloc] initWithFrame:CGRectMake(M_QR_GAP - 12, ViewBelow(topView) - 12, 15, 1.5)];
    leftTopOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftTopOne];
    UIView * leftTopTwo = [[UIView alloc] initWithFrame:CGRectMake(M_QR_GAP - 12, ViewBelow(topView) - 12, 1.5, 15)];
    leftTopTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftTopTwo];
    
    UIView * rightTopOne = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth - M_QR_GAP - 3, ViewBelow(topView) - 12, 15, 1.5)];
    rightTopOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightTopOne];
    
    UIView * rightTopTwo = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth - M_QR_GAP + 12, ViewBelow(topView) - 12, 1.5, 15)];
    rightTopTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightTopTwo];
    
    
    
    UIView * leftBelowOne = [[UIView alloc] initWithFrame:CGRectMake(M_QR_GAP - 12, ViewY(belowView) - 3, 1.5, 15)];
    leftBelowOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftBelowOne];
    UIView * leftBelowTwo = [[UIView alloc] initWithFrame:CGRectMake(M_QR_GAP - 12, ViewY(belowView) + 12, 15, 1.5)];
    leftBelowTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftBelowTwo];
    
    UIView * rightBelowOne = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth - M_QR_GAP - 3, ViewY(belowView) + 12, 16, 1.5)];
    rightBelowOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightBelowOne];
    
    UIView * rightBelowTwo = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth - M_QR_GAP + 12, ViewY(belowView) - 3, 1.5, 16)];
    rightBelowTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightBelowTwo];
    
}
- (void)pop:(UIButton *)button {
    if ([self.device hasTorch] && [self.device hasFlash]){
        [self.device lockForConfiguration:nil];
        if (self.lifhtON) {
            [button setBackgroundImage:[UIImage imageNamed:@"common_scanner_light_off"] forState:UIControlStateNormal];
            
            [self.device setTorchMode:AVCaptureTorchModeOff];
            [self.device setFlashMode:AVCaptureFlashModeOff];
            self.lifhtON = NO;
        }
        [self.device unlockForConfiguration];
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)offOrOnLight:(UIButton *)button {
    
    if ([self.device hasTorch] && [self.device hasFlash]){
        
        [self.device lockForConfiguration:nil];
        if (!self.lifhtON) {
            [button setBackgroundImage:[UIImage imageNamed:@"common_scanner_light_on"] forState:UIControlStateNormal];
            
            [self.device setTorchMode:AVCaptureTorchModeOn];
            [self.device setFlashMode:AVCaptureFlashModeOn];
            self.lifhtON = YES;
        } else {
            [button setBackgroundImage:[UIImage imageNamed:@"common_scanner_light_off"] forState:UIControlStateNormal];
            
            [self.device setTorchMode:AVCaptureTorchModeOff];
            [self.device setFlashMode:AVCaptureFlashModeOff];
            self.lifhtON = NO;
        }
        [self.device unlockForConfiguration];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    NSLog(@"%@",stringValue);
    if (self.qrUrlBlock) {
        self.qrUrlBlock(stringValue);
    }
    
    [self pop:nil];
}

- (void)show {
    
    [UIView animateWithDuration:kQrLineanimateDuration animations:^{
        
        CGRect rect = self.qrIcon.frame;
        rect.origin.y = self.qrIconLineY;
        self.qrIcon.frame = rect;
        
    } completion:^(BOOL finished) {
        
        CGFloat maxBorder = M_QR_TOP + M_QR_WIGHT;
        if (self.qrIconLineY >= maxBorder) {
            
            self.qrIconLineY = M_QR_TOP;
        }
        self.qrIconLineY++;
    }];
}

@end
