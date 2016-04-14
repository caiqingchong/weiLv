//
//  QuestionnaireViewController.m
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import "WLQuestionnaireCollectionViewCell.h"
#import "WLQuestionnaireCollectionReusableView.h"
#import "PersonalTravelsViewController.h"
#import "AFNetworking.h"
#import "WLSubmitView.h"
#import "WLResultView.h"

@interface QuestionnaireViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, QuestionnaireChooseDelegate, SubmitQuestionnaireDelegate, QuestionnaireResultDelegate, QuestionnaireReusableViewDelegate>

@property(strong, nonatomic) UICollectionView *collectionView;

@property(strong, nonatomic) NSArray *dataArr;

@property(strong, nonatomic) NSMutableDictionary *selectedOptions;

@property(strong, nonatomic) WLSubmitView *submitView;

@property(strong, nonatomic) WLResultView *resultView;

@property(assign, nonatomic) NSInteger cateType;

@property(strong, nonatomic) UILabel *hintLabel;

@property(assign, nonatomic) NSInteger areaTag;

@end

@implementation QuestionnaireViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    
    if(self.userType == UserTypeMember){
        
        self.navigationItem.title = @"我的旅历";
        
    }else{
        
        self.navigationItem.title = @"Ta的旅历";
    }
    
    self.dataArr = [NSArray array];
    
    self.selectedOptions = [NSMutableDictionary dictionary];
    
    self.cateType = 1;
    
    [self setCollectionView];
    
    [self setHintLabel];
    
    if(self.contentType == ContentTypeQuestionnaire){
        
        [self setSubmitView];
    }
    
    [self setResultView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.areaTag = 0;
    
    [self loadData];
}

- (void)setCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight) collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[WLQuestionnaireCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.collectionView registerClass:[WLQuestionnaireCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}

- (void)setSubmitView {
    
    self.submitView = [[WLSubmitView alloc] init];
    
    self.submitView.delegate = self;
    
    [self.view addSubview:self.submitView];
}

- (void)setResultView {
    
    self.resultView = [[WLResultView alloc] init];
    
    self.resultView.delegate = self;
    
    [self.view addSubview:self.resultView];
}

- (void)setHintLabel {
    
    self.hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (SCREEN_HEIGHT - NavHeight - 20) / 2, SCREEN_WIDTH - 20, 20)];
    
    self.hintLabel.text = @"没有找到相关信息";
    
    self.hintLabel.font = [UIFont systemFontOfSize:15.0];
    
    self.hintLabel.textAlignment = NSTextAlignmentCenter;
    
    self.hintLabel.hidden = YES;
    
    [self.view addSubview:self.hintLabel];
}

