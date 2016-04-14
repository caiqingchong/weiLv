//
//  zxdinforSelfViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdinforSelfViewController.h"
#import "MyMembersModel.h"
@interface zxdinforSelfViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *zxdTableView;
@property(strong,nonatomic)NSArray *zxdArr;
@property(strong,nonatomic)NSArray *zxdArrDetial;
@end

@implementation zxdinforSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDetialArr];
    [self creatTitle];
    [self creatTableView];
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    self.navigationItem.title = @"基本资料";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    self.view.backgroundColor = BgViewColor;
}
-(void)creatTableView
{
    self.zxdTableView = [[UITableView alloc] init];
    self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, windowContentHeight-15);
    self.zxdTableView.delegate = self;
    self.zxdTableView.dataSource = self;
    self.zxdTableView.tableFooterView = [[UIView alloc] init];
    self.zxdTableView.backgroundColor = BgViewColor;
    [self.view addSubview:self.zxdTableView];
    self.zxdArr = @[@"会员号",@"姓名",@"手机号",@"邮箱",@"性别",@"出生日期",@"证件号",@"地址"];
        //self.zxdArrDetial = @[@"1255365546546564654",@"",@"胡八一",@"13949038485",@"1015355132@qq.com",@"男",@"1895-02-10"];
    if ([self.zxdTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.zxdTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.zxdTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zxdTableView setLayoutMargins:UIEdgeInsetsZero];
    }

}
-(void)creatDetialArr
{
    //会员号
    NSString *str1 = [NSString stringWithFormat:@"%@",[self judgeString:self.memberModel.uid]?self.memberModel.username:@""];
    //头像
   // NSString *str2 = [NSString stringWithFormat:@"头像"];
    //姓名
    NSString *str3 = [NSString stringWithFormat:@"%@",[self judgeString:self.memberModel.realname]?self.memberModel.realname:[self judgeString:self.memberModel.phone]?self.memberModel.phone:@""];
    //手机号
    NSString *str4 = [NSString stringWithFormat:@"%@",[self judgeString:self.memberModel.phone]?self.memberModel.phone:@""];
    //邮箱
    NSString *str5 = [NSString stringWithFormat:@"%@",[self judgeString:self.memberModel.email]?self.memberModel.email:@""];
    //性别
    NSString *sex ;
    if (![self judgeString:self.memberModel.sex]) {
        sex = @"保密";
    }
    else
    {
        if ([self.memberModel.sex isEqual:@"1"]) {
            sex = @"男";
        }
        else
        {
            sex = @"女";
        }
        
    }
    NSString *str6 = sex;
    //出生日期
    NSString *str7 = [NSString stringWithFormat:@"%@",[self judgeString:self.memberModel.birthday]?self.memberModel.birthday:@""];
    //证件号
    NSString *str8 = [NSString stringWithFormat:@"%@",[self judgeString:self.memberModel.idnumber]?self.memberModel.idnumber:@""];
    //地址
    NSString *str9 = [NSString stringWithFormat:@"%@",[self judgeString:self.memberModel.address]?self.memberModel.address:@""];
  self.zxdArrDetial = @[str1,str3,str4,str5,str6,str7,str8,str9];
}
#pragma mark---tableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.zxdArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==10||indexPath.row ==6) {
        return 70;
    }
    else if (indexPath.row == 7)
    {
        return 90;
    }
    else
    {
        return 45;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (6 == indexPath.row) {
        static NSString *CellIdtifier1 = @"CellIdtifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *zxdLabel = [[UILabel alloc] init];
            zxdLabel.frame = CGRectMake(15, 20, windowContentWidth-100, 30);
            zxdLabel.textAlignment = NSTextAlignmentLeft;
            zxdLabel.tag = 700;
            zxdLabel.font = [UIFont systemFontOfSize:15];
            [cell addSubview:zxdLabel];
        }
        UILabel *zxdLb = [cell viewWithTag:700];
        zxdLb.textColor =[YXTools stringToColor:@"#6f7378"];
        zxdLb.text =[self.zxdArr objectAtIndex:indexPath.row];
        UILabel *labelCard = [[UILabel alloc] init];
        labelCard.frame = CGRectMake(150, 10, windowContentWidth-175, 15);
        labelCard.textColor = [YXTools stringToColor:@"#2f2f2f"];
        labelCard.textAlignment = NSTextAlignmentRight;
        labelCard.text = @"身份证";
        
        [cell addSubview:labelCard];
        UILabel *labelCardNumber = [[UILabel alloc] init];
        labelCardNumber.frame = CGRectMake(150, 40, windowContentWidth-175, 15);
        labelCardNumber.textColor =  [YXTools stringToColor:@"#2f2f2f"];
        labelCardNumber.textAlignment =  NSTextAlignmentRight;
        labelCardNumber.text = [self.zxdArrDetial objectAtIndex:indexPath.row];
        [cell addSubview:labelCardNumber];
        return cell;
    }
    else if (7 == indexPath.row)
    {
        static NSString *CellIdtifier2 = @"CellIdtifier2";
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *zxdLabel = [[UILabel alloc] init];
            zxdLabel.frame = CGRectMake(15, 30, windowContentWidth-100, 30);
            zxdLabel.textAlignment = NSTextAlignmentLeft;
            zxdLabel.tag = 700;
            zxdLabel.font = [UIFont systemFontOfSize:15];
            [cell addSubview:zxdLabel];
        }
        UILabel *zxdLb = [cell viewWithTag:700];
        zxdLb.textColor =[YXTools stringToColor:@"#6f7378"];
        zxdLb.text =[self.zxdArr objectAtIndex:indexPath.row];
        UILabel *labelAddess = [[UILabel alloc] init];
        labelAddess.frame = CGRectMake(150, 10, windowContentWidth-175, 70);
        labelAddess.numberOfLines = 3;
        labelAddess.textAlignment = NSTextAlignmentRight;
        labelAddess.textColor = [YXTools stringToColor:@"#2f2f2f"];
        labelAddess.text = [self.zxdArrDetial objectAtIndex:indexPath.row];
        [cell addSubview:labelAddess];
        return cell;
    }
    else if (10 == indexPath.row)
    {
        static NSString *CellIdtifier4 = @"CellIdtifier4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier4];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text =[self.zxdArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [YXTools stringToColor:@"#6f7378"];
        UIImageView *zxdImageHead = [[UIImageView alloc] init];
        zxdImageHead.frame =CGRectMake(windowContentWidth-80, 8, 55, 55);
        zxdImageHead.layer.masksToBounds = YES;
        zxdImageHead.layer.cornerRadius = 27.5;
        NSString *str = [self judgeString:self.memberModel.avater]?self.memberModel.avater:@"";
        [zxdImageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,str]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
        //zxdImageHead.image = [UIImage imageNamed:@"默认图1"];
        [cell addSubview:zxdImageHead];
        return cell;
    }

    else
    {
        static NSString *CellIdtifier3 = @"CellIdtifier3";
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *zxdLabel = [[UILabel alloc] init];
            zxdLabel.frame = CGRectMake(15, 10, windowContentWidth-100, 30);
            zxdLabel.textAlignment = NSTextAlignmentLeft;
            zxdLabel.tag = 700;
            zxdLabel.font = [UIFont systemFontOfSize:15];
            [cell addSubview:zxdLabel];
        }
        UILabel *zxdLb = [cell viewWithTag:700];
        zxdLb.textColor =[YXTools stringToColor:@"#6f7378"];
        zxdLb.text =[self.zxdArr objectAtIndex:indexPath.row];
        //cell.textLabel.text =[self.zxdArr objectAtIndex:indexPath.row];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(150, 10, windowContentWidth-175, 25);
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [YXTools stringToColor:@"#2f2f2f"];
        label.text = [self.zxdArrDetial objectAtIndex:indexPath.row];
        [cell addSubview:label];
        return cell;

    }
    return nil;
}
#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
