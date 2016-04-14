//
//  CyYLTableViewCell.m
//  WelLv
//
//  Created by 赵冉 on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CyYLTableViewCell.h"

@interface CyYLTableViewCell()
@property(nonatomic,strong) CYYLModel * model;
@end

@implementation CyYLTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _imagevc= [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth / 37.5, windowContentHeight / 23,windowContentHeight / 41.6, windowContentHeight / 41.6)];
    [_imagevc setImage:[UIImage imageNamed:@"未选中"]];
//    _imagevc.backgroundColor = [UIColor yellowColor];
   
    [self.contentView addSubview:_imagevc];
    _namelable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 10, windowContentHeight / 51.3, 200, windowContentHeight / 41.6)];
    _namelable.font = [UIFont systemFontOfSize:windowContentWidth / 23.4];
    _number = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 10, windowContentHeight / 15.1, 350, windowContentHeight / 41.6)];
    _number.font = [UIFont systemFontOfSize:windowContentWidth / 28.8];
    //UIButton * VC  = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth - windowContentWidth / 25 - windowContentWidth / 21.4, windowContentHeight / 27, windowContentWidth / 25, windowContentWidth / 25)];
    UIButton * VC  = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth - windowContentWidth / 25 - windowContentWidth / 21.4 - 10, 3, windowContentWidth / 25 + 20, windowContentWidth / 25 * 4)];

    [VC setImage:[UIImage imageNamed:@"矩形-32"] forState:UIControlStateNormal];
              //[VC addTarget:self action:@selector(VCCLICK) forControlEvents:UIControlEventTouchUpInside];
    [VC addTarget:self action:@selector(topinside) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_namelable];
    [self.contentView addSubview:_number];
    [self.contentView addSubview:VC];

}

- (void)config:(CYYLModel *)model{
    
    _model = model;
    _namelable.text = model.to_username;
  
//    if ([model.id_type integerValue] == 0 || [self judgeString:[NSString stringWithFormat:@"%@",model.id_number]] == NO) {
//          _number.text = @"信息不完善";
//    }else if([model.id_type integerValue] == 1 && [self judgeString:[NSString stringWithFormat:@"%@",model.id_number]] == YES){
//        _number.text = [NSString stringWithFormat:@"身份证:%@",model.id_number];
//    }else if([model.id_type integerValue] == 2 && [self judgeString:[NSString stringWithFormat:@"%@",model.id_number]] == YES){
//        _number.text = [NSString stringWithFormat:@"护照:%@",model.id_number];
//    }else if([model.id_type integerValue] == 3 && [self judgeString:[NSString stringWithFormat:@"%@",model.id_number]] == YES){
//        _number.text = [NSString stringWithFormat:@"军官证:%@",model.id_number];
//    }else if([model.id_type integerValue] == 4 && [self judgeString:[NSString stringWithFormat:@"%@",model.id_number]] == YES){
//        _number.text = [NSString stringWithFormat:@"港澳通行证:%@",model.id_number];
//    }else if([model.id_type integerValue] == 5 && [self judgeString:[NSString stringWithFormat:@"%@",model.id_number]] == YES){
//        _number.text = [NSString stringWithFormat:@"台胞证:%@",model.id_number];
//    }
    
    _number.text = [NSString stringWithFormat:@"手机号:%@",model.phone];
    
    
    if (model.selectState ) {
        [self.imagevc setImage:[UIImage imageNamed:@"选中按钮"]];
        self.selectState = YES;
    }else{
        self.selectState = NO;
        [self.imagevc setImage:[UIImage imageNamed:@"未选中"]];
    }

}
//  点击事件 
//- (void)topinside{
//    if ([self.delegate respondsToSelector:@selector(Goto:)]) {
//        [self.delegate Goto:self.model];
//    }
//
//}
- (void)topinside{
    
    if ([self.delegate respondsToSelector:@selector(Goto:)]) {
                [self.delegate Goto:_model];
            }

}

@end
