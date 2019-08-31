//
//  BookCell.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/20.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "BookCell.h"
#import <Masonry/Masonry.h>
@interface BookCell ()
@property(nonatomic,strong)UIImageView *redFlagImageView;
@end
@implementation BookCell
#pragma mark - life cycle
-(void)prepareForReuse{
    NSLog(@"cell reuse");
    self.redFlagImageView.frame=CGRectZero;
    self.isSelected=NO;
    self.numberOfAccountsLabel.text=nil;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        NSLog(@"init cell");
        [self.contentView addSubview:self.bookCoverImageView];
        [self.bookCoverImageView addSubview:self.titleLabel];
        [self.bookCoverImageView addSubview:self.numberOfAccountsLabel];
        [self.bookCoverImageView addSubview:self.redFlagImageView];
    }
    return self;
}
-(void)layoutSubviews{
    NSLog(@"layout");
    [self.bookCoverImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.top.trailing.bottom.mas_equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.bookCoverImageView.mas_top).mas_offset(13);
        make.centerX.mas_equalTo(self.bookCoverImageView.mas_centerX);
    }];
    [self.numberOfAccountsLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(self.bookCoverImageView.mas_bottom).mas_offset(-5);
        make.trailing.mas_equalTo(self.bookCoverImageView.mas_trailing).mas_offset(-5);
    }];

    if(self.isSelected){
    [self.redFlagImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.bookCoverImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(10, 24));
        make.leading.mas_equalTo(self.bookCoverImageView.mas_leading).mas_offset(7);
    }];
    }else{
        [self.redFlagImageView removeConstraints:[self.redFlagImageView constraints]];
    }

}
#pragma mark - getters
-(UIImageView *)bookCoverImageView{
    if(!_bookCoverImageView){
        UIImageView *view=[UIImageView new];
        _bookCoverImageView=view;
    }
    return _bookCoverImageView;
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *label=[UILabel new];
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:15];
        _titleLabel=label;
    }
    return _titleLabel;
}
-(UILabel *)numberOfAccountsLabel{
    if(!_numberOfAccountsLabel){
        UILabel *label=[UILabel new];
        label.textColor=[UIColor colorWithWhite:0.500 alpha:1.000];
        label.font=[UIFont systemFontOfSize:10];
        _numberOfAccountsLabel=label;
    }
    return _numberOfAccountsLabel;
}
-(UIImageView *)redFlagImageView{
    if(!_redFlagImageView){
        UIImageView *view=[UIImageView new];
        view.image=[UIImage imageNamed:@"menu_selected_icon"];
        _redFlagImageView=view;
    }
    return _redFlagImageView;
}
@end
