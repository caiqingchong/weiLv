//
//  ZFJShipTableViewCell.m
//  WelLv
//
//  Created by 张发杰 on 15/5/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipTableViewCell.h"
#import "ZFJShipListModel.h"
#import "ShipListModel.h"
#define M_SHIP_ICON_LEFT_WIDTH 15
#define M_SHIP_TOP_WIDTH 10
#define M_SHIP_INTERVAL 10  //间隙

#define M_SHIP_ICON_WIDTH 75

#define M_SHIP_PRICE_LABEL_COLOR kColor(255, 96, 126)
#define M_SHIP_SET_SAIL_CITY_COLOR [UIColor grayColor]


@implementation ZFJShipTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        [self customView];
        [self customNewView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStry:(ZFJShipTableViewCellStyle)customStey{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.shipCellStyle = customStey;
        if (customStey == ZFJShipTableViewCellStyleOne) {
            [self customView];
        } else if (customStey == ZFJShipTableViewCellStyleTwo){
            [self customNewView];
        } else if (customStey == ZFJShipTableViewCellStyleThree){
            [self customshipListView];
        }
    }
    return self;
}
- (void)customView{
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(M_SHIP_ICON_LEFT_WIDTH, M_SHIP_TOP_WIDTH, M_SHIP_ICON_WIDTH, M_SHIP_ICON_WIDTH)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_iconImageView];
    
    self.titleLbel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_iconImageView) + ViewWidth(_iconImageView) + M_SHIP_INTERVAL, M_SHIP_TOP_WIDTH, windowContentWidth - ViewX(_iconImageView) - ViewWidth(_iconImageView) -M_SHIP_INTERVAL - 10, M_SHIP_ICON_WIDTH / 2 )];
    self.titleLbel.font = [UIFont systemFontOfSize:15];
    //self.titleLbel.backgroundColor = [UIColor orangeColor];
    self.titleLbel.numberOfLines = 0;
    [self.contentView addSubview:_titleLbel];
    
    self.setSailCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_titleLbel), ViewY(_titleLbel) + ViewHeight(_titleLbel), ViewWidth(_titleLbel), M_SHIP_ICON_WIDTH / 4)];
    self.setSailCityLabel.font = [UIFont systemFontOfSize:12];
    self.setSailCityLabel.textColor = kColor(115, 115, 120);;
    [self.contentView addSubview:_setSailCityLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake( windowContentWidth - 150, ViewY(self.iconImageView)+ViewHeight(self.iconImageView)-20, 140, 20)];
    self.priceLabel.textColor = kColor(255, 102, 0);
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_priceLabel];
    
    self.startLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(_priceLabel) + ViewX(_priceLabel),  ViewY(_setSailCityLabel) + ViewHeight(_setSailCityLabel), 50, M_SHIP_ICON_WIDTH / 4)];
    _startLabel.text = @"起";
    _startLabel.textColor = [UIColor grayColor];
    _startLabel.font = [UIFont systemFontOfSize:12];
   // [self.contentView addSubview:_startLabel];
    
    _gj_commissionLab=[[UILabel alloc] init];
    _gj_commissionLab.frame=CGRectMake(ViewWidth(_startLabel)+ViewX(_startLabel), ViewY(_startLabel), windowContentWidth-200, ViewHeight(_startLabel));
    _gj_commissionLab.textAlignment=NSTextAlignmentLeft;
    _gj_commissionLab.adjustsFontSizeToFitWidth = YES;
    _gj_commissionLab.font=[UIFont systemFontOfSize:16];
    _gj_commissionLab.textColor= M_SHIP_PRICE_LABEL_COLOR;
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
    {
        [self addSubview:_gj_commissionLab];
    }
    
}



//4.2
- (void)customNewView{
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 200)];
    [self.contentView addSubview:_iconImageView];
    
    [self publicView];
    
}


- (void)customshipListView{
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(M_SHIP_ICON_LEFT_WIDTH, M_SHIP_TOP_WIDTH, M_SHIP_ICON_WIDTH, M_SHIP_ICON_WIDTH)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_iconImageView];
    
    [self publicView];
    self.setSailCityLabel.textColor = kColor(115, 115, 120);
    self.titleLbel.frame = CGRectMake(ViewX(_iconImageView) + ViewWidth(_iconImageView) + M_SHIP_INTERVAL, M_SHIP_TOP_WIDTH, windowContentWidth - ViewX(_iconImageView) - ViewWidth(_iconImageView) -M_SHIP_INTERVAL - 10, M_SHIP_ICON_WIDTH / 2 );
    self.titleLbel.font = [UIFont systemFontOfSize:15];
    
}

