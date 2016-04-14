//
//  HotelStarPriceControl.m
//  CreateControl
//
//  Created by James on 15/11/20.
//  Copyright © 2015年 James. All rights reserved.
//

#import "HotelStarPriceControl.h"

@implementation HotelStarPriceControl

#pragma  mark - 初始化
-(instancetype) init{
    if (self = [super init]) {
        //设置当前视图尺寸大小
        self.frame=CGRectMake(0, 0,windowContentWidth,windowContentHeight);
        //设置当前视图背景颜色
        self.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
        
        switch ((int)windowContentHeight) {
            case 480:
                //设置背景视图大小-3.5吋
                self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0,windowContentHeight/2-124, windowContentWidth, windowContentHeight/2+60)];
                break;
            case 568:
                //设置背景视图大小->4吋
                self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0,windowContentHeight/2-84, windowContentWidth, windowContentHeight/2+20)];
                break;
            case 667:
                //设置背景视图大小->4.7存
                self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0,windowContentHeight/2-34, windowContentWidth, windowContentHeight/2)];
                break;
            case 736:
                //设置背景视图大小->5.5存
                self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0,windowContentHeight/2, windowContentWidth, windowContentHeight/2)];
                break;
            default:
                break;
        }
        
     
        
        
        //设置背景视图背景色
        self.backgroundView.backgroundColor=[UIColor whiteColor];
        
        
        //设置“星级（可多选）”按钮边框颜色
        self.borderColor=[UIColor orangeColor];
        //创建自定义视图
        [self customView];
        //初始化数据字典
        self.selectDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"不限",@"0",nil];
        //初始化价格区间值数据字典
          self.priceDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"26.5",@"150",@"80",@"300",@"134",@"450",@"188",@"700",@"242",@"不限",@"295.5", nil];
        switch ((int)windowContentHeight) {
            case 480:
                //价格区间值数据字典->3.5吋
                break;
            case 568:
                 //价格区间值数据字典->4吋
                break;
            case 667:
                 //价格区间值数据字典->4.7存
                self.priceDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"26.5",@"150",@"91",@"300",@"156",@"450",@"221",@"700",@"286",@"不限",@"350.5", nil];
                break;
            case 736:
                 //价格区间值数据字典->5.5吋
                self.priceDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"26.5",@"150",@"99",@"300",@"172",@"450",@"244",@"700",@"317",@"不限",@"389.5", nil];
                break;
            default:
                break;
        }

        
      
        
        
        
    self.tempPriceDict=@{@"0":@"0.0",@"150":@"0.2",@"300":@"0.4",@"450":@"0.6",@"700":@"0.8",@"不限":@"1.0"};
        
        self.lowerValue=@"";
        self.upperValue=@"";
        
        //初始化“星级（可多选）”遍历字符串
        self.starString=@"";
        self.starValue=@"星级不限";
        self.priceValue=@"价格不限";
        //給当前父视图添加手势
        UITapGestureRecognizer *tapGeRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHide:)];
        tapGeRecognizer.cancelsTouchesInView=NO;
        [self addGestureRecognizer:tapGeRecognizer];
        //给当前子视图添加手势
        UITapGestureRecognizer *subTapGecognize=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subViewHide:)];
        subTapGecognize.cancelsTouchesInView=NO;
        [self.backgroundView addGestureRecognizer:subTapGecognize];
    }
    
    return self;
}

#pragma mark - 回传 “值”默认选中
-(void)initWithValue:(NSString *)value{
    if (![value isEqualToString:@""]) {
        //创建一个数组，分割传送过来的值
        NSArray *array=[value componentsSeparatedByString:@","];
        //“星级（可多线）”按钮赋值
        [self initStar:array];
        //“价格”区间赋值
        [self initPriceRange:array];
         //刷新背景视图
        [self.backgroundView setNeedsDisplay];
    }
}

