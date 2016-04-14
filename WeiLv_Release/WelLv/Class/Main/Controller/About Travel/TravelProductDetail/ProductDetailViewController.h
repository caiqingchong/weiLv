//
//  ProductDetailViewController.h
//  TraveDetail
//
//  Created by WeiLv on 16/1/11.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义代理
 */
@class ProductDetailViewController;
@protocol ProductDetailViewControllerDelegate <NSObject>

-(void)productDetailControllerWith:(NSString*)textID;

@end


@interface ProductDetailViewController : UIViewController
{
    NSString *shareImageURL;  //分享产品的图片
    NSString *shareURL;       //分享跳转的URL
    
    UIImage *_shareImage;
}

@property (nonatomic, strong) NSString *productID;

@property (nonatomic,assign) NSInteger argumentNum;
@property (nonatomic, strong) NSString *gj_commission;//管家返佣
@property(nonatomic,strong)NSString *shop_id;
@property (nonatomic,assign)id<ProductDetailViewControllerDelegate> delegate;

@end
