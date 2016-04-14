//
//  ZFJVisaTableViewCell.m
//  WelLv
//
//  Created by 张发杰 on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJVisaTableViewCell.h"
#import "IamgeAndLabelView.h"
#import "ZFJVisaModel.h"
#import "LXUserTool.h"
#import "UIDefines.h"
#define ICON_TOP 10
#define ICON_LEFT 15
#define ICON_WIDTH 75

#define WIDTH_GAP 10 //间距

#define TITLE_HEIGHT 20
@implementation ZFJVisaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self coustomView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStyle:(ZFJVisaTableViewCellStyle)cellStyle{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellStyle = cellStyle;
        if (cellStyle == ZFJVisaTableViewCellStyleOne) {
            [self coustomView];
        } else if (cellStyle == ZFJVisaTableViewCellStyleTwo){
            [self customNewView];
        }else if (cellStyle == ZFJVisaTableViewCellStyleThree){
            
        }
    }
    return self;
}



- (void)coustomView
{
    //NSLog(@"%f", self.frame.size.height);
    self.iconCountryImage = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_LEFT, ICON_TOP, ICON_WIDTH, ICON_WIDTH)];
    self.iconCountryImage.layer.cornerRadius = 5;
    self.iconCountryImage.layer.masksToBounds = YES;
    self.iconCountryImage.contentMode = UIViewContentModeScaleAspectFill;
    self.iconCountryImage.clipsToBounds = YES;
    
    self.iconCountryImage.backgroundColor = [UIColor cyanColor];
    [self.iconCountryImage sd_setImageWithURL:[NSURL URLWithString:@"http://webmap1.map.bdimg.com/maps/services/thumbnails?width=525&height=295&quality=100&align=middle,middle&src=http://hiphotos.baidu.com/lvpics/pic/item/241f95cad1c8a7866cd26aaf6709c93d71cf5092.jpg"]];
    [self addSubview:_iconCountryImage];
    
    self.visaListNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP, windowContentWidth - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, TITLE_HEIGHT)];
    //self.visaListNameLabel.backgroundColor = [UIColor purpleColor];
    self.visaListNameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_visaListNameLabel];
    
    self.LengthOfTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP + TITLE_HEIGHT, windowContentWidth - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, TITLE_HEIGHT )];
    self.LengthOfTimeLabel.font = [UIFont systemFontOfSize:13];
    self.LengthOfTimeLabel.text = @"单次入境  最长停留15天";
    self.LengthOfTimeLabel.textColor = [UIColor grayColor];
    [self addSubview:_LengthOfTimeLabel];
    
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP , ICON_TOP + TITLE_HEIGHT * 2, 60, TITLE_HEIGHT)];
    self.priceLabel.text = @"¥123";
    self.priceLabel.textColor = kColor(255, 96, 126);
    [self addSubview:_priceLabel];
    
    self.startLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.frame.origin.x + self.priceLabel.frame.size.width, ICON_TOP + TITLE_HEIGHT * 2 + 5, 50, TITLE_HEIGHT - 5)];
    _startLabel.text = @"起";
    _startLabel.textColor = [UIColor grayColor];
    _startLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_startLabel];
    
    self.stewardPrice = [[UILabel alloc] init];
    _stewardPrice.textColor =  kColor(255, 96, 126);
    //_stewardPrice.backgroundColor = [UIColor orangeColor];
    _stewardPrice.textAlignment = NSTextAlignmentRight;
    LXUserTool * user = [[LXUserTool alloc] init];
    if ([[user getuserGroup] isEqualToString:@"assistant"] ) {
        [self addSubview:_stewardPrice];
    }
    
    self.imageAndLabelView = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP + TITLE_HEIGHT * 3, self.frame.size.width - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, TITLE_HEIGHT - 5)];
    self.imageAndLabelView.infoLanel.text = @"3个月有效期";
    self.imageAndLabelView.iconIamge.image = [UIImage imageNamed:@"有效期"];
    self.imageAndLabelView.iconIamge.frame = CGRectMake(5, 2.5, TITLE_HEIGHT - 8, TITLE_HEIGHT - 8);
    self.imageAndLabelView.infoLanel.font = [UIFont systemFontOfSize:12];
    self.imageAndLabelView.infoLanel.textColor = [UIColor grayColor];
    [self addSubview:_imageAndLabelView];
}



