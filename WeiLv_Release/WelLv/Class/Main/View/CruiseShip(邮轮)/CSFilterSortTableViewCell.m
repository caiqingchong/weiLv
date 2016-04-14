//
//  CSFilterSortTableViewCell.m
//  WelLv
//
//  Created by nick on 16/3/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSFilterSortTableViewCell.h"

@implementation CSFilterSortTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setLayoutWithSortOptions:(NSArray *)options indexPath:(NSIndexPath *)indexPath andSelectedSortRow:(NSInteger)row {

    //排序图标
    UIImageView *sortIcon = [[UIImageView alloc] init];
    
    [self.contentView addSubview:sortIcon];
    
    //排序名称
    CGFloat nameOriginX;
    
    if(indexPath.row == 0){
        
        sortIcon.frame = CGRectMake(MARGIN_WIDTH * 2, (self.frame.size.height - ICON_SIZE) / 2, ICON_SIZE + 5, ICON_SIZE);
        
        nameOriginX = CGRectGetMaxX(sortIcon.frame) + MARGIN_WIDTH;
        
    }else{
        
        sortIcon.frame = CGRectMake(MARGIN_WIDTH * 2, (self.frame.size.height - ICON_SIZE) / 2, ICON_SIZE, ICON_SIZE);
        
        nameOriginX = CGRectGetMaxX(sortIcon.frame) + MARGIN_WIDTH + 5;
    }
    
    UILabel *sortNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameOriginX, 0, SCREEN_WIDTH - nameOriginX - MARGIN_WIDTH * 2 - 5 - ICON_SIZE, self.frame.size.height)];
    
    sortNameLabel.text = [[options objectAtIndex:indexPath.row] objectAtIndex:1];
    
    sortNameLabel.font = [UIFont systemFontOfSize:15.0];
    
    [self.contentView addSubview:sortNameLabel];
    
    //选中框
    UIImageView *selectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sortNameLabel.frame) + MARGIN_WIDTH, (self.frame.size.height - ICON_SIZE) / 2, ICON_SIZE, ICON_SIZE)];
    
    [self.contentView addSubview:selectIcon];
    
    //底边框
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, SCREEN_WIDTH, 1)];
    
    bottomLine.backgroundColor = kColor(239.0, 239.0, 239.0);
    
    [self.contentView addSubview:bottomLine];
    
    //选中状态
    if(indexPath.row == row){
    
        sortIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", [[options objectAtIndex:indexPath.row] objectAtIndex:0]]];
        
        sortNameLabel.textColor = kColor(241.0, 161.0, 126.0);
        
        selectIcon.image = [UIImage imageNamed:@"cs_filter_selected"];
        
    }else{
    
        sortIcon.image = [UIImage imageNamed:[[options objectAtIndex:indexPath.row] objectAtIndex:0]];
        
        sortNameLabel.textColor = kColor(173.0, 180.0, 185.0);
        
        selectIcon.image = [UIImage imageNamed:@"cs_filter_unselected"];
    }
}

@end
