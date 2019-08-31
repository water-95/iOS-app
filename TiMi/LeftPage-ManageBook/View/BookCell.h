//
//  BookCell.h
//  TiMi
//
//  Created by 江滨耀 on 2019/8/20.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *bookCoverImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *numberOfAccountsLabel;
@property(nonatomic,assign)BOOL isSelected;

@end
