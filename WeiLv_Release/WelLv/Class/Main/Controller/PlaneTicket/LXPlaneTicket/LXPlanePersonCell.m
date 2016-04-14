//
//  LXPlanePersonCell.m
//  WelLv
//
//  Created by liuxin on 15/9/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXPlanePersonCell.h"

@implementation LXPlanePersonCell
@synthesize realnameLabel,IdnumberLabel,imageLabel,idtypeLabel,sexLabel,phoneLabel,emailLabel,custom,button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65);
        self.backgroundColor = [UIColor whiteColor];
        realnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, [[UIScreen mainScreen] bounds].size.width-20, 25)];
        //  realnameLabel.text = custom.realname;
        realnameLabel.textColor = [UIColor blackColor];
        realnameLabel.textAlignment = NSTextAlignmentLeft;
        realnameLabel.font = [UIFont systemFontOfSize:15];
        
        IdnumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, [[UIScreen mainScreen] bounds].size.width-25, 25)];
        //  IdnumberLabel.text = custom.Idnumbr;
        IdnumberLabel.textColor = [UIColor lightGrayColor];
        IdnumberLabel.textAlignment = NSTextAlignmentLeft;
        IdnumberLabel.font = [UIFont systemFontOfSize:15];
        
        /* idtypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, [[UIScreen mainScreen] bounds].size.width-60, 25)];
         idtypeLabel.text = custom.Idtype;
         idtypeLabel.tintColor = [UIColor lightGrayColor];
         idtypeLabel.textAlignment = NSTextAlignmentLeft;
         idtypeLabel.font = [UIFont systemFontOfSize:13];
         
         phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, [[UIScreen mainScreen] bounds].size.width-60, 25)];
         phoneLabel.text = custom.phoneNumber;
         phoneLabel.tintColor = [UIColor lightGrayColor];
         phoneLabel.textAlignment = NSTextAlignmentLeft;
         phoneLabel.font = [UIFont systemFontOfSize:13];
         
         sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, [[UIScreen mainScreen] bounds].size.width-60, 25)];
         sexLabel.text = custom.sex;
         sexLabel.tintColor = [UIColor lightGrayColor];
         sexLabel.textAlignment = NSTextAlignmentLeft;
         sexLabel.font = [UIFont systemFontOfSize:13];
         
         emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, [[UIScreen mainScreen] bounds].size.width-60, 25)];
         emailLabel.text = custom.email;
         emailLabel.tintColor = [UIColor lightGrayColor];
         emailLabel.textAlignment = NSTextAlignmentLeft;
         emailLabel.font = [UIFont systemFontOfSize:13];
         */
        [self addSubview:realnameLabel];
        [self addSubview:IdnumberLabel];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(ViewWidth(self)-20 - 25, ViewHeight(self)/2-13 , 25, 26)];
        [button setImage:[UIImage imageNamed:@"修改资料按钮"] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    
    
    return self;
}

-(void)setCustom:(LXPlanePersonModel *)csm{
    NSArray *arr = @[@"身份证",@"护照",@"港澳通行证",@"台胞证"];
    if (!(csm.name == nil || [csm.name isEqual:[NSNull null]])) {
        realnameLabel.text = csm.name;
    }
    if(!(csm.card_type == nil || [csm.card_type isEqual:[NSNull null]]) && !(csm.card_no == nil || [csm.card_no isEqual:[NSNull null]])){
        // NSLog(@"%@",[arr objectAtIndex:[csm.Idtype integerValue]]);
        IdnumberLabel.text = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:[csm.card_type integerValue]],csm.card_no];
    }
}

//-(void)setIsSelect:(BOOL)isSelect
//{
//    if (isSelect==YES) {
//        _isSelect=NO;
//        //LXPlanePersonModel *model=[cusInfoArray objectAtIndex:indexPath.row];
//        //[_selectCommonContactArray addObject:model];
//        self.imageView.image=[UIImage imageNamed:@"选中圆圈"];
//        //DLog(@"1cell.select==%d",cell.isSelected);
//    }
//    else if (isSelect==NO){
//        _isSelect=YES;
//        //[_selectCommonContactArray removeObjectAtIndex:indexPath.row];
//        self.imageView.image=[UIImage imageNamed:@"未选中圆圈"];
//    }
//}

//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