#pragma mark - 初始化“星级（可多选）”按钮赋值
-(void)initStar:(NSArray *)array{
    //价格区间临时变量
    NSString *str = [NSString stringWithFormat:@""];
    str=[str stringByAppendingString:[array objectAtIndex:0]];
    //判断价格区间值是否包含“-”,如果包含表示有价格区间值，否则表示：价格不限
    if ([str containsString:@"-"]) {
        str=[str stringByReplacingOccurrencesOfString:@"￥" withString:@""];
        
        NSArray *arrayPriceRange=[str componentsSeparatedByString:@"-"];
        NSString *strPriceRange0=[NSString stringWithFormat:@""];
        NSString *strPriceRange1=[NSString stringWithFormat:@""];
        strPriceRange0=[strPriceRange0 stringByAppendingString:[arrayPriceRange objectAtIndex:0]];
        strPriceRange1=[strPriceRange1 stringByAppendingString:[arrayPriceRange objectAtIndex:1]];
        
        
        float lowerPrice=[[self.tempPriceDict objectForKey:strPriceRange0] floatValue];
        float upperPrice=[[self.tempPriceDict objectForKey:strPriceRange1] floatValue];
        
        [self.sliderRange setLowerValue:lowerPrice upperValue:upperPrice animated:true];
    }
}

#pragma mark - 初始化“价格”区间赋值
-(void)initPriceRange:(NSArray *)array{
    //星级逻辑业务处理
    [self.selectDict removeAllObjects];
    if (array.count==2) { //表示星级不限
        //恢复初始化状态-“星级（可多选）”
        [self recoveryDefaultButton];
    }else{
        for (int i=1;i<array.count; i++) {
            self.borderColor=[UIColor orangeColor];
            if ([array[i] isEqual:@"经济"]) {
                self.button1.layer.borderColor = self.borderColor.CGColor;
                self.button1.backgroundColor=[UIColor orangeColor];
                [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.selectDict setObject:@"经济" forKey:@"1"];
            }else if ([array[i] isEqual:@"三星/舒适"]){
                self.button2.layer.borderColor = self.borderColor.CGColor;
                self.button2.backgroundColor=[UIColor orangeColor];
                [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.selectDict setObject:@"三星/舒适" forKey:@"2"];
            }else if([array[i] isEqual:@"四星/高档"]){
                self.button3.layer.borderColor = self.borderColor.CGColor;
                self.button3.backgroundColor=[UIColor orangeColor];
                [self.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.selectDict setObject:@"四星/高档" forKey:@"3"];
            }else if ([array[i] isEqual:@"五星/豪华"]){
                self.button4.layer.borderColor = self.borderColor.CGColor;
                self.button4.backgroundColor=[UIColor orangeColor];
                [self.button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.selectDict setObject:@"五星/豪华" forKey:@"4"];
            }
        }
        //把不限按钮职位灰色
        [self setDefaultButton];
    }

}



#pragma mark - 创建自定义视图
-(void)customView{
   
    //1.创建“价格星级”标题
    UILabel *titleLabel=[self createPriceStar];
    
    //2.创建“清空”按钮
    [self createClearAll];
    
    //3.设置水平直线
    UIView *line=[self createLine:titleLabel];
    
    //4.创建“星级（可多选）”
    UILabel *multipleChoiceStar=[self createMultipleChoice:line];
    
    //5.创建“星级（可多选）”按钮
    UIButton *multipleChoice=[self createSegmentButton:multipleChoiceStar];
    
    //6.创建“价格”
    UILabel *price=[self createPrice:multipleChoice];

    //7.创建“价格”区间
    LYRangeSlider *slider=[self createPriceRangeSlider:price];
    
    //8.创建“圆点”
    UILabel *circle=[self createCircle:slider];
    
    //9.创建“人民币价格”
    UILabel *rmb=[self createRMB:circle];
 
    //10.创建“黄色直线”
    UIView *yellowLine=[self createYellowLine:rmb];
    
    //11.创建“确定”按钮
    [self createOK:yellowLine];
    
    //添加背景视图至当前视图中
    [self addSubview:_backgroundView];
}

#pragma mark - 创建"价格星级"
-(UILabel *)createPriceStar{
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,ViewWidth(_backgroundView), 45)];
    //设置标题居中显示
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //设置标题颜色
    titleLabel.textColor = [UIColor blackColor];
    //设置标题值
    titleLabel.text = @"价格星级";
    //添加标题至背景视图
    [self.backgroundView addSubview:titleLabel];
    return titleLabel;
}

