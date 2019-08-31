//
//  CalculateView.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/30.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalculateViewDelegate <NSObject>
@required
-(void)openCalendarView;
-(void)openRemarkView;
-(void)sendVal:(UIButton *)send;
@optional

@end

@interface CalculateView : UIView

@property(nonatomic,weak)id<CalculateViewDelegate> calculateViewDelegate;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *yearLabel;
@property(nonatomic,strong)UILabel *monthLabel;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,strong)UIButton *Button0;
@property(nonatomic,strong)UIButton *Button1;
@property(nonatomic,strong)UIButton *Button2;
@property(nonatomic,strong)UIButton *Button3;
@property(nonatomic,strong)UIButton *Button4;
@property(nonatomic,strong)UIButton *Button5;
@property(nonatomic,strong)UIButton *Button6;
@property(nonatomic,strong)UIButton *Button7;
@property(nonatomic,strong)UIButton *Button8;
@property(nonatomic,strong)UIButton *Button9;
@property(nonatomic,strong)UIButton *ButtonPoint;
@property(nonatomic,strong)UIButton *ButtonClear;
@property(nonatomic,strong)UIButton *ButtonAdd;
@property(nonatomic,strong)UIButton *ButtonMinus;
@property(nonatomic,strong)UIButton *ButtonSave;
@property(nonatomic,strong)UIView *containView1;
@property(nonatomic,strong)UIView *containView2;
@property(nonatomic,strong)UIView *containView3;
@property(nonatomic,strong)UIView *containView4;
@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)NSDate *date;

/** 传递输入的值 */
@property (nonatomic, copy) void (^passValuesBlock)(NSString *string);
/** 点击时间选择器按钮 */
@property (nonatomic, copy) void (^didClickDateBtnBlock)();
/** 保存 */
@property (nonatomic, copy) void (^didClickSaveBtnBlock)();
/** 点击备注 */
@property (nonatomic, copy) void (^didClickRemarkBtnBlock)();
/** 设置时间 */
- (void)setTimeWtihTimeString:(NSString *)timeString;
@end
