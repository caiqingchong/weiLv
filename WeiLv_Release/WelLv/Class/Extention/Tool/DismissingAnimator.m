//
//  DismissingAnimator.m
//  WelLv
//
//  Created by 张发杰 on 15/7/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "DismissingAnimator.h"

@implementation DismissingAnimator
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toVC.view.userInteractionEnabled = YES;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    __block UIView *dimmingView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (view.layer.opacity < 1.f) {
            dimmingView = view;
            *stop = YES;
        }
    }];
    
    [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        fromVC.view.frame = CGRectMake(ViewX(fromVC.view), -fromVC.view.layer.position.y, ViewWidth(fromVC.view), ViewHeight(fromVC.view));
        
    } completion:NULL];
    
    [transitionContext completeTransition:YES];
}

@end
