//
//  CSFilterDetailTableViewCell.m
//  WelLv
//
//  Created by nick on 16/3/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSFilterDetailTableViewCell.h"

@implementation CSFilterDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setLayoutWithConditionDetails:(NSArray *)details indexPath:(NSIndexPath *)indexPath selectedConditionRow:(NSInteger)crow andSelectedDetailRows:(NSDictionary *)drows {

    //筛选条件详情名称
    UILabel *detailNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_WIDTH * 2, 0, DETAIL_CELL_WIDTH - MARGIN_WIDTH * 4 - 5 - ICON_SIZE, self.frame.size.height)];
    
    detailNameLabel.text = [[details objectAtIndex:crow] objectAtIndex:indexPath.row];
    
    detailNameLabel.font = [UIFont systemFontOfSize:15.0];
    
    [self.contentView addSubview:detailNameLabel];
    
    //选中框
    UIImageView *selectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detailNameLabel.frame) + MARGIN_WIDTH, (self.frame.size.height - ICON_SIZE) / 2, ICON_SIZE, ICON_SIZE)];
    
    [self.contentView addSubview:selectIcon];
    
    //底边框
    CGFloat originX = detailNameLabel.frame.origin.x - 5;
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(originX, self.frame.size.height - 1, DETAIL_CELL_WIDTH - originX, 1)];
    
    bottomLine.backgroundColor = kColor(239.0, 239.0, 239.0);
    
    [self.contentView addSubview:bottomLine];
    
    //选中状态
    if(indexPath.row == [[drows objectForKey:[NSString stringWithFormat:@"%li", crow]] integerValue]){
    
        detailNameLabel.textColor = kColor(241.0, 161.0, 126.0);
        
        selectIcon.image = [UIImage imageNamed:@"cs_filter_selected"];
        
    }else{
    
        detailNameLabel.textColor = kColor(173.0, 180.0, 185.0);
        
        selectIcon.image = [UIImage imageNamed:@"cs_filter_unselected"];
    }
}

@end
