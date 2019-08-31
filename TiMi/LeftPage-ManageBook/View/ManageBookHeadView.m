//
//  ManageBookHeadView.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/20.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "ManageBookHeadView.h"
#import <Masonry/Masonry.h>
#import "Const.h"
@implementation ManageBookHeadView
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.lineView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.totalMoneyButton];
    }
    return self;
}
-(void)layoutSubviews{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width, 0.2));
        make.top.mas_equalTo(self.mas_top);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.mas_equalTo(self.mas_leading).mas_offset(10);
        make.top.mas_equalTo(self.mas_top).offset(8);
    }];
    [self.totalMoneyButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
}
#pragma mark - getters
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[UILabel new];
        _titleLabel.text=@"我的账本";
        _titleLabel.font=[UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}
-(UIButton *)totalMoneyButton{
    if(!_totalMoneyButton){
        _totalMoneyButton=[UIButton new];
        [_totalMoneyButton setTitle:@"账本总额" forState:UIControlStateNormal];
        [_totalMoneyButton setTitleColor:[UIColor colorWithWhite:0.500 alpha:1.000] forState:UIControlStateNormal];
        _totalMoneyButton.titleLabel.font=[UIFont systemFontOfSize:20];
    }
    return _totalMoneyButton;
}
-(UIView *)lineView{
    if(!_lineView){
        _lineView=[UIView new];
        _lineView.backgroundColor=[UIColor colorWithWhite:0.500 alpha:1.000];
    }
    return _lineView;
}

@end
