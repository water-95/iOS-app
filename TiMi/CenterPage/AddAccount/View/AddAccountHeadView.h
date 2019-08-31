//
//  AddAccountHeadView.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/26.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsedCategory.h"
@protocol AddAccountHeadViewDelegate<NSObject>
@required
-(void)openUpdateCategoryNameView;
@end
@interface AddAccountHeadView : UIView
@property(nonatomic,strong)UIImageView *categoryImageView;
@property(nonatomic,strong)UIButton *categoryNameBtn;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UsedCategory *category;
@property(nonatomic,weak)id<AddAccountHeadViewDelegate> delegate;
@property(nonatomic,strong)UIView *maskView;
-(void)updateMoneyLabel:(NSString *)value;
-(void)clearMoneyLabel;
@end