#pragma mark - 创建“清空”按钮
-(void)createClearAll{
    UIButton *clearButton=[[UIButton alloc] initWithFrame:CGRectMake(windowContentWidth/2+80,0,100,45)];
    //设置按钮标题
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    //设置按钮字体颜色
    [clearButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //设置按钮触发事件
    [clearButton addTarget:self action:@selector(clearAllItem:) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮Tag值
    clearButton.tag=100;
    //添加按钮至背景视图
    [self.backgroundView addSubview:clearButton];
}

#pragma mark - 创建"水平直线"
-(UIView *)createLine:(UILabel *)titleLabel{
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0,ViewBelow(titleLabel), ViewWidth(_backgroundView),1)];
    //设置水平直线背景颜色
    line.backgroundColor=[UIColor groupTableViewBackgroundColor];
    //添加水平直线至背景视图
    [self.backgroundView addSubview:line];
    return  line;
}

#pragma mark - 创建“星级（可多选）”
-(UILabel *)createMultipleChoice:(UIView *)line{
    UILabel *multipleChoiceStar=[[UILabel alloc] initWithFrame:CGRectMake(18,ViewBelow(line),ViewWidth(_backgroundView),45)];
    //设置对齐方式
    multipleChoiceStar.textAlignment=NSTextAlignmentLeft;
    //设置字体颜色
    multipleChoiceStar.textColor=[UIColor blackColor];
    //设置值
    multipleChoiceStar.text=@"星级（可多选）";
    //添加“星级（可多选）”至背景视图
    [self.backgroundView addSubview:multipleChoiceStar];
    return multipleChoiceStar;
}

