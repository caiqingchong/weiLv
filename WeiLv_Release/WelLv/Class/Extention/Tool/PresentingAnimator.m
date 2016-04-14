//
//  PresentingAnimator.m
//  WelLv
//
//  Created by 张发杰 on 15/7/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PresentingAnimator.h"

@implementation PresentingAnimator
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
    dimmingView.backgroundColor = kColor(84, 84, 84);
    dimmingView.layer.opacity = 0.5;
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.frame = CGRectMake(0,
                              0,
                              CGRectGetWidth(transitionContext.containerView.bounds) - 50.f,
                              ViewHeight(toView));
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];
    
    [UIView animateWithDuration:1.f delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        toView.center = CGPointMake(transitionContext.containerView.center.x, transitionContext.containerView.center.y);
    } completion:NULL];
    
    [transitionContext completeTransition:YES];
}


@end
