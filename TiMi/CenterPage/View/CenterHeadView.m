//
//  CenterHeadView.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/21.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "CenterHeadView.h"
#import <Masonry/Masonry.h>
#import "PieView.h"
#import "Const.h"

@implementation CenterHeadView

#pragma mark - life cycle

-(void)didMoveToWindow{
    [super didMoveToWindow];
}

-(instancetype)init{
    self=[super init];
    if(self){
        [self addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.menuBtn];
        [self.bgImageView addSubview:self.searchBtn];
        [self.bgImageView addSubview:self.bookTitleBtn];
        [self.bgImageView addSubview:self.pieView];
        [self.bgImageView addSubview:self.createBtn];
        [self addSubview:self.incomeLabel];
        [self addSubview:self.incomeMoneyLabel];
        [self addSubview:self.spendLabel];
        [self addSubview:self.spendMoneyLabel];
        [self addSubview:self.lineView];
    }
    return self;
}
-(void)layoutSubviews{
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(155);
        make.width.mas_equalTo(SCREEN_SIZE.width);
        make.left.top.and.right.equalTo(self);
    }];
    
    [self.menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(25);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(25);
    }];
    
    [self.bookTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([self titleBtnSizeWithTitle:self.bookTitleBtn.titleLabel.text]);
        make.centerX.equalTo(self.bgImageView);
        make.centerY.equalTo(self.menuBtn);
    }];
    
    [self.pieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCircleWidth, kCircleWidth));
        make.centerX.equalTo(self.bgImageView);
        make.centerY.equalTo(self.bgImageView.mas_bottom);
    }];
    
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.pieView).insets(UIEdgeInsetsMake(30, 30, 30, 30));
    }];
    
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(20);
    }];
    
    [self.incomeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomeLabel).offset(20);
        make.left.equalTo(self.incomeLabel);
    }];
    
    [self.spendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomeLabel);
        make.right.equalTo(self).offset(-20);
    }];
    
    [self.spendMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spendLabel).offset(20);
        make.right.equalTo(self.spendLabel);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 20));
        make.centerX.equalTo(self);
        make.top.equalTo(self.pieView.mas_bottom);
    }];
}

#pragma mark - button actions
- (void)clickCreateBtn:(UIButton *)sender
{
    NSLog(@"click CreateBtn");
    [self.headViewDelegate clickedCreateBtn];
}
-(void)clickMenuBtn:(UIButton *)sender
{
    NSLog(@"click MenuBtn");
    [self.headViewDelegate clickedMenuBtn];
}
-(void)clickTitleBtn:(UIButton *)sender
{
    NSLog(@"click TitleBtn");
}

#pragma makr - public methods
-(void)reloadTitle{
    self.bookTitleBtn.titleLabel.text=[self.headViewDelegate textForTitleBtn];
    self.bookTitleBtn.titleLabel.font = [UIFont systemFontOfSize:kTitleTextFont];
    [self.bookTitleBtn setTitle: [self.headViewDelegate textForTitleBtn] forState:UIControlStateNormal];
    [self.bookTitleBtn setTintColor:[UIColor whiteColor]];
}

#pragma mark - private methods
/** 根据账本名称获取size*/
- (CGSize)titleBtnSizeWithTitle:(NSString *)title {
    CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kTitleTextFont]}].width + 20;
    return CGSizeMake(width, 25);
}

#pragma mark - getters
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"background1"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        _bgImageView = imageView;
    }
    return _bgImageView;
}

-(UIButton *)menuBtn
{
    if(!_menuBtn){
        UIButton *menuBtn = [UIButton new];
        [menuBtn setImage:[UIImage imageNamed:@"btn_menu"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
        _menuBtn=menuBtn;
    }
    return _menuBtn;
}

-(UIButton *)searchBtn
{
    if(!_searchBtn){
        UIButton *searchBtn = [UIButton new];
        [searchBtn setImage:[UIImage imageNamed:@"btn_camera"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn=searchBtn;
    }
    return _searchBtn;
}

-(UIButton *)bookTitleBtn
{
    if(_bookTitleBtn) return _bookTitleBtn;
    UIButton *titleBtn = [UIButton new];
    [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleBtn.layer.cornerRadius = kTitleBtnSize.height/2;
    /** 设置边框宽度 */
    titleBtn.layer.borderWidth = 1.5;
    //* 设置Btn的边框颜色 */
    titleBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    _bookTitleBtn=titleBtn;
    return _bookTitleBtn;
}

- (PieView *)pieView
{
    if (!_pieView) {
        _pieView = [PieView new];
        _pieView.backgroundColor = [UIColor clearColor];
        _pieView.layer.cornerRadius = kCircleWidth/2;
        _pieView.lineWidth = 2;
        //        _pieView.layer.masksToBounds = YES;
    }
    return _pieView;
}

- (UIButton *)createBtn
{
    if (!_createBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(clickCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"circle_btn"] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        //cornerRadius:角半径
        button.layer.cornerRadius =(kCircleWidth-30-30)/2;
        button.layer.masksToBounds = YES;
        _createBtn = button;
    }
    return _createBtn;
}

- (UILabel *)incomeLabel
{
    if (!_incomeLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = @"当月收入";
        _incomeLabel = label;
    }
    return _incomeLabel;
}
- (UILabel *)incomeMoneyLabel
{
    if (!_incomeMoneyLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:18.0f];
        _incomeMoneyLabel = label;
    }
    return _incomeMoneyLabel;
}
- (UILabel *)spendLabel
{
    if (!_spendLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = @"当月支出";
        _spendLabel = label;
    }
    return _spendLabel;
}
- (UILabel *)spendMoneyLabel
{
    if (!_spendMoneyLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:18.0f];
        label.textAlignment = NSTextAlignmentRight;
        _spendMoneyLabel = label;
    }
    return _spendMoneyLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}


@end