- (void)publicView{
    
    self.titleLbel = [[UILabel alloc] init];
    self.titleLbel.textAlignment = NSTextAlignmentLeft;
    self.titleLbel.numberOfLines = 0;
    [self.contentView addSubview:_titleLbel];
    
    self.setSailCityLabel = [[UILabel alloc] init];
    self.setSailCityLabel.font = [UIFont systemFontOfSize:12];
    self.setSailCityLabel.textColor = M_SHIP_SET_SAIL_CITY_COLOR;
    [self.contentView addSubview:_setSailCityLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = M_SHIP_PRICE_LABEL_COLOR;
    self.priceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_priceLabel];
    
    self.startLabel = [[UILabel alloc] init];
    _startLabel.text = @" 起";
    _startLabel.textColor = [UIColor grayColor];
    _startLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_startLabel];
    
    _gj_commissionLab=[[UILabel alloc] init];
    _gj_commissionLab.textAlignment= NSTextAlignmentCenter;
    _gj_commissionLab.adjustsFontSizeToFitWidth = YES;
    _gj_commissionLab.font=[UIFont systemFontOfSize:15];
    _gj_commissionLab.textColor= M_SHIP_PRICE_LABEL_COLOR;
    
    
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
    {
        [self addSubview:_gj_commissionLab];
    }
}
/*
 
 邮轮模块-使用
 */
