//
//  CustomInfoCell.m
//  WelLv
//
//  Created by mac for csh on 15/4/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "CustomInfoCell.h"

@implementation CustomInfoCell
@synthesize realnameLabel,IdnumberLabel,imageLabel,idtypeLabel,sexLabel,phoneLabel,emailLabel,custom,button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 60);
        self.backgroundColor = [UIColor whiteColor];
        realnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [[UIScreen mainScreen] bounds].size.width-20, 25)];
        //  realnameLabel.text = custom.realname;
        realnameLabel.textColor = kColor(41, 41, 41);
        realnameLabel.textAlignment = NSTextAlignmentLeft;
        realnameLabel.font = [UIFont systemFontOfSize:16];
        
        IdnumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, [[UIScreen mainScreen] bounds].size.width-25, 25)];
        //  IdnumberLabel.text = custom.Idnumbr;
        IdnumberLabel.textColor = kColor(85, 90, 96);
        IdnumberLabel.textAlignment = NSTextAlignmentLeft;
        IdnumberLabel.font = [UIFont systemFontOfSize:13];
        
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
        
        UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -40, 60/2- 26.7/2, 40, 26.7)];
        [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [self addSubview:IGV];
        
        //         button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button setFrame:CGRectMake(ViewWidth(self)-20 - 25, ViewHeight(self)/2-13 , 25, 26)];
        //        [button setImage:[UIImage imageNamed:@"修改资料按钮"] forState:UIControlStateNormal];
        //        [self addSubview:button];
    }
    
    
    return self;
}

-(void)setCustom:(CustomInfo *)csm{
//    NSArray *arr = @[@"未知",@"身份证",@"护照",@"军官证",@"港澳通行证",@"台胞证"];
    if (!(csm.to_username == nil || [csm.to_username isEqual:[NSNull null]])) {
        realnameLabel.text = csm.to_username;
    }
//    if(!(csm.id_type == nil || [csm.id_type isEqual:[NSNull null]]) && !(csm.id_number == nil || [csm.id_number isEqual:[NSNull null]])){
        // NSLog(@"%@",[arr objectAtIndex:[csm.Idtype integerValue]]);
        IdnumberLabel.text = [NSString stringWithFormat:@"手机号:%@",csm.phone];
    //}
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
