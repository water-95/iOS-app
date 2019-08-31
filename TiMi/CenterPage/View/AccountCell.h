//
//  AccountCell.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/25.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell

@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *daylyMoneyLabel;
@property(nonatomic,strong)UIView *pointView;
@property(nonatomic,strong)UIImageView *categoryIconView;
@property(nonatomic,strong)UILabel *categoryNameLabel;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UILabel *remarkLabel;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,copy)NSString *categoryImageName;
@property(nonatomic,assign)BOOL isLastAccount;
@property(nonatomic,assign)BOOL ishideCategoryNameAndMoney;
-(void)hideCategoryNameAndMoney;
-(void)showCategoryNameAndMoney;
@end