#pragma mark - 创建“星级（可多选）”按钮
-(UIButton *)createSegmentButton:(UILabel *)multipleChoiceStar{
    int segmentHeight=0;
    switch ((int)windowContentHeight) {
        case 480:
            //设置“星级（可多选）”按钮辅助高度->3.5吋
            break;
        case 568:
            //设置“星级（可多选）”按钮辅助高度->4吋
            break;
        case 667:
           //设置“星级（可多选）”按钮辅助高度->4.7存
            segmentHeight=11;
            break;
        case 736:
            //设置“星级（可多选）”按钮辅助高度->5.5吋
            segmentHeight=18;
            break;
        default:
            break;
    }
    
    //声明一个数组
    NSArray *starArray=[[NSArray alloc] initWithObjects:@"不限",@"经济",@"三星/舒适",@"四星/高档",@"五星/豪华", nil];
    
    
    UIButton *newButton0=[[UIButton alloc] initWithFrame:CGRectMake(18,ViewBelow(multipleChoiceStar),50+segmentHeight,30)];
    [newButton0 setTitle:starArray[0] forState:UIControlStateNormal];
    [newButton0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    newButton0.backgroundColor=[UIColor orangeColor];
    newButton0.layer.borderWidth = 0.5;
    newButton0.layer.borderColor = self.borderColor.CGColor;
    newButton0.font=[UIFont systemFontOfSize:12];
    newButton0.tag = 0;
    [newButton0 addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
    self.button0=newButton0;
    [self.backgroundView addSubview:newButton0];
    
    
    UIButton *newButton1=[[UIButton alloc] initWithFrame:CGRectMake(ViewRight(newButton0),ViewY(newButton0),60+segmentHeight,30)];
    [newButton1 setTitle:starArray[1] forState:UIControlStateNormal];
    [newButton1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    newButton1.backgroundColor=[UIColor whiteColor];
    newButton1.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    newButton1.layer.borderColor = self.borderColor.CGColor;
    newButton1.font=[UIFont systemFontOfSize:12];
    newButton1.tag = 1;
    [newButton1 addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
     self.button1=newButton1;
    [self.backgroundView addSubview:newButton1];
    
    
    UIButton *newButton2=[[UIButton alloc] initWithFrame:CGRectMake(ViewRight(newButton1),ViewY(newButton1),60+segmentHeight,30)];
    [newButton2 setTitle:starArray[2] forState:UIControlStateNormal];
    [newButton2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    newButton2.backgroundColor=[UIColor whiteColor];
    newButton2.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    newButton2.layer.borderColor = self.borderColor.CGColor;
    newButton2.font=[UIFont systemFontOfSize:12];
    newButton2.tag = 2;
    [newButton2 addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
     self.button2=newButton2;
    [self.backgroundView addSubview:newButton2];
    
    
    UIButton *newButton3=[[UIButton alloc] initWithFrame:CGRectMake(ViewRight(newButton2),ViewY(newButton2),60+segmentHeight,30)];
    [newButton3 setTitle:starArray[3] forState:UIControlStateNormal];
    [newButton3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    newButton3.backgroundColor=[UIColor whiteColor];
    newButton3.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    newButton3.layer.borderColor = self.borderColor.CGColor;
    newButton3.font=[UIFont systemFontOfSize:12];
    newButton3.tag = 3;
    [newButton3 addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
     self.button3=newButton3;
    [self.backgroundView addSubview:newButton3];
    
    
    UIButton *newButton4=[[UIButton alloc] initWithFrame:CGRectMake(ViewRight(newButton3),ViewY(newButton3),60+segmentHeight,30)];
    [newButton4 setTitle:starArray[4] forState:UIControlStateNormal];
    [newButton4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    newButton4.backgroundColor=[UIColor whiteColor];
    newButton4.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    newButton4.layer.borderColor = self.borderColor.CGColor;
    newButton4.font=[UIFont systemFontOfSize:12];
    newButton4.tag = 4;
    [newButton4 addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
     self.button4=newButton4;
    [self.backgroundView addSubview:newButton4];
    
    return newButton4;
}

#pragma mark - 创建“价格”
-(UILabel *)createPrice:(UIButton *)multipleChoiceStar{
    UILabel *price=[[UILabel alloc] initWithFrame:CGRectMake(18,ViewBelow(multipleChoiceStar),ViewWidth(_backgroundView),45)];
    //设置对齐方式
    price.textAlignment=NSTextAlignmentLeft;
    //设置字体颜色
    price.textColor=[UIColor blackColor];
    //设置值
    price.text=@"价格";
    //添加“价格”至背景视图
    [self.backgroundView addSubview:price];
    return price;
}

#pragma mark - 创建“价格区间”
-(LYRangeSlider *)createPriceRangeSlider:(UILabel *)price{
     self.sliderRange=[[LYRangeSlider alloc] initWithFrame:CGRectMake(10,ViewBelow(price)+10,ViewWidth(price)-18,20)];
    
     self.sliderRange.minimumRange=0.2;
     self.sliderRange.lowerValue=0.0;
     self.sliderRange.upperValue=1.0;
    
    [self.sliderRange setStepValue:0.2];
    [ self.sliderRange setLowerValue: self.sliderRange.lowerValue upperValue: self.sliderRange.upperValue animated:true];
     self.sliderRange.stepValueContinuously=true;
    
     self.sliderRange.tintColor=[UIColor orangeColor];
    
    
    [self.backgroundView addSubview: self.sliderRange];
    return  self.sliderRange;
}

#pragma mark - 创建六个"圆点"
-(UILabel *)createCircle:(LYRangeSlider *)slider{
    int circleX=0;
    switch ((int)windowContentHeight) {
        case 480:
            //设置“圆点”辅助X->3.5吋
            break;
        case 568:
             //设置“圆点”辅助X->4吋
            break;
        case 667:
             //设置“圆点”辅助X->4.7存
            circleX=11;
            break;
        case 736:
             //设置“圆点”辅助X->5.5吋
            circleX=18;
            break;
        default:
            break;
    }

    
    
    
    
    
    
    UILabel *circle1=[[UILabel alloc] initWithFrame:CGRectMake(17,ViewBelow(slider)+10,20,20)];
    circle1.text=@"●";
    circle1.textColor=[UIColor orangeColor];
    circle1.textAlignment=NSTextAlignmentCenter;
    [self.backgroundView addSubview:circle1];
    
    UILabel *circle2=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(circle1)+33+circleX,ViewBelow(slider)+10,20,20)];
    circle2.text=@"●";
    circle2.textColor=[UIColor orangeColor];
    circle2.textAlignment=NSTextAlignmentCenter;
    [self.backgroundView addSubview:circle2];
    
    
    UILabel *circle3=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(circle2)+35+circleX,ViewBelow(slider)+10,20,20)];
    circle3.text=@"●";
    circle3.textColor=[UIColor orangeColor];
    circle3.textAlignment=NSTextAlignmentCenter;
    [self.backgroundView addSubview:circle3];
    
    
    UILabel *circle4=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(circle3)+33+circleX,ViewBelow(slider)+10,20,20)];
    circle4.text=@"●";
    circle4.textColor=[UIColor orangeColor];
    circle4.textAlignment=NSTextAlignmentCenter;
    [self.backgroundView addSubview:circle4];
    
    
    UILabel *circle5=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(circle4)+35+circleX,ViewBelow(slider)+10,20,20)];
    circle5.text=@"●";
    circle5.textColor=[UIColor orangeColor];
    circle5.textAlignment=NSTextAlignmentCenter;
    [self.backgroundView addSubview:circle5];
    
    UILabel *circle6=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(circle5)+33+circleX,ViewBelow(slider)+10,20,20)];
    circle6.text=@"●";
    circle6.textColor=[UIColor orangeColor];
    circle6.textAlignment=NSTextAlignmentCenter;
    [self.backgroundView addSubview:circle6];
    
    return circle1;
}

