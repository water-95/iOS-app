//
//  CalendarPickerView.h
//  TiMi
//
//  Created by 江滨耀 on 2019/8/5.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarPickerViewDelegate<NSObject>
@required
-(void)updateCalculateViewWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
-(void)updateCalculateViewWithDate:(NSDate *)date;
@end

@interface CalendarPickerView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UICollectionView *calendarCollectionView;
@property(nonatomic,strong)NSCalendar *calendar;
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,strong)NSDate *currentDate;
@property(nonatomic,strong)NSDate *realDate;
@property(nonatomic,weak)id<CalendarPickerViewDelegate> delegate;

-(instancetype)initWithSelectedDate:(NSDate *)date;
-(void)showOnWindow;
- (NSInteger)convertDateToDay:(NSDate *)date;
- (NSInteger)convertDateToMonth:(NSDate *)date;
- (NSInteger)convertDateToYear:(NSDate *)date;
@end
