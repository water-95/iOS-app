//
//  CategoryCollectionViewCell.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/26.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "UsedCategory.h"
#import "Const.h"

@implementation CategoryCollectionViewCell

#pragma mark - life cycle
- (void)prepareForReuse {
    [super prepareForReuse];
    NSLog(@"cell reuse");
    self.category = nil;
    self.categoryName.text = nil;
    self.categoryImageView.image = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.categoryImageView];
        [self.categoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kCollectionCellWidth-20, kCollectionCellWidth-20));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(5);
        }];
        [self.contentView addSubview:self.categoryName];
        [self.categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.width.equalTo(weakSelf.categoryImageView);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.categoryImageView.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - getters
- (UIImageView *)categoryImageView
{
    if (!_categoryImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _categoryImageView = imageView;
    }
    return _categoryImageView;
}
- (UILabel *)categoryName
{
    if (!_categoryName) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textAlignment = NSTextAlignmentCenter;
        
        _categoryName = label;
    }
    return _categoryName;
}
#pragma mark - setters
- (void)setCategory:(UsedCategory *)category {
    _category=category;
    self.categoryImageView.image = [UIImage imageNamed:category.categoryImageFileName];
    self.categoryName.text = category.categoryTitle;

}

@end
