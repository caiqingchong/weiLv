//
//  PersonalTravelsViewController.m
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "PersonalTravelsViewController.h"
#import "WLBannerView.h"
#import "AFNetworking.h"
#import "QuestionnaireViewController.h"

@interface PersonalTravelsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSString *cityId;

@property(strong, nonatomic) WLBannerView *bannerView;

@property(strong, nonatomic) NSArray *titleArr;

@end

@implementation PersonalTravelsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    
    if(self.userType == UserTypeMember){
        
        self.navigationItem.title = @"我的旅历";
        
        self.titleArr = @[@"玩转中国", @"玩转地球", @"我去过的地方", @"我想去的地方"];
        
    }else{
        
        self.navigationItem.title = @"Ta的旅历";
        
        self.titleArr = @[@"Ta想去的地方", @"Ta去过的地方"];
    }
    
    [self setBannerView];
    
    [self setTableView];
    
    [self loadAdData];
}

- (void)setBannerView {
    
    self.bannerView = [[WLBannerView alloc] init];
    
    [self.view addSubview:self.bannerView];
}

- (void)setTableView {
    
    UITableView *tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame) + 20, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight - CGRectGetMaxY(self.bannerView.frame) - 30)];
    
    tbView.dataSource = self;
    
    tbView.delegate = self;
    
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tbView.backgroundColor = BgViewColor;
    
    [self.view addSubview:tbView];
}

- (void)loadAdData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.cityId = [[WLSingletonClass defaultWLSingleton] wlCityId];
    
    NSDictionary *parameters = @{@"ad_place_id": @"128", @"city_id": self.cityId};
    
    __weak typeof(self) weakSelf = self;
    
    [manager POST:PERSONAL_TRAVELS_BANNER_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *resultArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSString *urlStr = [[resultArr objectAtIndex:0] objectForKey:@"src"];
        
        [weakSelf.bannerView setImageWithUrl:urlStr];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.userType == UserTypeMember){
        
        return 4;
        
    }else{
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        for(id obj in cell.contentView.subviews){
            
            [obj removeFromSuperview];
        }
    }
    
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    
    cell.textLabel.font = systemFont(14.0);
    
    //右箭头
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-40, (ViewHeight(cell)-20)/2, 30, 20)];
    
    rightView.contentMode = UIViewContentModeScaleAspectFit;
    
    rightView.image = [UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"];
    
    [cell.contentView addSubview:rightView];
    
    //底边框
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, SCREEN_WIDTH, 1)];
    
    bottomLine.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:217.0/255.0 blue:216.0/255.0 alpha:1];
    
    [cell.contentView addSubview:bottomLine];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionnaireViewController *questionnaireController = [[QuestionnaireViewController alloc] init];
    
    questionnaireController.userType = self.userType;
    
    switch(self.userType){
            
        case UserTypeMember:{
            
            questionnaireController.memberId = [[LXUserTool sharedUserTool] getUid];
            
            if(indexPath.row == 0){
                
                questionnaireController.contentType = ContentTypeQuestionnaire;
                
                questionnaireController.questionnaireType = QuestionnaireTypeDomestic;
            }
            
            if(indexPath.row == 1){
                
                questionnaireController.contentType = ContentTypeQuestionnaire;
                
                questionnaireController.questionnaireType = QuestionnaireTypeAbroad;
            }
            
            if(indexPath.row == 2){
                
                questionnaireController.contentType = ContentTypeVisited;
            }
            
            if(indexPath.row == 3){
                
                questionnaireController.contentType = ContentTypeWanted;
            }
            
            [self.navigationController pushViewController:questionnaireController animated:YES];
        }
            
            break;
            
        case UserTypeAssistant:{
            
            questionnaireController.memberId = self.memberId;
            
            if(indexPath.row == 0){
                
                questionnaireController.contentType = ContentTypeWanted;
            }
            
            if(indexPath.row == 1){
                
                questionnaireController.contentType = ContentTypeVisited;
            }
            
            [self.navigationController pushViewController:questionnaireController animated:YES];
        }
            
            break;
    }
}

@end







