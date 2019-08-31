//
//  AddAccountHeadView.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/26.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "AddAccountHeadView.h"
#import <Masonry/Masonry.h>
#import "UIImage+Resize.h"

@interface AddAccountHeadView()
@property(nonatomic,assign)BOOL isAlreadySelectedDecimalPoint;
@property(nonatomic,assign)NSUInteger severalDecimalPlaces;
@property(nonatomic,strong)NSString *moneyString;
@end

@implementation AddAccountHeadView

#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[[UIImage imageNamed:@"type_big_2.png"] mainColor];
        self.isAlreadySelectedDecimalPoint=false;
        self.severalDecimalPlaces=0;
        [self addSubview:self.maskView];
        [self addSubview:self.categoryImageView];
        [self addSubview:self.categoryNameBtn];
        [self addSubview:self.moneyLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.categoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(48.5, 48.5));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(10);
    }];
    [self.categoryNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.categoryImageView.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@(-10));
    }];
}
#pragma mark - action
- (void)clickCategoryNameBtn:(UIButton *)sender {
    [self.delegate openUpdateCategoryNameView];
}
#pragma mark - public methods
-(void)updateMoneyLabel:(NSString *)value{
    self.moneyLabel.text=value;
}
-(void)clearMoneyLabel{
    self.moneyLabel.text=@"¥ 0.00";
}
#pragma mark - getters
-(UIImageView *)categoryImageView{
    if(!_categoryImageView){
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _categoryImageView = imageView;
    }
    return _categoryImageView;
}
-(UIButton *)categoryNameBtn{
    if(!_categoryNameBtn){
        UIButton *button=[UIButton new];
        [button addTarget:self action:@selector(clickCategoryNameBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setTintColor:[UIColor whiteColor]];
        button.titleLabel.font=[UIFont systemFontOfSize:17];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        _categoryNameBtn=button;
    }
    return _categoryNameBtn;
}
-(UILabel *)moneyLabel{
    if(!_moneyLabel){
        UILabel *label=[UILabel new];
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:20];
        label.textAlignment=NSTextAlignmentRight;
        label.text=@"¥ 0.00";
        _moneyLabel=label;
    }
    return _moneyLabel;
}
-(UIView *)maskView{
    if(!_maskView){
        _maskView=[UIView new];
        _maskView.backgroundColor=[UIColor clearColor];
        _maskView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
    }
    return _maskView;
}
#pragma mark - setters
-(void)setCategory:(UsedCategory *)category{
    self.categoryImageView.image=[UIImage imageNamed:category.categoryImageFileName];
    [self.categoryNameBtn setTitle:category.categoryTitle forState:UIControlStateNormal];
}

@end