- (void)setShipListModel:(ZFJShipListModel *)shipListModel{
    
    if (self.shipCellStyle == ZFJShipTableViewCellStyleThree) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:shipListModel.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    } else {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:shipListModel.thumb]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    }
    
    NSString * priceStr =  [NSString stringWithFormat:@"￥%@", shipListModel.min_price];
    NSString * setSailCityStr = [NSString stringWithFormat:@"[%@出发]", shipListModel.port_name] ;
    
    
    if (self.shipCellStyle == ZFJShipTableViewCellStyleOne) {
        self.priceLabel.frame = CGRectMake(ViewX(_titleLbel), ViewY(_setSailCityLabel) + ViewHeight(_setSailCityLabel), [self returnTextCGRectText:priceStr textFont:16 cGSize:CGSizeMake(0, M_SHIP_ICON_WIDTH / 4)].size.width, M_SHIP_ICON_WIDTH / 4);
        
        self.startLabel.frame = CGRectMake(ViewWidth(_priceLabel) + ViewX(_priceLabel),  ViewY(_setSailCityLabel) + ViewHeight(_setSailCityLabel), 30, M_SHIP_ICON_WIDTH / 4);
        
        _gj_commissionLab.frame=CGRectMake(ViewWidth(_startLabel)+ViewX(_startLabel), ViewY(_startLabel), windowContentWidth-200, ViewHeight(_startLabel));
        
    } else if (self.shipCellStyle == ZFJShipTableViewCellStyleTwo){
        
        setSailCityStr = [NSString stringWithFormat:@"%@出发", shipListModel.port_name];
        
        
        self.titleLbel.frame = CGRectMake(15, ViewY(_iconImageView) + ViewHeight(_iconImageView) + 5, windowContentWidth - 30, [self returnTextCGRectText:shipListModel.product_name textFont:17 cGSize:CGSizeMake(windowContentWidth - 30, 0)].size.height);
        
        self.priceLabel.frame = CGRectMake(15, ViewY(_titleLbel) + ViewHeight(_titleLbel), [self returnTextCGRectText:priceStr textFont:16 cGSize:CGSizeMake(0, M_SHIP_ICON_WIDTH / 4)].size.width, 25);
        self.startLabel.frame = CGRectMake(ViewWidth(_priceLabel) + ViewX(_priceLabel),  ViewY(_priceLabel), 30, 25);
        
        self.setSailCityLabel.frame = CGRectMake(windowContentWidth - 15 - [self returnTextCGRectText:setSailCityStr textFont:12 cGSize:CGSizeMake(0, 25)].size.width, ViewY(_titleLbel) + ViewHeight(_titleLbel), [self returnTextCGRectText:setSailCityStr textFont:12 cGSize:CGSizeMake(0, 25)].size.width, 25);
        
        _gj_commissionLab.frame=CGRectMake(ViewWidth(_startLabel)+ViewX(_startLabel), ViewY(_startLabel), windowContentWidth-200, ViewHeight(_startLabel));
        
    } else if (self.shipCellStyle == ZFJShipTableViewCellStyleThree){
        
        self.setSailCityLabel.frame = CGRectMake(ViewX(_titleLbel), ViewHeight(_iconImageView) + ViewY(_iconImageView) - M_SHIP_ICON_WIDTH / 4, [self returnTextCGRectText:setSailCityStr textFont:12 cGSize:CGSizeMake(0, M_SHIP_ICON_WIDTH / 4)].size.width, M_SHIP_ICON_WIDTH / 4);
        self.setSailCityLabel.textColor = kColor(115, 115, 120);
        self.setSailCityLabel.font = [UIFont systemFontOfSize:12];
        
        self.priceLabel.frame =CGRectMake( windowContentWidth - 150, ViewY(self.iconImageView)+ViewHeight(self.iconImageView)-20, 140, 20);
        self.priceLabel.font = [UIFont systemFontOfSize:18];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.textColor = kColor(255, 102, 0);
       // self.startLabel.frame = CGRectMake(ViewWidth(_priceLabel) + ViewX(_priceLabel),  ViewY(_priceLabel) , 30, M_SHIP_ICON_WIDTH / 4);
        
        _gj_commissionLab.frame= CGRectMake(windowContentWidth-150, ViewY(_priceLabel)-20, 135, 15);
        _gj_commissionLab.font = [UIFont systemFontOfSize:10];
        _gj_commissionLab.textAlignment = NSTextAlignmentRight;
        _gj_commissionLab.textColor =kColor(255, 102, 0);

        
     //   _gj_commissionLab.frame=CGRectMake(ViewX(_setSailCityLabel) + ViewWidth(_setSailCityLabel) , ViewY(_startLabel), ViewX(_priceLabel) - ViewX(_setSailCityLabel) - ViewWidth(_setSailCityLabel), M_SHIP_ICON_WIDTH / 4);
    }
    
    _gj_commissionLab.text= [NSString stringWithFormat:@"返佣:￥%@", [self judgeReturnString:shipListModel.max_butler_s withReplaceString:@"0.00"]];
    
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]){
        [self.contentView addSubview:_gj_commissionLab];
    } else {
        [self.gj_commissionLab removeFromSuperview];

    }
    
    self.titleLbel.text = shipListModel.product_name;
    self.priceLabel.text = priceStr;
    self.setSailCityLabel.text = setSailCityStr;
    
    
    CGRect cellRect = self.frame;
    cellRect.size.height = ViewY(_priceLabel) + ViewHeight(_priceLabel) + 10;
    self.frame = cellRect;
}

