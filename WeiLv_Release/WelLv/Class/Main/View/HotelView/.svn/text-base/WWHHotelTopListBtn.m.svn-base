//
//  WWHHotelTopListBtn.m
//  WelLv
//
//  Created by 吴伟华 on 15/11/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WWHHotelTopListBtn.h"
#import "HotelBrandsModel.h"
#import "HotelThemeModel.h"
#import "HotelFacilityModel.h"
@interface WWHHotelTopListBtn ()
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UIButton *deletBtn;
@property (nonatomic , strong) UIScrollView *btnScrollView;
@end
@implementation WWHHotelTopListBtn

-(UIButton *)deletBtn
{
    if (_deletBtn == nil) {
        _deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _deletBtn;
}
-(instancetype)initWithFrame:(CGRect)frame topListBtnWithModel:(id)model andFirstCell:(NSInteger)first sectCell:(NSInteger)sectCell andIsSelect:(BOOL)isSelect
{

    if (self = [super initWithFrame:frame]){
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(118, 2, 1, 26)];
        line.backgroundColor = bordColor;
        line.alpha = 0.8;
        [self addSubview:line];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 90, 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        if (first == 0) {
            HotelBrandsModel *brandsModel = model;
            
            self.nameLabel.text = brandsModel.brandname;
          
        }
        else if (first == 1)
        {
        HotelThemeModel *brandsModel = model;
        self.nameLabel.text = brandsModel.name;
        }
        else
        {
        HotelFacilityModel *brandsModel = model;
        self.nameLabel.text = brandsModel.name;
        }
        
        [self addSubview:self.nameLabel];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(92, 5, 20, 20);
        [btn setImage:[UIImage imageNamed:@"取消按钮"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deletBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.deletBtn = btn;
        
        _model = model;
        _firstCellRow = first;
        _secCellRow = sectCell;
        
    }
    return self;
}
-(void)deletBtnClick
{
    if ([_delegate performSelector:@selector(hotelTopBtnClickWithFirstCell:sectCell:)]) {
         [_delegate hotelTopBtnClickWithFirstCell:self.firstCellRow sectCell:self.secCellRow];
    }

}
-(CGSize)contentSzieWithStr:(NSString *)str andFont:(NSInteger)font
{
    CGSize maxSize = CGSizeMake(110, 20);
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
   CGSize contentSize  =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil].size;
    return contentSize;
 
}

@end