- (void)loadData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = nil;
    
    NSString *url = nil;
    
    if(self.contentType == ContentTypeQuestionnaire){
        
        parameters = @{@"type": [NSString stringWithFormat:@"%li", self.questionnaireType + 1]};
        
        url = PERSONAL_TRAVELS_JOURNEYS_URL;
    }
    
    if(self.contentType == ContentTypeVisited){
        
        parameters = @{@"uid": self.memberId,
                       @"sel_type": [NSString stringWithFormat:@"%li", ContentTypeVisited],
                       @"cate_type": [NSString stringWithFormat:@"%li", self.cateType]};
        
        url = PERSONAL_TRAVELS_MEMBERS_JOURNEYS_URL;
    }
    
    if(self.contentType == ContentTypeWanted){
        
        parameters = @{@"uid": self.memberId,
                       @"sel_type": [NSString stringWithFormat:@"%li", ContentTypeWanted],
                       @"cate_type": [NSString stringWithFormat:@"%li", self.cateType]};
        
        url = PERSONAL_TRAVELS_MEMBERS_JOURNEYS_URL;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        weakSelf.dataArr = [resultDict objectForKey:@"data"];
        
        if(weakSelf.contentType == ContentTypeVisited || weakSelf.contentType == ContentTypeWanted){
            
            if(!weakSelf.dataArr.count){
                /*
                 if(self.userType == UserTypeMember){
                 
                 weakSelf.resultView.hidden = NO;
                 
                 if(weakSelf.contentType == ContentTypeVisited){
                 
                 [weakSelf.resultView setContentWithExpression:nil content:@"您还没有去过任何地方哦" userType:self.userType andContentType:weakSelf.contentType];
                 }
                 
                 if(weakSelf.contentType == ContentTypeWanted){
                 
                 [weakSelf.resultView setContentWithExpression:nil content:@"您还没有选择想去的地方哦" userType:self.userType andContentType:weakSelf.contentType];
                 }
                 
                 }else{
                 
                 weakSelf.hintLabel.hidden = NO;
                 }
                 */
                
                weakSelf.resultView.hidden = NO;
                
                [weakSelf.resultView setContentWithExpression:nil content:nil userType:self.userType status:0 andContentType:weakSelf.contentType];
                
            }else{
                
                weakSelf.resultView.hidden = YES;
                
                weakSelf.hintLabel.hidden = YES;
            }
        }
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if(self.contentType == ContentTypeQuestionnaire){
        
        return self.dataArr.count;
        
    }else{
        
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(self.contentType == ContentTypeQuestionnaire){
        
        return [[[self.dataArr objectAtIndex:section] objectForKey:@"data"] count];
        
    }else{
        
        return self.dataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLQuestionnaireCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    if(cell != nil){
        
        cell.placeNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    if(self.contentType == ContentTypeQuestionnaire){
        
        if([self.selectedOptions.allKeys containsObject:indexPath]){
            
            [cell setContentWithArray:[[self.dataArr objectAtIndex:indexPath.section] objectForKey:@"data"] indexPath:indexPath contentType:self.contentType selectStates:YES andSelectedOption:[[self.selectedOptions objectForKey:indexPath] objectForKey:@"sel_type"]];
            
        }else{
            
            [cell setContentWithArray:[[self.dataArr objectAtIndex:indexPath.section] objectForKey:@"data"] indexPath:indexPath contentType:self.contentType  selectStates:NO andSelectedOption:nil];
        }
        
    }else{
        
        [cell setContentWithArray:self.dataArr indexPath:indexPath contentType:self.contentType selectStates:NO andSelectedOption:nil];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    WLQuestionnaireCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
    
    header.delegate = self;
    
    if(self.contentType == ContentTypeQuestionnaire){
        
        NSString *title = [NSString stringWithFormat:@"%@：%@", [[self.dataArr objectAtIndex:indexPath.section] objectForKey:@"cate_name"], [[self.dataArr objectAtIndex:indexPath.section] objectForKey:@"cate_desc"]];
        
        [header setContent:title andContentType:ContentTypeQuestionnaire];
    }
    
    if(self.contentType == ContentTypeVisited){
        
        NSString *title = nil;
        
        if(self.userType == UserTypeMember){
            
            title = @"我去过的地方";
            
        }else{
            
            title = @"会员去过的地方";
        }
        
        [header setContent:title andContentType:ContentTypeVisited];
    }
    
    if(self.contentType == ContentTypeWanted){
        
        NSString *title = nil;
        
        if(self.userType == UserTypeMember){
            
            title = @"我想去的地方";
            
        }else{
            
            title = @"会员想去的地方";
        }
        
        [header setContent:title andContentType:ContentTypeWanted];
    }
    
    return header;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (SCREEN_WIDTH - 40) / 2;
    
    return CGSizeMake(width, width * 0.5 + 45);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 0, 10);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(SCREEN_WIDTH, 40);
}

#pragma mark - QuestionnaireChooseDelegate
- (void)didSelectedOptionWithIndexPath:(NSIndexPath *)indexPath optionData:(NSDictionary *)data andSelectStates:(NSInteger)states {
    
    if(states){
        
        [self.selectedOptions setObject:data forKey:indexPath];
        
    }else{
        
        [self.selectedOptions removeObjectForKey:indexPath];
    }
}

#pragma mark - SubmitQuestionnaireDelegate
- (void)didClickedSubmitView {
    
    NSMutableArray *journeyDataArr = [NSMutableArray array];
    
    for(NSDictionary *dict in self.selectedOptions.allValues){
        
        [journeyDataArr addObject:dict];
    }
    
    if(journeyDataArr.count < 10) {
        
        [[LXAlterView sharedMyTools]createTishi:@"您必须选择10个以上的选项才能提交！"];
        
    }
    
    if(journeyDataArr.count >= 10){
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *parameters = @{@"uid": self.memberId,
                                     @"data": journeyDataArr};
        
        NSString *jsonStr = [[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:parameters];
        
        NSDictionary *data = @{@"data": jsonStr};
        
        __weak typeof(self) weakSelf = self;
        
        [manager POST:PERSONAL_TRAVELS_SUBMIT_URL parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSString *msg = [resultDict objectForKey:@"msg"];
            
            NSInteger status = [[resultDict objectForKey:@"status"] integerValue];
            
            UIImage *expression = nil;
            
            if(status == 1){
                
                expression = [UIImage imageNamed:@"测试表情1"];
            }
            
            if(status == 2){
                
                expression = [UIImage imageNamed:@"测试表情2"];
            }
            
            if(status == 3){
                
                expression = [UIImage imageNamed:@"测试表情3"];
            }
            
            [weakSelf.resultView setContentWithExpression:expression content:msg userType:self.userType status:status andContentType:self.contentType];
            
            weakSelf.resultView.hidden = NO;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@", error.localizedDescription);
        }];
    }
}

#pragma mark - QuestionnaireResultDelegate
- (void)didClickedResultView {
    
    self.resultView.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToSubmitTest {
    
    QuestionnaireViewController *questionnaireController = [[QuestionnaireViewController alloc] init];
    
    questionnaireController.userType = self.userType;
    
    questionnaireController.memberId = [[LXUserTool sharedUserTool] getUid];
    
    questionnaireController.contentType = ContentTypeQuestionnaire;
    
    if(self.areaTag == 666){
        
        questionnaireController.questionnaireType = QuestionnaireTypeDomestic;
    }
    
    if(self.areaTag == 888){
        
        questionnaireController.questionnaireType = QuestionnaireTypeAbroad;
    }
    
    [self.navigationController pushViewController:questionnaireController animated:YES];
}

#pragma mark - QuestionnaireReusableViewDelegate
- (void)didSelectedAreaButtonWithTag:(NSInteger)tag {
    
    self.areaTag = tag;
    
    if(tag == 666){
        
        self.cateType = 1;
        
        [self loadData];
    }
    
    if(tag == 888){
        
        self.cateType = 2;
        
        [self loadData];
    }
}

@end








