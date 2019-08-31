//
//  RemarkViewController.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/28.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "RemarkViewController.h"
#import "UIImage+Resize.h"
@interface RemarkViewController ()
@end

@implementation RemarkViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //[self setupNavigationBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private method
- (void)setupNavigationBar {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //UIImage *image = [[UIImage imageNamed:@"btn_item_close-1"] imageByResizeToSize:backBtn.frame.size];
    UIImage *image=[UIImage imageNamed:@"btn_item_close-1"];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickDisMissBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
#pragma mark - button actions
-(void)clickDisMissBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
