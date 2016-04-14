//
//  JYCorderDishesCell.m
//  WelLv
//
//  Created by lyx on 15/11/12.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCorderDishesCell.h"

@implementation JYCorderDishesCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
   
    
    self.frame=CGRectMake(0, 0, windowContentWidth/3*2, 85);
    self.dishNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    self.dishNameLabel.font=systemFont(18);
    self.dishNameLabel.textColor=[UIColor blackColor];
    
    [self addSubview:self.dishNameLabel];
    self.numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-10-80, 5, 80, 20)];
    self.numberLabel.font=systemFont(15);
    self.numberLabel.textColor=[UIColor orangeColor];
    [self addSubview:self.numberLabel];
    self.salesLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(self.dishNameLabel)+10, 60, 15)];
    self.salesLabel.font=systemFont(12);
    self.salesLabel.textColor=[UIColor grayColor];
    [self addSubview:self.salesLabel];
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(self.salesLabel)+10, 60, 20)];
    self.priceLabel.font=systemFont(15);
    self.priceLabel.textColor=[UIColor orangeColor];
    [self addSubview:self.priceLabel];
    self.originPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.priceLabel), ViewBelow(self.salesLabel)+13, 40, 15)];
    self.originPriceLabel.font=systemFont(10);
    self.originPriceLabel.textAlignment=1;
    self.originPriceLabel.textColor=[UIColor grayColor];
    self.originPriceLabel.textAlignment=NSTextAlignmentCenter;
    //self.originPriceLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.originPriceLabel];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self.originPriceLabel)/2, ViewWidth(self.originPriceLabel), 1)];
    lineView.backgroundColor=[UIColor grayColor];
    [self.originPriceLabel addSubview:lineView];
    
    self.minusBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-100, ViewY(self.priceLabel)-5, 25, 25)];
    [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
    [self.minusBtn addTarget:self action:@selector(minusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.minusBtn];
    self.totaleNumebr=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.minusBtn)+5, ViewY(self.minusBtn)+6.5, 30, 12)];
    self.totaleNumebr.textColor=[UIColor grayColor];
    self.totaleNumebr.textAlignment=1;
    self.totaleNumebr.font=systemFont(12);
    [self addSubview:self.totaleNumebr];
    self.plusBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewRight(self.totaleNumebr)+5, ViewY(self.minusBtn), 25, 25)];
    [self.plusBtn setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [self.plusBtn addTarget:self action:@selector(plusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.plusBtn];
    return self;
}

-(void)minusBtn:(UIButton *)sender
{
    

    if ([self.totaleNumebr.text intValue]==0)
    {
       
        return;
        
    }
    --_model.total;
    
    if (_model.total==0) {
        [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];

    }
 
    
    if (self.cellBlock) {
      self.cellBlock(_model.total,_model,self.index);
    }
    
 
}
-(void)plusBtn:(id)sender
{
       ++_model.total;
    
    //self.totaleNumebr.text=[NSString stringWithFormat:@"%d",_model.total];
    if (_model.total>0) {
    
        [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
        
    }

    
    if (self.cellBlock) {
        self.cellBlock(_model.total,_model,self.index);
    }
    
    
  
}
-(void)setModel:(RestauantModel *)model
{
     _model=model;
    _model.indexPath1=self.index;
    self.dishNameLabel.text=model.describe;
    self.numberLabel.text=[NSString stringWithFormat:@"剩余%@份",model.number];
    self.salesLabel.text=[NSString stringWithFormat:@"月售%d份",[model.sales intValue]];
    self.priceLabel.text=[NSString stringWithFormat:@"￥%0.1f",[model.price floatValue]];
    //self.priceLabel.text=@"0.01";
    self.originPriceLabel.text=[NSString stringWithFormat:@"￥%0.1f",[model.original_price floatValue]];
    self.totaleNumebr.text=[NSString stringWithFormat:@"%d",_model.total];
}
-(RestauantModel *)_model
{
    if (_model==nil) {
        _model=[[RestauantModel alloc]init];
    }
    return _model;
}
-(NSMutableArray *)arry
{
    if (_arry==nil) {
        _arry=[[NSMutableArray alloc]init];
    }
    return _arry;
}
    // Configure the view for the selected state


@end
