//
//  ManageViewController.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/20.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "ManageViewController.h"
#import <TYPagerController/TYPagerController.h>
#import "ManageBookViewController.h"
#import "CenterViewController.h"
#import "AnalysisAndStaticViewController.h"
#import "Const.h"
static NSInteger numberOfControllers = 3;
@interface ManageViewController ()<TYPagerControllerDataSource,TYPagerControllerDelegate>
@property(nonatomic,strong)TYPagerController *pagerController;
@property(nonatomic,assign)BOOL first;
@property(nonatomic,copy)NSString *selectedBookID;
@end

@implementation ManageViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _first=YES;
    _pagerController=[TYPagerController new];
    _pagerController.dataSource=self;
    _pagerController.delegate=self;
    [self addChildViewController:_pagerController];
    [self.view addSubview:_pagerController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TYPagerControllerDataSource
// viewController's count in pagerController
- (NSInteger)numberOfControllersInPagerController{
    return numberOfControllers;
}

/* 1.viewController at index in pagerController
 2.if prefetching is YES,the controller is preload,not display.
 3.if controller will display,will call viewWillAppear.
 4.you can register && dequeue controller, usage like tableView
 */
- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching{
    if(index==0)return [ManageBookViewController new];
    else if (index==1)return [CenterViewController new];
    else return [AnalysisAndStaticViewController new];
}
- (void)pagerControllerDidScroll:(TYPagerController *)pagerController{
    if(self.first){
        UIScrollView *scrollview=pagerController.layout.scrollView;
        scrollview.contentOffset=CGPointMake([[UIScreen mainScreen] bounds].size.width, 0);
        self.first=NO;
    }
    
}
#pragma mark - public methods
-(void)transitionToViewControllerAtIndex:(NSUInteger)index{
    CGFloat offsetX=index*SCREEN_SIZE.width;
    self.pagerController.layout.scrollView.contentOffset=CGPointMake(offsetX, 0);
}


@end
