//
//  KeepViewController.m
//  WelLv
//
//  Created by mac for csh on 16/1/12.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "KeepViewController.h"

@interface KeepViewController ()
{
    AFHTTPRequestOperationManager *_afManger;

}
@property (nonatomic,strong)UILabel *addRessLabel;

@end

@implementation KeepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230/240.0f green:230/240.0f blue:250/240.0f alpha:1];
    
    if (_type == typeYeWu) {
        self.title = self.navTitle;
    }else
    {
        self.title = self.navTitle;
    }

    
    [self setupView];
}
-(void)setupView
{
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 100)];
    labelView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:labelView];
    
    self.addRessLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ViewWidth(labelView), ViewHeight(labelView))];
    self.addRessLabel.font = [UIFont systemFontOfSize:14];
    self.addRessLabel.numberOfLines = 0;
    
    if (_type == typeYeWu) {
     
        self.addRessLabel.text = self.keeperJing;
        
    }else
    {
        
        self.addRessLabel.text= self.keepAdress;
        
    }
    [labelView addSubview:self.addRessLabel];
    
}



@end