- (void)customNewView{
    self.iconCountryImage = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_LEFT, ICON_TOP, ICON_WIDTH, ICON_WIDTH)];
    self.iconCountryImage.layer.cornerRadius = 5;
    self.iconCountryImage.layer.masksToBounds = YES;
    self.iconCountryImage.contentMode = UIViewContentModeScaleAspectFill;
    self.iconCountryImage.clipsToBounds = YES;
    [self addSubview:self.iconCountryImage];
    
    
    self.visaListNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP, windowContentWidth - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, ICON_WIDTH / 2)];
    self.visaListNameLabel.numberOfLines = 2;
    self.visaListNameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_visaListNameLabel];
    
    
    UILabel * doVisaTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.visaListNameLabel), ICON_TOP + ICON_WIDTH / 2, [self returnTextCGRectText:@"办理周期：" textFont:13 cGSize:CGSizeMake(0, ICON_WIDTH / 4)].size.width, ICON_WIDTH / 4)];
    doVisaTimeLabel.text = @"办理周期：";
    doVisaTimeLabel.font = [UIFont systemFontOfSize:10];
    doVisaTimeLabel.textColor = [UIColor grayColor];
    [self addSubview:doVisaTimeLabel];
    
    self.LengthOfTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(doVisaTimeLabel)-20, ViewY(doVisaTimeLabel), windowContentWidth - ViewRight(doVisaTimeLabel), ICON_WIDTH / 4)];
    self.LengthOfTimeLabel.textColor = [UIColor colorWithRed:112 /255.0 green:168 /255.0 blue:254 /255.0 alpha:1.0];
    self.LengthOfTimeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.LengthOfTimeLabel];
    
    
  UILabel * interviewLanel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(doVisaTimeLabel), ViewBelow(doVisaTimeLabel), [self returnTextCGRectText:@"面试：" textFont:10 cGSize:CGSizeMake(0, ICON_WIDTH / 4)].size.width, ICON_WIDTH / 4)];
//    UILabel * interviewLanel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.visaListNameLabel), ViewBelow(doVisaTimeLabel), [self returnTextCGRectText:@"面试：" textFont:10 cGSize:CGSizeMake(0, ICON_WIDTH / 4)].size.width, ICON_WIDTH / 4)];
    interviewLanel.text = @"面试：";
    interviewLanel.font = [UIFont systemFontOfSize:10];
    interviewLanel.textColor = kColor(115, 115, 120);
    [self addSubview:interviewLanel];
    
    self.isNeedInterview = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(interviewLanel), ViewY(interviewLanel), [self returnTextCGRectText:@"不需要" textFont:10 cGSize:CGSizeMake(0, ICON_WIDTH / 4)].size.width, ICON_WIDTH / 4)];
    self.isNeedInterview.textColor = kColor(115, 115, 120);
    self.isNeedInterview.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.isNeedInterview];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = kColor(255, 102, 0);
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.frame = CGRectMake( windowContentWidth - 150, ViewY(self.iconCountryImage)+ViewHeight(self.iconCountryImage)-20, 140, 20);
    [self addSubview:self.priceLabel];
    
    self.startLabel = [[UILabel alloc] init];
    self.startLabel.text = @"起";
    self.startLabel.textColor = [UIColor grayColor];
    self.startLabel.font = [UIFont systemFontOfSize:12];
   // [self addSubview:self.startLabel];
    
    self.stewardPrice = [[UILabel alloc] init];
    self.stewardPrice.frame = CGRectMake(windowContentWidth -150, ViewY(_priceLabel)-20, 135, 15);
    self.stewardPrice.font = [UIFont systemFontOfSize:10];
    _stewardPrice.textColor =  kColor(255, 102, 0);
    _stewardPrice.textAlignment = NSTextAlignmentRight;
    LXUserTool * user = [[LXUserTool alloc] init];
    if ([[user getuserGroup] isEqualToString:@"assistant"] ) {
        [self addSubview:_stewardPrice];
    }
}