#pragma mark - 创建“人民币”
-(UILabel *)createRMB:(UILabel *)circle{
    
    
    int rmbX=0;
    switch ((int)windowContentHeight) {
        case 480:
            //设置“圆点”辅助X->3.5吋
            break;
        case 568:
            //设置“圆点”辅助X->4吋
            break;
        case 667:
            //设置“圆点”辅助X->4.7存
            rmbX=11;
            break;
        case 736:
            //设置“圆点”辅助X->5.5吋
            rmbX=18;
            break;
        default:
            break;
    }

    
    
    UILabel *rmb1=[[UILabel alloc] initWithFrame:CGRectMake(10,ViewBelow(circle), 30,20)];
    rmb1.textColor=[UIColor orangeColor];
    rmb1.textAlignment=NSTextAlignmentCenter;
    rmb1.font=[UIFont systemFontOfSize:12];
    rmb1.text=@"￥0";
    [self.backgroundView addSubview:rmb1];
    
    
    UILabel *rmb2=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(rmb1)+10+rmbX,ViewBelow(circle),50,20)];
    rmb2.textColor=[UIColor orangeColor];
    rmb2.textAlignment=NSTextAlignmentCenter;
    rmb2.font=[UIFont systemFontOfSize:12];
    rmb2.text=@"￥150";
    [self.backgroundView addSubview:rmb2];
    
    UILabel *rmb3=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(rmb2)+5+rmbX,ViewBelow(circle), 50,20)];
    rmb3.textColor=[UIColor orangeColor];
    rmb3.textAlignment=NSTextAlignmentCenter;
    rmb3.font=[UIFont systemFontOfSize:12];
    rmb3.text=@"￥300";
    [self.backgroundView addSubview:rmb3];
    
    UILabel *rmb4=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(rmb3)+5+rmbX,ViewBelow(circle), 50,20)];
    rmb4.textColor=[UIColor orangeColor];
    rmb4.textAlignment=NSTextAlignmentCenter;
    rmb4.font=[UIFont systemFontOfSize:12];
    rmb4.text=@"￥450";
    [self.backgroundView addSubview:rmb4];
    
    
    UILabel *rmb5=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(rmb4)+5+rmbX,ViewBelow(circle), 50,20)];
    rmb5.textColor=[UIColor orangeColor];
    rmb5.textAlignment=NSTextAlignmentCenter;
    rmb5.font=[UIFont systemFontOfSize:12];
    rmb5.text=@"￥700";
    [self.backgroundView addSubview:rmb5];
    
    UILabel *rmb6=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(rmb5)+6+rmbX,ViewBelow(circle), 50,20)];
    rmb6.textColor=[UIColor orangeColor];
    rmb6.textAlignment=NSTextAlignmentCenter;
    rmb6.font=[UIFont systemFontOfSize:12];
    rmb6.text=@"不限";
    [self.backgroundView addSubview:rmb6];
    
    return rmb6;
}

#pragma mark - 创建“黄色直线”
-(UIView *)createYellowLine:(UILabel *)rmb{
    UIView *yellowLine=[[UIView alloc] initWithFrame:CGRectMake(0,ViewBelow(rmb)+20,ViewWidth(_backgroundView),1)];
    yellowLine.backgroundColor=[UIColor orangeColor];
    yellowLine.alpha=0.2;
    [self.backgroundView addSubview:yellowLine];
    return yellowLine;
}

