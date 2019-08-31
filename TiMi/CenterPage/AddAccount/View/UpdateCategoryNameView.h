//
//  UpdateCategoryNameView.h
//  TiMi
//
//  Created by 江滨耀 on 2019/8/2.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"
#import "UsedCategory.h"
@protocol UpdateCategoryNameViewDelegate<NSObject>
@required
-(void)updateCategoryWithNewName:(NSString *)newName;
-(void)clickedCancelBtn;
@end

@interface UpdateCategoryNameView : UIView

@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UIImageView *categoryImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UITextField *inputNameTextField;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *determineBtn;
@property(nonatomic,strong)UsedCategory *category;
@property(nonatomic,copy)NSString *categoryID;
@property(nonatomic,weak)id<UpdateCategoryNameViewDelegate> delegate;

@end