- (void)setVisaModel:(ZFJVisaModel *)visaModel
{
    
    if ([visaModel.index_thumb hasPrefix:@"http"]) {
        [self.iconCountryImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", visaModel.index_thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
        
    } else{
        [self.iconCountryImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", WLHTTP, visaModel.index_thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }
    self.visaListNameLabel.text = visaModel.product_name;

    
    if (self.cellStyle == ZFJVisaTableViewCellStyleOne) {
        
        self.LengthOfTimeLabel.text = [NSString stringWithFormat:@"%@  %@", visaModel.enter_times, visaModel.stay];
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@ ",[self judgeReturnString:visaModel.sell_price withReplaceString:@"0.00"]];
        
        self.priceLabel.frame = CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP , ICON_TOP + TITLE_HEIGHT * 2, [self returnTextCGRectText:self.priceLabel.text textFont:17].size.width, TITLE_HEIGHT);
        self.startLabel.frame = CGRectMake(self.priceLabel.frame.origin.x + self.priceLabel.frame.size.width, ICON_TOP + TITLE_HEIGHT * 2 + 5, 20, TITLE_HEIGHT - 5);
        //self.startLabel.backgroundColor = [UIColor blueColor];
        self.stewardPrice.frame = CGRectMake(_startLabel.frame.origin.x + self.startLabel.frame.size.width + 5, ICON_TOP + TITLE_HEIGHT * 2, 100, TITLE_HEIGHT);
        self.stewardPrice.text = [NSString stringWithFormat:@"返佣：¥%@", visaModel.commission];
        //    UILabel * startLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.frame.origin.x + self.priceLabel.frame.size.width, ICON_TOP + TITLE_HEIGHT * 2 + 5, 50, TITLE_HEIGHT - 5)];
        //    startLabel.text = @"起";
        //    startLabel.textColor = [UIColor grayColor];
        //    startLabel.font = [UIFont systemFontOfSize:12];
        //    [self addSubview:startLabel];
        
        if (![[[LXUserTool alloc] getHouseAdmin_id] isEqualToString:visaModel.admin_id]) {
            //NSLog(@"***%@******%@***", [LXUserTool sharedUserTool].admin_id, visaModel.admin_id);
            [self.stewardPrice removeFromSuperview];
        } else if ([[[[LXUserTool alloc] init] getuserGroup] isEqualToString:@"assistant"]) {
            [self addSubview:self.startLabel];
        }
        self.imageAndLabelView.infoLanel.text = [NSString stringWithFormat:@"%@有效期", visaModel.active_times];
        
        
        
    } else if (self.cellStyle == ZFJVisaTableViewCellStyleTwo){
        
        self.visaListNameLabel.frame = CGRectMake(ICON_WIDTH + ICON_LEFT + WIDTH_GAP, ICON_TOP, windowContentWidth - ICON_WIDTH - ICON_LEFT * 2 - WIDTH_GAP, ICON_WIDTH / 2);
        [self.visaListNameLabel sizeToFit];
        
        NSString * visaBook_date = @"";
        
        if (visaModel.deal_time.length == 1) {
            visaBook_date = [NSString stringWithFormat:@"%@个工作日", visaModel.deal_time];
        } else{
            visaBook_date = [[[[visaModel.deal_time componentsSeparatedByString:@"（"] objectAtIndex:0] componentsSeparatedByString:@"("] objectAtIndex:0];
            
        }
        self.LengthOfTimeLabel.text = visaBook_date;
        
        
       
        if ([visaModel.interview isEqual:@"0"]) {
            self.isNeedInterview.text = @"不需要";

        } else if ([visaModel.interview isEqual:@"1"]){
            self.isNeedInterview.text = @"需要";
        }

        
       // CGFloat priceWidth = [self returnTextCGRectText:[NSString stringWithFormat:@"¥%@ ", visaModel.sell_price] textFont:17 cGSize:CGSizeMake(0, ICON_WIDTH / 4)].size.width;
       // self.priceLabel.frame = CGRectMake(windowContentWidth  -  priceWidth - WIDTH_GAP - [self returnTextCGRectText:@"起" textFont:12 cGSize:CGSizeMake(0, ICON_WIDTH / 4)].size.width, ViewBelow(self.LengthOfTimeLabel), priceWidth, ICON_WIDTH / 4);
        self.priceLabel.backgroundColor = [UIColor whiteColor];
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@", [self judgeReturnString:visaModel.sell_price withReplaceString:@"0.00"]];

        self.startLabel.frame = CGRectMake(ViewRight(self.priceLabel), ViewY(self.priceLabel), [self returnTextCGRectText:@"起" textFont:12 cGSize:CGSizeMake(0, ICON_WIDTH / 4)].size.width, ViewHeight(self.priceLabel));
        
        //CGFloat starX = ViewRight(self.isNeedInterview);
        //CGFloat endX = ViewX(self.priceLabel);
       // self.stewardPrice.frame = CGRectMake(ViewRight(self.isNeedInterview), ViewY(self.isNeedInterview), endX - starX, ICON_WIDTH / 4);
        
        self.stewardPrice.text = [NSString stringWithFormat:@"返佣:¥%@", [self judgeReturnString:visaModel.commission withReplaceString:@"0.0"]];
      
        
        //[self.stewardPrice sizeToFit];
        self.stewardPrice.adjustsFontSizeToFitWidth= YES;
        self.stewardPrice.backgroundColor = [UIColor whiteColor];
//        if (![[[LXUserTool alloc] getHouseAdmin_id] isEqualToString:visaModel.admin_id]) {
//            [self.stewardPrice removeFromSuperview];
//        } else
        
        if ([[[[LXUserTool alloc] init] getuserGroup] isEqualToString:@"assistant"]) {
            [self addSubview:self.stewardPrice];
        }

    } else if (self.cellStyle == ZFJVisaTableViewCellStyleThree){
        
    }
    
    
}


- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, TITLE_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
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
