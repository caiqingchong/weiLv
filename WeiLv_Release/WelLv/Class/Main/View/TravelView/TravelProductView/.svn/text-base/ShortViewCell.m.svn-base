//
//  ShortViewCell.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/19.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "ShortViewCell.h"

#import "ProductModel.h"


#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation ShortViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addControl];
        
    }
    return self;
}

- (void)addControl{

  
    
    
}
//调用为cell 上子控件赋值的方法
- (void)assignValueWithModel:(ProductModel *)model{
    
    self.lineLable = [[UILabel alloc]init];
    
//    if ([self judgeString:model.picture] == YES) {
//        self.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , 0, 0.4, [ShortViewCell cellHeight:model] + UISCREEN_HEIGHT / 7.88);
//    }else{
//        self.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , 0, 0.4, [ShortViewCell cellHeight:model]);
//    }
    self.lineLable.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.lineLable];

    
    self.locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40, UISCREEN_HEIGHT / 30, UISCREEN_WIDTH / 17.58, UISCREEN_HEIGHT / 22.36)];
    self.locationImage.image = [UIImage imageNamed:@"定位"];
    
    self.dayLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.locationImage.frame) + UISCREEN_WIDTH / 40, UISCREEN_HEIGHT / 30, UISCREEN_WIDTH - UISCREEN_WIDTH / 4.57, 0)];
    self.dayLable.text = @"第1天   郑州-昆明";
    self.dayLable.numberOfLines = 0;
    self.dayLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.85];
    [self.contentView addSubview:self.dayLable];
    
    self.dayLable.text  = [NSString stringWithFormat:@"第%@天  %@",model.day,model.title];
    CGRect dayRect = self.dayLable.frame;
    dayRect.size.height = [[self class] heightOfDayLable:model.title];
    self.dayLable.frame = dayRect;
    
    NSArray *pictureArr = @[@"酒店",@"餐饮"];
    for (int i = 0; i < pictureArr.count; i++) {
        self.pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.dayLable.frame), CGRectGetMaxY(self.dayLable.frame) + UISCREEN_HEIGHT / 35.5 / 2 + i * (UISCREEN_HEIGHT/ 28.4 + UISCREEN_HEIGHT / 43.69), UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 16)];
        self.pictureImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",pictureArr[i]]];
        [self.contentView addSubview:self.pictureImage];
    }
    
    [self.contentView addSubview:self.locationImage];
    
    
    
    //    //发车时间
    //    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImage.frame) + UISCREEN_WIDTH / 40, CGRectGetMaxY(self.dayLable.frame) + UISCREEN_HEIGHT /35.5 / 2 , UISCREEN_WIDTH - UISCREEN_WIDTH / 6, UISCREEN_WIDTH / 16)];
    //    self.timeLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
    //    self.timeLable.textColor = [UIColor grayColor];
    //    [self.contentView addSubview:self.timeLable];
    
    // 酒店
    self.hotelLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImage.frame) + UISCREEN_WIDTH / 40, CGRectGetMaxY(self.dayLable.frame) + UISCREEN_HEIGHT /35.5 / 2 , UISCREEN_WIDTH - UISCREEN_WIDTH / 6, UISCREEN_WIDTH / 16)];
    self.hotelLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
    self.hotelLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.hotelLable];
    
    //餐饮
    self.foodLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImage.frame) + UISCREEN_WIDTH / 40, CGRectGetMaxY(self.dayLable.frame) + UISCREEN_HEIGHT /35.5 / 2 +UISCREEN_HEIGHT/ 28.4 + UISCREEN_HEIGHT / 43.69, UISCREEN_WIDTH - UISCREEN_WIDTH / 6, UISCREEN_WIDTH / 16)];
    self.foodLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH  / 26.66];
    self.foodLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.foodLable];
    
    
    self.timeLable.text = [NSString stringWithFormat:@"发车时间:%@出发  %@到达",model.add_time,model.upd_time];
    if (model.room != nil) {
        self.hotelLable.text = [NSString stringWithFormat:@"酒店:%@",model.room];
    }else{
        self.hotelLable.text = @"酒店:自理";
    }
    
    
    //早餐
    NSString *breakStr = [model.breakfast isEqualToString:@"1"] ? @"提供":@"自理";
    //中餐
    NSString *lunchStr = [model.lunch isEqualToString:@"1"] ? @"提供":@"自理";
    //晚餐
    NSString *dinnerStr = [model.dinner isEqualToString:@"1"] ? @"提供":@"自理";
    
    self.foodLable.text = [NSString stringWithFormat:@"早餐:%@  午餐:%@  晚餐:%@",breakStr,lunchStr,dinnerStr];
    
    
    self.webLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 10, CGRectGetMaxY(self.foodLable.frame) + 5 ,UISCREEN_WIDTH - UISCREEN_WIDTH / 4.57 , 0)];
    NSString *htmlStr = model.activities;
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    self.webLable.text = attrStr.string;
    self.webLable.numberOfLines = 0;
    self.webLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
    self.webLable.textColor = [UIColor colorWithRed:109/255.0 green:113/255.0 blue:118/255.0 alpha:1.0];
    //赋值完成之后,重新计算 webLable 的大小
    CGRect webRect = self.webLable.frame;
    //修改 webLable 的高
    webRect.size.height = [[self class] heigthOfwebLable:attrStr.string];
    //修改后重新赋值
    self.webLable.frame = webRect;
    [self.contentView addSubview:self.webLable];
    
}


+ (CGFloat)cellHeight:(ProductModel *)model{
    
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[model.activities dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSString *str = attrStr.string;
    CGFloat webLableHeight = [self heigthOfwebLable:str] + [self heightOfDayLable:model.title];
    
    return webLableHeight + UISCREEN_HEIGHT / 6.6 + 5;
    
}

+ (CGFloat)heigthOfwebLable:(NSString *)height{
    
    CGSize contextSize = CGSizeMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 4.57, 0);
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66]};
    CGRect webRect = [height boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return webRect.size.height;
    
    
}

+ (CGFloat)heightOfDayLable:(NSString *)dayHeight{
    
    CGSize contextSize = CGSizeMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 4.57, 0);
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:UISCREEN_WIDTH / 22.85]};
    CGRect webRect = [dayHeight boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return webRect.size.height;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
