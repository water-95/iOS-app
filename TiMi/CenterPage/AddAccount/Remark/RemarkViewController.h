//
//  RemarkViewController.h
//  TiMi
//
//  Created by 江滨耀 on 2019/8/28.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemarkViewControllerDataSource<NSObject>
-(NSDate *)seletedDate;
@end

@interface RemarkViewController : UIViewController
@property(nonatomic,strong)UITextView *remarkTextView;
@property(nonatomic,strong)UILabel *placeholderLabel;
@property(nonatomic,strong)UILabel *selectedDateLabel;
@property(nonatomic,strong)UILabel *wordCountLabel;
@property(nonatomic,strong)UIButton *saveButton;
@property(nonatomic,weak)id<RemarkViewControllerDataSource> datasource;
@end