#pragma mark - 创建“确定”按钮
-(void)createOK:(UIView *)yellowLine{
    UIButton *btnOK=[[UIButton alloc] initWithFrame:CGRectMake(0,ViewBelow(yellowLine)+10,ViewWidth(_backgroundView),20)];
    //设置按钮标题
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    //设置按钮字体颜色
    [btnOK setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //设置该按钮Tag值
    btnOK.tag=101;
    //设置按钮触发事件
    [btnOK addTarget:self action:@selector(okClieck:) forControlEvents:UIControlEventTouchUpInside];
    //添加按钮至背景视图
    [self.backgroundView addSubview:btnOK];
}


#pragma mark - "星级（可多选）"按钮点击事件
-(void)segmentClick:(id)sender{
   
    UIButton *btn=(UIButton *)sender;
    NSString *keys=[NSString stringWithFormat:@"%ld",btn.tag];
    NSString *value=[btn currentTitle];
    //不等于“0”，表示点击的是其他按钮，否则表示是点击“不限”按钮
    if (btn.tag!=0) {
        //把“不限”按钮置为灰色，表示没有选中
        [self setDefaultButton];
        //判断数据字典里是否有该“键”
        if ([self isSelectDictKey:self.selectDict key:keys]) {
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor whiteColor];
            btn.layer.borderWidth = 0.5;
            self.borderColor=[UIColor lightGrayColor];
            btn.layer.borderColor = self.borderColor.CGColor;
            [self.selectDict removeObjectForKey:keys];
            
            //判断数据字典项是否三项，
            if (self.selectDict.count==0) {
                //清空数据字典所有项，并恢复“不限”按钮默认状态，并选中
                [self recoveryDefaultButton];
            }
        }
        else{
            if (self.selectDict.count==3) {
                //清空数据字典所有项，并恢复“不限”按钮默认状态，并选中
                [self recoveryDefaultButton];
            }else{
                self.borderColor=[UIColor orangeColor];
                btn.layer.borderColor = self.borderColor.CGColor;
                btn.backgroundColor=[UIColor orangeColor];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [self.selectDict setObject:value forKey:keys];
            }
        }
    }else{
        [self recoveryDefaultButton];
    }
    //刷新视图
    [self.backgroundView setNeedsDisplay];
    
}

#pragma mark - 清空-事件
-(void)clearAllItem:(UIButton *)sender{
    //恢复初始化状态-“星级（可多选）”
    [self recoveryDefaultButton];
    self.starString=@"";
    self.starValue=@"星级不限";
    self.priceValue=@"价格不限";
    [self.sliderRange setLowerValue:0.0 upperValue:1.0 animated:true];
    
}

#pragma mark - 确定-事件
-(void)okClieck:(id)sender{
    //初始化为空字符串
    self.pubString=@"";
    //取出“星级（可多选）”按钮数据字典中的值
    [self getSegmentValue];
    
    // 取出“价格区间”值
    [self getPriceRangeValue];
    
    if ([self.starString isEqualToString:@""]&&[self.lowerValue isEqual:@"0"]&&[self.upperValue isEqual:@"不限"]) {
        self.pubString=@"";
    }else if(![self.starString isEqualToString:@""]&&[self.lowerValue isEqual:@"0"]&&[self.upperValue isEqual:@"不限"]){
        self.pubString=[self.pubString stringByAppendingString:self.priceValue];
        self.pubString=[self.pubString stringByAppendingString:@","];
        self.pubString=[self.pubString stringByAppendingString:self.starString];
    }else if ([self.starString isEqualToString:@""]&&(![self.lowerValue isEqual:@"0"] || ![self.upperValue isEqual:@"不限"])){
        self.pubString=[self.pubString stringByAppendingString:@"￥"];
        self.pubString=[self.pubString stringByAppendingString:self.lowerValue];
        self.pubString=[self.pubString stringByAppendingString:@"-"];
        self.pubString=[self.pubString stringByAppendingString:self.upperValue];
        self.pubString=[self.pubString stringByAppendingString:@","];
        self.pubString=[self.pubString stringByAppendingString:self.starValue];
    }else if (![self.starString isEqualToString:@""] && (![self.lowerValue isEqual:@"0"] || ![self.upperValue isEqual:@"不限"])){
        self.pubString=[self.pubString stringByAppendingString:@"￥"];
        self.pubString=[self.pubString stringByAppendingString:self.lowerValue];
        self.pubString=[self.pubString stringByAppendingString:@"-"];
        self.pubString=[self.pubString stringByAppendingString:self.upperValue];
        self.pubString=[self.pubString stringByAppendingString:@","];
        self.pubString=[self.pubString stringByAppendingString:self.starString];
       
    }
    
    
    [self.delegate result:self.pubString];
    self.hidden=YES;
    
    
    
}

