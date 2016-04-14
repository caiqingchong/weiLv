//
//  backGroundCell.m
//  WelLv
//
//  Created by lyx on 15/11/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "backGroundCell.h"

@implementation backGroundCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.leftImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
    self.leftImage.backgroundColor=[UIColor greenColor];
    self.leftImage.layer.cornerRadius=5;
    [self addSubview:self.leftImage];
    self.dishNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.leftImage)+5, 10, 100, 20)];
    self.dishNameLabel.font=systemFont(18);
    self.dishNameLabel.textColor=[UIColor blackColor];
    [self addSubview:self.dishNameLabel];
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 10, 80, 20)];
    self.priceLabel.font=systemFont(18);
    self.priceLabel.textColor=[UIColor orangeColor];
    [self addSubview:self.priceLabel];
    self.minusBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-100, 7.5, 25, 25)];
    
    [self.minusBtn addTarget:self action:@selector(minusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.minusBtn];
    self.totaleNumebr=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.minusBtn)+5, ViewY(self.minusBtn)+6.5, 30, 12)];
    self.totaleNumebr.textColor=[UIColor grayColor];
    self.totaleNumebr.textAlignment=1;
    self.totaleNumebr.font=systemFont(12);
    [self addSubview:self.totaleNumebr];
    [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少可用"]forState:UIControlStateNormal];
    self.plusBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewRight(self.totaleNumebr)+5, ViewY(self.minusBtn), 25, 25)];
    [self.plusBtn setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [self.plusBtn addTarget:self action:@selector(plusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.plusBtn];

    return self;
}
-(RestauantModel *)_model
{
    if(_model==nil) {
        _model=[[RestauantModel alloc]init];
    }
    return _model;
}
-(void)minusBtn:(UIButton *)sender
{
    if ([self.totaleNumebr.text intValue]==0)
    {
        return;
    }
    
    --self.model.total;
    
    self.totaleNumebr.text=[NSString stringWithFormat:@"%d",self.model.total];
    
    if (self.cellBlock2) {
        self.cellBlock2(_model.indexPath1,_model.total,_model);
    }
    

}
-(void)plusBtn:(id)sender
{
   
    
    ++ self.model.total;
    
    self.totaleNumebr.text=[NSString stringWithFormat:@"%d",self.model.total];
    if (self.cellBlock2) {
        self.cellBlock2(_model.indexPath1,self.model.total,_model);
    }


}
-(void)setModel:(RestauantModel *)model
{
   
    _model=model;
    
    self.dishNameLabel.text=model.describe;
    self.priceLabel.text=[NSString stringWithFormat:@"￥%0.2f",[model.price floatValue]];
  
    self.totaleNumebr.text=[NSString stringWithFormat:@"%d",model.total];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  //  [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
