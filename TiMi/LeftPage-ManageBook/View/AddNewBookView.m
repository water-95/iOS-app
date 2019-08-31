//
//  AddNewBookView.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/21.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "AddNewBookView.h"
#import "Const.h"
#import <Masonry/Masonry.h>
#import "UIImage+Resize.h"

@implementation AddNewBookView
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor colorWithWhite:0.750 alpha:0.3];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.rowLineView1];
        [self.contentView addSubview:self.rowLineView2];
        [self.contentView addSubview:self.rowLineView3];
        [self.contentView addSubview:self.colLineView];
        [self.contentView addSubview:self.bookNameTextField];
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.currencyLabel];
        [self.contentView addSubview:self.currencyLabelSymbol];
        [self.contentView addSubview:self.cacelButton];
        [self.contentView addSubview:self.saveButton];
        self.selectedIndex=0;
    }
    return self;
}
-(void)layoutSubviews{
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width-100, 200));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(-100);
    }];
    [_rowLineView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(50);
        make.height.mas_equalTo(1);
    }];
    [_rowLineView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(7);
    }];
    [_rowLineView3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.currencyLabel.mas_bottom).mas_offset(10);
    }];
    [_colLineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.rowLineView3.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(1.5);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [_bookNameTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.rowLineView1.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width-100, 50));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [_currencyLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.top.mas_equalTo(self.rowLineView2).mas_offset(10);
    }];
    [_currencyLabelSymbol mas_makeConstraints:^(MASConstraintMaker *make){
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.centerY.mas_equalTo(self.currencyLabel);
    }];
    [_cacelButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX).multipliedBy(0.5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-8);
    }];
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX).multipliedBy(1.5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-8);
    }];
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"addBookCell" forIndexPath:indexPath];
//    UICollectionViewCell *cell=[[UICollectionViewCell alloc] init];
//    [cell setRestorationIdentifier:@"addBookCell"];
    UIImageView *imageView=[UIImageView new];
    NSString *imageName=[NSString stringWithFormat:@"book_cover_%ld",indexPath.row];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=35/2;
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerX.mas_equalTo(cell.contentView.mas_centerX);
        make.centerY.mas_equalTo(cell.contentView.mas_centerY);
    }];
    cell.layer.cornerRadius=40/2;
    cell.layer.borderWidth=1;
    if(indexPath.row==self.selectedIndex)cell.layer.borderColor=[imageView.image mainColor].CGColor;
    else cell.layer.borderColor=[UIColor whiteColor].CGColor;
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==self.selectedIndex)return;
    NSUInteger oldIndex=self.selectedIndex;
    NSIndexPath *oldIndexPath=[NSIndexPath indexPathForRow:oldIndex inSection:0];
    self.selectedIndex=indexPath.row;
    [collectionView reloadItemsAtIndexPaths:@[indexPath,oldIndexPath]];
}
#pragma mark - button target
-(void)clickedButton:(UIButton *)sender{
    if([sender.titleLabel.text isEqualToString:@"取消"]){
        [self.delegate cancelAddBook];
    }else{
        [self.delegate addBookWithTitle:self.bookNameTextField.text CoverImage:[NSString stringWithFormat:@"book_cover_%ld",self.selectedIndex]];
    }
}
#pragma mark - getters
-(UIView *)contentView{
    if(!_contentView){
        _contentView=[UIView new];
        _contentView.backgroundColor=[UIColor whiteColor];
        _contentView.layer.cornerRadius=kContainerViewWidth/3;
    }
    return _contentView;
}
-(UITextField *)bookNameTextField{
    if(!_bookNameTextField){
        UITextField *view=[UITextField new];
        view.placeholder=@" 新建账本 ";
        view.font=[UIFont systemFontOfSize:18];
        _bookNameTextField=view;
    }
    return _bookNameTextField;
}
-(UIView *)rowLineView1{
    if(!_rowLineView1){
        _rowLineView1=[UIView new];
        _rowLineView1.backgroundColor=LineColor;
    }
    return _rowLineView1;
}
-(UIView *)rowLineView2{
    if(!_rowLineView2){
        _rowLineView2=[UIView new];
        _rowLineView2.backgroundColor=LineColor;
    }
    return _rowLineView2;
}-(UIView *)rowLineView3{
    if(!_rowLineView3){
        _rowLineView3=[UIView new];
        _rowLineView3.backgroundColor=LineColor;
    }
    return _rowLineView3;
}-(UIView *)colLineView{
    if(!_colLineView){
        _colLineView=[UIView new];
        _colLineView.backgroundColor=LineColor;
    }
    return _colLineView;
}
-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.itemSize=CGSizeMake(40, 40);
        layout.sectionInset=UIEdgeInsetsMake(8, 8, 8, 8);
        layout.minimumInteritemSpacing=20;
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"addBookCell"];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
    }
    return _collectionView;
}
-(UILabel *)currencyLabel{
    if(!_currencyLabel){
        _currencyLabel=[UILabel new];
        _currencyLabel.text=@"记账币种";
        _currencyLabel.font=[UIFont systemFontOfSize:18];
        _currencyLabel.textColor=[UIColor colorWithWhite:0.65 alpha:1];
    }
    return _currencyLabel;
}
-(UILabel *)currencyLabelSymbol{
    if(!_currencyLabelSymbol){
        _currencyLabelSymbol=[UILabel new];
        _currencyLabelSymbol.text=@"CNY";
        _currencyLabelSymbol.font=[UIFont systemFontOfSize:18];
        _currencyLabelSymbol.textColor=[UIColor colorWithWhite:0.65 alpha:1];
    }
    return _currencyLabelSymbol;
}
-(UIButton *)cacelButton{
    if(!_cacelButton){
        UIButton *btn=[UIButton new];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:0.65 alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:20];
        [btn addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        _cacelButton=btn;
    }
    return _cacelButton;
}
-(UIButton *)saveButton{
    if(!_saveButton){
        UIButton *btn=[UIButton new];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:0.65 alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:20];
        [btn addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        _saveButton=btn;
    }
    return _saveButton;
}
@end