#pragma mark - 取出“价格区间”值
-(void)getPriceRangeValue{
    CGPoint lowerCenter;
    lowerCenter.x = (self.sliderRange.lowerCenter.x + self.sliderRange.frame.origin.x);
    
    CGPoint upperCenter;
    upperCenter.x = (self.sliderRange.upperCenter.x + self.sliderRange.frame.origin.x);
    
    self.lowerValue=[self.priceDict objectForKey:[NSString stringWithFormat:@"%g",lowerCenter.x]];
    self.upperValue=[self.priceDict objectForKey:[NSString stringWithFormat:@"%g",upperCenter.x]];
}


#pragma mark - 取出“星级（可多选）”字符串值
-(void)getSegmentValue{
    self.starString=@"";
    id obj;
    for (obj in self.selectDict){
        if (![obj isEqualToString:@"0"]) {
            self.starString=[self.starString stringByAppendingString:[self.selectDict objectForKey:obj]];
            self.starString=[self.starString stringByAppendingString:@","];
        }else{
            self.starString=@"";
        }
    }
    
    if (![self.starString isEqual:@""]) {
        self.starString=[self.starString substringToIndex:self.starString.length-1];
    }
}


#pragma mark - 取“价格”区间值
-(void)getSliderValue{
    
    NSString *val=[NSString stringWithFormat:@"%d",(int)self.sliderRange.lowerValue];
    
    NSLog(@"lowerValue:%@",val);

}


#pragma mark - 判断数据字典中是否存“键”
-(BOOL)isSelectDictKey:(NSDictionary *)dict key:(NSString *)key{
    
    if ([[dict allKeys] containsObject:key]) {
        return true;
    }
    return false;
    
}

#pragma mark - 把"不限"颜色置为灰色，表示没有选中
-(void)setDefaultButton{
    [self.button0 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.button0.backgroundColor=[UIColor whiteColor];
    self.button0.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    self.button0.layer.borderColor = self.borderColor.CGColor;
    [self.selectDict removeObjectForKey:@"0"];
}


#pragma mark - 把“不限”按钮颜色恢复默认颜色，表示选中
-(void)setDefaultButtonSelected{
    [self.button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button0.backgroundColor=[UIColor orangeColor];
    self.button0.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    self.button0.layer.borderColor = self.borderColor.CGColor;
    [self.selectDict setObject:@"不限" forKey:@"0"];
}


#pragma mark - 点击”不限“按钮，把其他按钮想置为灰色，表示只选中“不限”
-(void)recoveryDefaultButton{
    //把数据字典清空
    [self.selectDict removeAllObjects];
    //恢复“不限”按钮默认状态
    [self setDefaultButtonSelected];
    //设置数据字典默认值
    [self.selectDict setObject:@"不限" forKey:@"0"];
    
    //其他按钮项全部置为灰色
    [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.button1.backgroundColor=[UIColor whiteColor];
    self.button1.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    self.button1.layer.borderColor = self.borderColor.CGColor;
    
    [self.button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.button2.backgroundColor=[UIColor whiteColor];
    self.button2.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    self.button2.layer.borderColor = self.borderColor.CGColor;
    
    
    [self.button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.button3.backgroundColor=[UIColor whiteColor];
    self.button3.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    self.button3.layer.borderColor = self.borderColor.CGColor;
    
    
    [self.button4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.button4.backgroundColor=[UIColor whiteColor];
    self.button4.layer.borderWidth = 0.5;
    self.borderColor=[UIColor lightGrayColor];
    self.button4.layer.borderColor = self.borderColor.CGColor;
    
    
}

#pragma mark - 隐藏父视图层
-(void)viewHide:(UITapGestureRecognizer*)tap{
    if(self.hidden == NO){
        self.hidden = YES;
        self.backgroundView.hidden = YES;
    }
}
#pragma mark - 点击子视图，不做任何处理，为了覆盖父视图手势
-(void)subViewHide:(UITapGestureRecognizer *)tap{

}
@end
