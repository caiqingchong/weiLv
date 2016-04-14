//
//  CSFilterConditionTableViewCell.m
//  WelLv
//
//  Created by nick on 16/3/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSFilterConditionTableViewCell.h"

@implementation CSFilterConditionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setLayoutWithFilterConditions:(NSArray *)conditions indexPath:(NSIndexPath *)indexPath andSelectedIndexPathRow:(NSInteger)row {
    
    CGFloat originX = (CONDITION_CELL_WIDTH - ICON_SIZE - MARGIN_WIDTH - 60) / 2;
    
    //综合筛选条件图标
    UIImageView *conditionIcon = [[UIImageView alloc] initWithFrame:CGRectMake(originX, (self.frame.size.height - ICON_SIZE) / 2, ICON_SIZE, ICON_SIZE)];
    
    [self.contentView addSubview:conditionIcon];
    
    //综合筛选条件名称
    UILabel *conditionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(conditionIcon.frame) + MARGIN_WIDTH, 0, 60, self.frame.size.height)];
    
    conditionNameLabel.text = [[conditions objectAtIndex:indexPath.row] objectAtIndex:1];
    
    conditionNameLabel.font = [UIFont systemFontOfSize:15.0];
    
    [self.contentView addSubview:conditionNameLabel];
    
    //选中状态
    if(indexPath.row == row){
        
        self.backgroundColor = [UIColor whiteColor];
        
        conditionIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", [[conditions objectAtIndex:indexPath.row] objectAtIndex:0]]];
        
        conditionNameLabel.textColor = kColor(241.0, 161.0, 126.0);
        
    }else{
        
        self.backgroundColor = kColor(223.0, 230.0, 236.0);
    
        conditionIcon.image = [UIImage imageNamed:[[conditions objectAtIndex:indexPath.row] objectAtIndex:0]];
        
        conditionNameLabel.textColor = kColor(173.0, 180.0, 185.0);
    }
}

@end
