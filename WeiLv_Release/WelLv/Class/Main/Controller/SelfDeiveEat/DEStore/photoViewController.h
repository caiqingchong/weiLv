//
//  photoViewController.h
//  WelLv
//
//  Created by liuxin on 15/11/14.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface photoViewController : XCSuperObjectViewController
{
    NSMutableArray *_arrimagepv;
    UIImageView *_imageView1;
    UIImage *_imagePv;
    NSInteger _index;
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *imagePv;
@property(nonatomic,strong)NSMutableArray *arrimagepv;
@property(nonatomic,assign)NSInteger index;
@end