//首页-邮轮使用
- (void)setShipListModels:(ShipListModel *)shipListModels{
    
    if (self.shipCellStyle == ZFJShipTableViewCellStyleThree) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:shipListModels.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    } else {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:shipListModels.thumb]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    }
    
    NSString * priceStr =  [NSString stringWithFormat:@"￥%@", shipListModels.min_price];
    NSString * setSailCityStr = [NSString stringWithFormat:@"[%@出发]", shipListModels.port_name] ;
    
    
    if (self.shipCellStyle == ZFJShipTableViewCellStyleOne) {
        self.priceLabel.frame = CGRectMake(ViewX(_titleLbel), ViewY(_setSailCityLabel) + ViewHeight(_setSailCityLabel), [self returnTextCGRectText:priceStr textFont:16 cGSize:CGSizeMake(0, M_SHIP_ICON_WIDTH / 4)].size.width, M_SHIP_ICON_WIDTH / 4);
        
        self.startLabel.frame = CGRectMake(ViewWidth(_priceLabel) + ViewX(_priceLabel),  ViewY(_setSailCityLabel) + ViewHeight(_setSailCityLabel), 30, M_SHIP_ICON_WIDTH / 4);
        
        _gj_commissionLab.frame=CGRectMake(ViewWidth(_startLabel)+ViewX(_startLabel), ViewY(_startLabel), windowContentWidth-200, ViewHeight(_startLabel));
        
    } else if (self.shipCellStyle == ZFJShipTableViewCellStyleTwo){
        
        setSailCityStr = [NSString stringWithFormat:@"%@出发", shipListModels.port_name];
        
        
        self.titleLbel.frame = CGRectMake(15, ViewY(_iconImageView) + ViewHeight(_iconImageView) + 5, windowContentWidth - 30, [self returnTextCGRectText:shipListModels.product_name textFont:17 cGSize:CGSizeMake(windowContentWidth - 30, 0)].size.height);
        
        self.priceLabel.frame = CGRectMake(15, ViewY(_titleLbel) + ViewHeight(_titleLbel), [self returnTextCGRectText:priceStr textFont:16 cGSize:CGSizeMake(0, M_SHIP_ICON_WIDTH / 4)].size.width, 25);
        self.startLabel.frame = CGRectMake(ViewWidth(_priceLabel) + ViewX(_priceLabel),  ViewY(_priceLabel), 30, 25);
        
        self.setSailCityLabel.frame = CGRectMake(windowContentWidth - 15 - [self returnTextCGRectText:setSailCityStr textFont:12 cGSize:CGSizeMake(0, 25)].size.width, ViewY(_titleLbel) + ViewHeight(_titleLbel), [self returnTextCGRectText:setSailCityStr textFont:12 cGSize:CGSizeMake(0, 25)].size.width, 25);
        
        _gj_commissionLab.frame=CGRectMake(ViewWidth(_startLabel)+ViewX(_startLabel), ViewY(_startLabel), windowContentWidth-200, ViewHeight(_startLabel));
        
    } else if (self.shipCellStyle == ZFJShipTableViewCellStyleThree){
        
        self.setSailCityLabel.frame = CGRectMake(ViewX(_titleLbel), ViewHeight(_iconImageView) + ViewY(_iconImageView) - M_SHIP_ICON_WIDTH / 4, [self returnTextCGRectText:setSailCityStr textFont:12 cGSize:CGSizeMake(0, M_SHIP_ICON_WIDTH / 4)].size.width, M_SHIP_ICON_WIDTH / 4);
        self.setSailCityLabel.textColor = kColor(115, 115, 120);
        self.setSailCityLabel.font = [UIFont systemFontOfSize:12];
        
        self.priceLabel.frame =CGRectMake( windowContentWidth - 150, ViewY(self.iconImageView)+ViewHeight(self.iconImageView)-20, 140, 20);
        self.priceLabel.font = [UIFont systemFontOfSize:18];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.textColor = kColor(255, 102, 0);
        // self.startLabel.frame = CGRectMake(ViewWidth(_priceLabel) + ViewX(_priceLabel),  ViewY(_priceLabel) , 30, M_SHIP_ICON_WIDTH / 4);
        
        _gj_commissionLab.frame= CGRectMake(windowContentWidth-150, ViewY(_priceLabel)-20, 135, 15);
        _gj_commissionLab.font = [UIFont systemFontOfSize:10];
        _gj_commissionLab.textAlignment = NSTextAlignmentRight;
        _gj_commissionLab.textColor =kColor(255, 102, 0);
        
        
        //   _gj_commissionLab.frame=CGRectMake(ViewX(_setSailCityLabel) + ViewWidth(_setSailCityLabel) , ViewY(_startLabel), ViewX(_priceLabel) - ViewX(_setSailCityLabel) - ViewWidth(_setSailCityLabel), M_SHIP_ICON_WIDTH / 4);
    }
    
    _gj_commissionLab.text= [NSString stringWithFormat:@"返佣:￥%@", [self judgeReturnString:shipListModels.gj_commission withReplaceString:@"0.00"]];
    
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]){
        [self.contentView addSubview:_gj_commissionLab];
    } else {
        [self.gj_commissionLab removeFromSuperview];
        
    }
    
    self.titleLbel.text = shipListModels.product_name;
    self.priceLabel.text = priceStr;
    self.setSailCityLabel.text = setSailCityStr;
    
    
    CGRect cellRect = self.frame;
    cellRect.size.height = ViewY(_priceLabel) + ViewHeight(_priceLabel) + 10;
    self.frame = cellRect;
}



- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font cGSize:(CGSize)cGSize
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:cGSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
