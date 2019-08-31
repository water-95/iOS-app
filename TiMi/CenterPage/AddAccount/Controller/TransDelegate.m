//
//  TransDelegate.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/9.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "TransDelegate.h"
@interface TransDelegate ()
@property(nonatomic,assign)BOOL isPush;
@end
@implementation TransDelegate
-(instancetype)init{
    self=[super init];
    if(self){
        self.isPush=YES;
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"TransDelegate dealloc");
}
#pragma mark - UIViewControllerTransitioningDelegate
//这个函数用来设置当执行present方法时 进行的转场动画
/*
 presented为要弹出的Controller
 presenting为当前的Controller
 source为源Contrller 对于present动作  presenting与source是一样的
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}
//这个函数用来设置当执行dismiss方法时 进行的转场动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}

//这个函数用来设置当执行present方法时 进行可交互的转场动画
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
//
//}
//这个函数用来设置当执行dismiss方法时 进行可交互的转场动画
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
//
//}
//iOS8后提供的新接口  返回UIPresentationController处理转场
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
//
//}
//负责具体的动画展示
#pragma mark - UIViewControllerAnimatedTransitioning
//这个函数用来设置动画执行的时长
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3f;
}
//这个函数用来处理具体的动画
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPush){
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = toVC.view;
        
        CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
        toView.frame = CGRectOffset(finalFrame, 0, -[UIScreen mainScreen].bounds.size.height);
        
        //UIKit sets this view for you and automatically adds the view of the presenting view controller to it.
        //add toVC's view to containerView
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        self.isPush=NO;
    }else{
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIView *fromView = fromVC.view;
        UIView *toView = toVC.view;
        
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        
        CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
        fromView.frame = initialFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             fromView.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                         }
                         completion:^(BOOL finished) {
                             //[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             [transitionContext completeTransition:YES];
                         }];
        self.isPush=YES;
    }
    
}
@end
