//
//  PhotoAlbumViewController.m
//  WelLv
//
//  Created by WeiLv on 16/1/24.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "PhotoAlbumViewController.h"

#import "HJCarouselViewLayout.h"

#import "ProductModel.h"

#import "PhotoViewCell.h"

#import "UIImageView+WebCache.h"
#import "TravelAllHeader.h"

@interface PhotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;


@end

@implementation PhotoAlbumViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据源
    self.pictureArr = [NSMutableArray array];
    self.navigationController.navigationBar.hidden = YES;
    [self readDataFromNet:self.product_ID];
    
    [self configureColletionView];

}

//第三方布局
- (void)configureColletionView{
    
    HJCarouselViewLayout *layout = [[HJCarouselViewLayout alloc]initWithAnim:(HJCarouselAnimLinear)];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    //    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate =self;
    self.collectionView.dataSource =self;
    [self.collectionView registerClass:[PhotoViewCell class] forCellWithReuseIdentifier:@"photo"];
    [self.view addSubview:self.collectionView];
    
    //添加一个手势用来返回主页面
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(tapGestureAction:)];
    [self.collectionView addGestureRecognizer:tapGesture];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)sender{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)readDataFromNet:(NSString *)IDString{
    
    //后加的字段,查看下架产品
    NSString *check_see = @"&check=see";
    
    NSString *string = [NSString stringWithFormat:@"%@%@%@",PRODUCT_DETAIL_NET,IDString,check_see];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        if (responseObject != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            if ([dictionary[@"status"] integerValue] == 1) {
                NSDictionary *dataDic = dictionary[@"data"];
                
                id str = dataDic[@"albums"];
                if ([str isEqual:[NSNull null]]) {
                    
                    
                }else if (![str isEqual:[NSNull null]])
                {
                    NSArray *albumsArr = dataDic[@"albums"];
                    if (albumsArr.count != 0) {
                        //轮播图数据
                        for (NSDictionary *dict in albumsArr) {
                            ProductModel *model = [ProductModel new];
                            [model setValuesForKeysWithDictionary:dict];
                            
                            [self.pictureArr addObject:model];
                        }
                    }
                }
                
                [self.collectionView reloadData];
                
                
            }else{
                
                [[LXAlterView sharedMyTools]createTishi:@"暂无数据"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictureArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    ProductModel *model = self.pictureArr[indexPath.item];
    
    if ([model.picture hasPrefix:@"http"]) {
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }else{
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,model.picture]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }
    
    return cell;
    
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
