//
//  ContentTableViewCell.m
//  WelLv
//
//  Created by 赵阳 on 16/2/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];

        //图片
        self.cellImageView = [[UIImageView alloc]initForAutoLayout];

        [self addSubview:self.cellImageView];

        [self.cellImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:10];

        [self.cellImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];

        [self.cellImageView  autoSetDimensionsToSize:CGSizeMake(60, 60)];
        
        // 支付方式
        
        self.payWayLabel = [[UILabel alloc]initForAutoLayout];
        self.payWayLabel.backgroundColor = [UIColor redColor];
        self.payWayLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.payWayLabel.textAlignment = NSTextAlignmentCenter;
        self.payWayLabel.textColor = [UIColor whiteColor];
        self.payWayLabel.font = [UIFont systemFontOfSize:9];        
        [self.cellImageView addSubview:self.payWayLabel];
        
        [self.payWayLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.cellImageView withOffset:0];
        [self.payWayLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.cellImageView withOffset:0];
        [self.payWayLabel autoSetDimensionsToSize:CGSizeMake(45, 20)];
        
        
        //标题
        self.titleLabel = [[UILabel alloc]initForAutoLayout];
        
        [self addSubview:self.titleLabel];
        
        [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cellImageView withOffset:15];
        
        [self.titleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-15];
        
        [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];
        
        self.titleLabel.numberOfLines = 2;
        
        
        //目的地名称
        self.addressLabel = [[UILabel alloc]initForAutoLayout];
        
        [self addSubview:self.addressLabel];
        
        [self.addressLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cellImageView withOffset:15];
        
        [self.addressLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-10];
        
        self.addressLabel.alpha = 0.7;

        /*
        //目的地注释
        self.noteLabel = [[UILabel alloc]initForAutoLayout];
        
        [self addSubview:self.noteLabel];
        
        [self.noteLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.addressLabel withOffset:1];
        
        [self.noteLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-10];
        
        [self.noteLabel  autoSetDimensionsToSize:CGSizeMake(30, 12)];

        self.noteLabel.text = @" 参团";
        
        self.noteLabel.alpha = 0.7;
        */
        
        //参团费用
        self.expensesLabel = [[UILabel alloc]initForAutoLayout];
        
        [self addSubview:self.expensesLabel];
        
        [self.expensesLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-15];
        
        [self.expensesLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-7];
        
        [self.expensesLabel  autoSetDimensionsToSize:CGSizeMake(100, 16)];
        
        self.expensesLabel.textColor = UIColorFromRGB(0xff6600);
        
        self.expensesLabel.textAlignment = NSTextAlignmentRight;

        
        //返佣金额
        self.commissionAmountLabel = [[UILabel alloc]initForAutoLayout];
        
        [self addSubview:self.commissionAmountLabel];
        
//        [self.commissionAmountLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.commissionLabel withOffset:1];
        
        [self.commissionAmountLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-15];
        
        [self.commissionAmountLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.expensesLabel withOffset:-2];
        
        [self.commissionAmountLabel  autoSetDimensionsToSize:CGSizeMake(100, 10)];
        
        self.commissionAmountLabel.textColor = UIColorFromRGB(0xff6600);
        
        self.commissionAmountLabel.textAlignment = NSTextAlignmentRight;
        
        
        //返佣
        self.commissionLabel = [[UILabel alloc]init];
        
        [self addSubview:self.commissionLabel];
        
        CGFloat widthOffSet = 0.0;
        
        if (SCREEN_WIDTH > 320) {
            widthOffSet = - 80;
        }else{
            
            widthOffSet = -70;
        }
        
        [self.commissionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self withOffset:widthOffSet];
        
        [self.commissionLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.expensesLabel withOffset:-2];
        self.commissionLabel.text = @"返佣:";
//        self.commissionLabel.backgroundColor = [UIColor redColor];
        self.commissionLabel.font = [UIFont systemFontOfSize:10.0];
        
        self.commissionLabel.alpha = 0.7;
        
        self.commissionLabel.textAlignment = NSTextAlignmentRight;
        
        
//        self.commissionLabel.frame = CGRectMake(self.frame.size.width - 50, 30, 25, 12);
        
        
        
        
        

        
//        DLog(@"11111111++++++++++++%@",NSStringFromCGRect(self.commissionAmountLabel.frame));
//        DLog(@"22222222--------------%@",NSStringFromCGRect(self.commissionLabel.frame));
        
        //cell分割线
        self.lineView = [[UIView alloc]initForAutoLayout];
        
        [self addSubview:self.lineView];
        
        [self.lineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:10];
        
        [self.lineView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-0];
        
        [self.lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:79];

        [self.lineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-0];
        
        self.lineView.backgroundColor = UIColorFromRGB(0xeef2f6);
        
        
        if (windowContentHeight == 480)
        {
            //iPhone4
            self.titleLabel.font = [UIFont systemFontOfSize:11];
            
            self.noteLabel.font = [UIFont systemFontOfSize:10];
            
            [self.addressLabel  autoSetDimensionsToSize:CGSizeMake(80, 12)];

            self.addressLabel.font = [UIFont systemFontOfSize:10];

            self.expensesLabel.font = [UIFont systemFontOfSize:14];

            self.commissionLabel.font = [UIFont systemFontOfSize:8.5];

            self.commissionAmountLabel.font = [UIFont systemFontOfSize:8.5];

        }
        else if(windowContentHeight == 568)
        {
            //iPhone5,iPhone5s,
            self.titleLabel.font = [UIFont systemFontOfSize:11];

            self.noteLabel.font = [UIFont systemFontOfSize:10];
            
            [self.addressLabel  autoSetDimensionsToSize:CGSizeMake(80, 12)];

            self.addressLabel.font = [UIFont systemFontOfSize:10];
            
            self.expensesLabel.font = [UIFont systemFontOfSize:14];

            self.commissionLabel.font = [UIFont systemFontOfSize:8.5];

            self.commissionAmountLabel.font = [UIFont systemFontOfSize:8.5];

        }
        else if (windowContentHeight == 667)
        {
            //iPhone6
            self.titleLabel.font = [UIFont systemFontOfSize:13];

            self.noteLabel.font = [UIFont systemFontOfSize:12];
            
            [self.addressLabel  autoSetDimensionsToSize:CGSizeMake(90, 12)];

            self.addressLabel.font = [UIFont systemFontOfSize:12];

            self.expensesLabel.font = [UIFont systemFontOfSize:16];

            self.commissionLabel.font = [UIFont systemFontOfSize:10];

            self.commissionAmountLabel.font = [UIFont systemFontOfSize:10];

        }
        else{
            
            //iPhone6p
            self.titleLabel.font = [UIFont systemFontOfSize:14];

            self.noteLabel.font = [UIFont systemFontOfSize:13];
            
            [self.addressLabel  autoSetDimensionsToSize:CGSizeMake(100, 12)];

            self.addressLabel.font = [UIFont systemFontOfSize:13];

            self.expensesLabel.font = [UIFont systemFontOfSize:17];

            self.commissionLabel.font = [UIFont systemFontOfSize:10];

            self.commissionAmountLabel.font = [UIFont systemFontOfSize:11];

        }
    
    }
    
    return self;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
