//
//  UpdateCategoryNameView.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/2.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "UpdateCategoryNameView.h"
#import <Masonry/Masonry.h>

@implementation UpdateCategoryNameView
#pragma mark - life cycle
-(instancetype)init{
    self=[super init];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=10;
        [self addSubview:self.cancelBtn];
        [self addSubview:self.determineBtn];
        [self addSubview:self.nameLabel];
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.categoryImageView];
        [self addSubview:self.lineView];
        [self addSubview:self.inputNameTextField];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_top);
        make.size.mas_equalTo(CGSizeMake(kContainerViewWidth, kContainerViewWidth));
    }];
    [self.categoryImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.mas_equalTo(self.containerView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mas_top).offset(30.5);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.inputNameTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(17);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.inputNameTextField.mas_bottom).offset(1);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 1));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.mas_left).offset(50);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    [self.determineBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(self.mas_right).offset(-50);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
}
#pragma mark - action
-(void)clickedBtn:(UIButton *)sender{
    if(sender==self.cancelBtn){
        [self.delegate clickedCancelBtn];
    }else if (sender==self.determineBtn){
        [self.delegate updateCategoryWithNewName:self.inputNameTextField.text];
    }
}
#pragma mark - getters
-(UIView *)containerView{
    if(!_containerView){
        UIView *view=[UIView new];
        view.backgroundColor=[UIColor whiteColor];
        view.layer.cornerRadius=kContainerViewWidth/2;
        _containerView=view;
    }
    return _containerView;
}
-(UIImageView *)categoryImageView{
    if(!_categoryImageView){
        UIImageView *imgView=[UIImageView new];
        imgView.image=[UIImage imageNamed:@"type_big_2.png"];
        _categoryImageView=imgView;
    }
    return _categoryImageView;
}
-(UIView *)lineView{
    if(!_lineView){
        UIView *view=[UIView new];
        view.backgroundColor=LineColor;
        _lineView=view;
    }
    return _lineView;
}
-(UIButton *)cancelBtn{
    if(!_cancelBtn){
        UIButton *btn=[UIButton new];
        [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:20 weight:UIFontWeightLight];
        _cancelBtn=btn;
    }
    return _cancelBtn;
}
-(UIButton *)determineBtn{
    if(!_determineBtn){
        UIButton *btn=[UIButton new];
        [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:20 weight:UIFontWeightLight];
        _determineBtn=btn;
    }
    return _determineBtn;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *label=[UILabel new];
        label.font=[UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        label.text=@"用餐";
        _nameLabel=label;
    }
    return _nameLabel;
}
-(UITextField *)inputNameTextField{
    if(!_inputNameTextField){
        UITextField *textField=[UITextField new];
        textField.placeholder=@"用餐";
        _inputNameTextField=textField;
    }
    return _inputNameTextField;
}
-(NSString *)categoryID{
    if(!_categoryID){
        _categoryID=@"type_big_2.png";
    }
    return _categoryID;
}
#pragma mark - setters
-(void)setCategory:(UsedCategory *)category{
    self.categoryImageView.image=[UIImage imageNamed:category.categoryImageFileName];
    self.nameLabel.text=category.categoryTitle;
    self.inputNameTextField.placeholder=category.categoryTitle;
    self.categoryID=category.categoryImageFileName;
}
@end
