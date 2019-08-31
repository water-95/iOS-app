//
//  CategoryCollectionViewCell.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/26.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UsedCategory;
@interface CategoryCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *categoryName;
@property(nonatomic,strong)UIImageView *categoryImageView;
@property(nonatomic,strong)UsedCategory *category;
@end
