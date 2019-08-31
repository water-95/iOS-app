//
//  CenterHeadView.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/21.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PieView;
@protocol CenterHeadViewDelegate <NSObject>
@required
-(NSString *)textForTitleBtn;
-(void)clickedCreateBtn;
-(void)clickedMenuBtn;
@optional
//* 点击了饼图内的创建按钮 */
- (void)didClickPieInCreateBtn;

@end


@interface CenterHeadView : UIView

@property (nonatomic, weak) id<CenterHeadViewDelegate> headViewDelegate;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *menuBtn;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIButton *bookTitleBtn;
@property (nonatomic, strong) PieView *pieView;
@property (nonatomic, strong) UIButton *createBtn;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *incomeMoneyLabel;
@property (nonatomic, strong) UILabel *spendLabel;
@property (nonatomic, strong) UILabel *spendMoneyLabel;
@property (nonatomic, strong) UIView *lineView;
-(void)reloadTitle;

@end
