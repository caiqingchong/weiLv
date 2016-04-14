//
//  ZongheVc.m
//  Lvyou
//
//  Created by 赵冉 on 16/1/13.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import "ZongheVc.h"
#define myWindow ([UIApplication sharedApplication].keyWindow)
#define windowContent  ([[UIScreen mainScreen] bounds])
#define windowContentHeight  ([[UIScreen mainScreen] bounds].size.height)
#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)
#define NavHeight (self.navigationController.navigationBar.frame.size.height+20)

@implementation ZongheVc
#pragma mark-- 初始化
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0,windowContentWidth, windowContentHeight);
        
        self.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    }
    static int Height = 274/2;
    switch ((int)windowContentHeight) {
        case 667:
            Height = 321/2;
            
            break;
        case 736:
            Height = 532/2;
            
            break;
        default:
            break;
    }
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight - windowContentHeight / 2.8 -64, windowContentWidth, windowContentHeight / 2.8)];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    // 給当前父视图添加手势
    UITapGestureRecognizer *tapGeRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHide:)];
    tapGeRecognizer.cancelsTouchesInView=NO;
    [self addGestureRecognizer:tapGeRecognizer];
    
    
    
    //创建试图内容
    [self createVc];
    return self;
}
- (void)createVc{
    static int Height = 274 / 2;
    static int hei = 66 / 2;
    static int width = 28 /2 ;
    NSArray *   array = @[@"推荐",@"价格从低到高",@"价格从高到低"];
    
    
    Height = windowContentHeight / 2.8;
    hei = windowContentHeight / 11.3;
    width = windowContentWidth / 15.9;
    
    
    //    UIButton * topbuton = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, windowContentWidth - width, Height - 3 * hei)];
    _button = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, windowContentWidth - width, Height - 3 * hei)];
    [_button setTitle:@"热销" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:windowContentWidth / 25];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    _button.tag = 999 ;
    _imgeVcone = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth - hei* 0.5 - 22,hei / 2.3, windowContentWidth / 22.85, windowContentHeight / 56.8)];
    //_imgeVcone.backgroundColor = [UIColor redColor];
    
    [_button addTarget:self action:@selector(OnbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button addSubview:_imgeVcone];
    [_backgroundView addSubview:_button];
    
    
    for (int i =0; i < 3; i ++) {
        UILabel * line = [[UILabel alloc]init];
        line.frame = CGRectMake(0,  Height - 3 * hei + hei * i, windowContentWidth  , 0.1);
        line.backgroundColor = [UIColor blackColor];
        [_backgroundView addSubview:line];
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(width,  Height - 3 * hei + hei * i, windowContentWidth - width , hei  )];
        
        
        [_button setTitle:array[i] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:windowContentWidth / 25];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        if (i == 0) {
            _imgeVctwo = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth - hei * 0.5 - 22,  hei/2.3 , windowContentWidth / 22.85 , windowContentHeight / 56.8)];
            //_imgeVctwo.backgroundColor = [UIColor redColor];
            [_button addSubview:_imgeVctwo];
            
        }else if (i == 1){
            
            //_imgeVcthree.backgroundColor = [UIColor redColor];
            _imgeVcthree = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth - hei * 0.5 - 22, hei/2.3 , windowContentWidth / 22.85 , windowContentHeight / 56.8)];
            [_button addSubview:_imgeVcthree];
            
            
        }else if (i==2){
            _imgeVcfour = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth - hei * 0.5- 22,  hei/2.3 , windowContentWidth / 22.85 , windowContentHeight / 56.8)];
            //_imgeVcfour.backgroundColor = [UIColor redColor];
            [_button addSubview:_imgeVcfour];
            
            
        }
        _button.tag = 1000 + i;
        
        
        [_button addTarget:self action:@selector(OnbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:_button];
        
        
    }
    
    // 创建四个选中按钮
    // UIButton * buttontwo = (UIButton *)[self.backgroundView ]
    // _imgeVctwo = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth - hei - 22,  0, hei , hei)];
    
    // _imgeVcthree = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth - hei - 22,  0, hei , hei)];
    // _imgeVcfour = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth - hei - 22,  0, hei , hei)];
    //[_button addSubview:_imgeVctwo];
    //[_button addSubview:_imgeVcthree];
    //[_button addSubview:_imgeVcfour];
    
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"line"] isEqualToString:@"1"]) {
        [_imgeVcone setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
    }else if ([[defaults objectForKey:@"line"] isEqualToString:@"2"]){
        [_imgeVctwo setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
        
        
    }else if ([[defaults objectForKey:@"line"] isEqualToString:@"3"]){
        [_imgeVcthree setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
    }else if ([[defaults objectForKey:@"line"] isEqualToString:@"4"]){
        [_imgeVcfour setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
        
    }
    if ([_arrm[0] intValue] == 1) {
        [_imgeVcone setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
    }else if ([_arrm[0] intValue] == 2){
        [_imgeVctwo setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
        
        
    }else if ([_arrm[0] intValue] == 3){
        [_imgeVcthree setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
    }else if ([_arrm[0] intValue] == 4){
        [_imgeVcfour setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
        
    }
    
    
}
- (void)OnbuttonClick:(UIButton *)button{
    
    _arrm = [NSMutableArray array];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if (999 == button.tag ) {
        _str = @"hot";
        
        [defaults setObject:@"1" forKey:@"line"];
        // [_arrm addObject:@"1"];
        self.hidden = true;
        NSLog(@"1111%@",_arrm);
        [self.delegate Returnstr:_str];
        
    }else if (1000 == button.tag){
        _str = @"default";
        [defaults setObject:@"2" forKey:@"line"];
        // [_arrm addObject:@"2"];
        self.hidden = true;
        [self.delegate Returnstr:_str];
    }else if (1001 == button.tag){
        
        _str = @"price_l";
        [defaults setObject:@"3" forKey:@"line"];
        //[_arrm addObject:@"3"];
        self.hidden = true;
        [self.delegate Returnstr:_str];
        
    }else if(1002 == button.tag){
        
        _str = @"price_h";
        [defaults setObject:@"4" forKey:@"line"];
        // [_arrm addObject:@"4"];
        self.hidden = true;
        [self.delegate Returnstr:_str];
        
    }
}
#pragma mark - 隐藏父视图层
-(void)viewHide:(UITapGestureRecognizer*)tap{
    if(self.hidden == NO){
        self.hidden = YES;
        self.backgroundView.hidden = YES;
    }
}

@end
