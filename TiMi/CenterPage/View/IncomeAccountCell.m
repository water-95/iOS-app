//
//  IncomeAccountCell.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/25.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "IncomeAccountCell.h"
#import <Masonry/Masonry.h>
#import "Const.h"

@implementation IncomeAccountCell

#pragma mark life cycle
-(void)layoutSubviews{
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kTimePointViewWidth, kTimePointViewWidth));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(@9);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pointView);
        make.right.equalTo(self.pointView.mas_left).offset(-3);
    }];
    
    [self.daylyMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pointView);
        make.left.equalTo(self.pointView.mas_right).offset(3);
    }];
    
    [self.categoryIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kTimeLineBtnWidth + 10, kTimeLineBtnWidth + 10));
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.categoryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.categoryIconView.mas_leading).mas_offset(-5);
        make.centerY.equalTo(self.categoryIconView);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.categoryNameLabel.mas_leading).offset(-3);
        make.top.equalTo(self.categoryNameLabel);
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryIconView.mas_bottom);
        make.right.equalTo(self.categoryNameLabel);
        make.left.equalTo(self);
    }];
    
    if (!self.isLastAccount) {
        self.lineView.frame = CGRectMake((SCREEN_SIZE.width - 1)/2, 0, 1, self.contentView.bounds.size.height);
    } else {
        self.lineView.frame = CGRectMake((SCREEN_SIZE.width - 1)/2, 0, 1, self.contentView.bounds.size.height-5);
    }
}

@end
