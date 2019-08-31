//
//  CalendarPickerView.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/5.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "CalendarPickerView.h"
#import "Const.h"
#import <Masonry/Masonry.h>
#import "CalendarCollectionViewCell.h"
#define CalendarViewheight 250

@implementation CalendarPickerView
#pragma mark - life cycle
-(instancetype)init{
    self=[super init];
    if(self){
        self.backgroundColor=[UIColor clearColor];
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        [self addSubview:self.maskView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        [self.contentView addSubview:self.calendarCollectionView];
    }
    return self;
}
-(instancetype)initWithSelectedDate:(NSDate *)date{
    self=[super init];
    if(self){
        self.date=date;
        self.currentDate=date;
        self.backgroundColor=[UIColor clearColor];
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        [self addSubview:self.maskView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        [self.contentView addSubview:self.calendarCollectionView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.centerY.mas_equalTo(self.dateLabel.mas_centerY);
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(10);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.centerY.mas_equalTo(self.dateLabel.mas_centerY);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-10);
    }];
}

-(void)dealloc{
    NSLog(@"view dealloc");
}
#pragma mark - Gesture methods
-(void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CalendarViewheight);
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}
#pragma mark - button action
-(void)didClickedBtn:(UIButton *)sender{
    NSInteger offsetMonth;
    if(sender==self.leftButton){
        offsetMonth=-1;
    }else{
        offsetMonth=1;
    }
    [self updateDateWithOffsetMonths:offsetMonth];
    [self.calendarCollectionView reloadData];
    [self updateDateLabel];
}
#pragma mark - public methods
-(void)showOnWindow{
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame=CGRectMake(0, SCREEN_HEIGHT-CalendarViewheight, SCREEN_WIDTH, CalendarViewheight);
    }];
}
#pragma mark - private methods
-(void)updateDateLabel{
    self.dateLabel.text=[NSString stringWithFormat:@"%ld年 %ld月",[self convertDateToYear:self.date],[self convertDateToMonth:self.date]];
}
//根据date获取日
- (NSInteger)convertDateToDay:(NSDate *)date {
    NSDateComponents *components = [self.calendar components:(NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//根据date获取月
- (NSInteger)convertDateToMonth:(NSDate *)date {
    NSDateComponents *components = [self.calendar components:(NSCalendarUnitMonth) fromDate:date];
    return [components month];
}

//根据date获取年
- (NSInteger)convertDateToYear:(NSDate *)date {
    NSDateComponents *components = [self.calendar components:(NSCalendarUnitYear) fromDate:date];
    return [components year];
}
//获取某一个月里有几天
- (NSInteger)convertDateToTotalDays:(NSDate *)date{
    NSRange daysInOfMonth = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}
//获取某一个月里第一天是周几
- (NSInteger)convertDateToFirstWeekDay:(NSDate *)date {
    [self.calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [self.calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [self.calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;  //美国时间周日为星期的第一天，所以周日-周六为1-7，改为0-6方便计算
}
//判断两个日期是否相同(忽略天数)
-(BOOL)compareDate:(NSDate *)date1 withDate:(NSDate *)date2{
    NSDateFormatter *formater=[NSDateFormatter new];
    [formater setDateFormat:@"yyyy-MM"];
    NSString *str1=[formater stringFromDate:date1];
    NSString *str2=[formater stringFromDate:date2];
    if([str1 isEqualToString:str2])return YES;
    else return NO;
}
//根据偏移更新date
- (void)updateDateWithOffsetMonths:(NSInteger)offsetMonths {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:offsetMonths];  //year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    self.date= [self.calendar dateByAddingComponents:lastMonthComps toDate:self.date options:0];
}
- (void)updateDateWithOffsetDays:(NSInteger)offsetDays {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setDay:offsetDays];
    self.date= [self.calendar dateByAddingComponents:lastMonthComps toDate:self.date options:0];
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0)return 7;
    else{
        return 42;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCollectionViewCell" forIndexPath:indexPath];
    if(indexPath.section==0){
        NSArray *weekArray=[[NSArray alloc] initWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
        cell.label.text=weekArray[indexPath.row];
    }else{
        if(indexPath.row>=[self convertDateToFirstWeekDay:self.date] && indexPath.row<=[self convertDateToTotalDays:self.date]+[self convertDateToFirstWeekDay:self.date]-1){
            cell.label.text=[NSString stringWithFormat:@"%ld",indexPath.row-[self convertDateToFirstWeekDay:self.date]+1];
            if (indexPath.row-[self convertDateToFirstWeekDay:self.currentDate]+1==[self convertDateToDay:self.currentDate] && [self compareDate:self.currentDate withDate:self.date]) {
                cell.label.backgroundColor=[UIColor colorWithRed:255/255.0f green:128/255.0f blue:0 alpha:1];
            }
            else if(indexPath.row-[self convertDateToFirstWeekDay:self.realDate]+1==[self convertDateToDay:self.realDate] && [self compareDate:self.realDate withDate:self.date]){
                [cell.label setTextColor:[UIColor colorWithRed:255/255.0f green:128/255.0f blue:0 alpha:1]];
            }
        }
    }
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        NSInteger oldDay=[self convertDateToDay:self.date];
        NSInteger newDay=indexPath.row-[self convertDateToFirstWeekDay:self.date]+1;
        [self updateDateWithOffsetDays:newDay-oldDay];
        
        
        
        NSInteger day;
        day=indexPath.row-[self convertDateToFirstWeekDay:self.date]+1;
        [self.delegate updateCalculateViewWithYear:[self convertDateToYear:self.date] Month:[self convertDateToMonth:self.date] Day:day];
        [self.delegate updateCalculateViewWithDate:self.date];
        [self dismiss];
    }
}
#pragma mark - getters
-(UIView *)maskView{
    if(!_maskView){
        _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        _maskView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    return _maskView;
}
-(UIView *)contentView{
    if(!_contentView){
        _contentView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,CalendarViewheight)];
        _contentView.backgroundColor=[UIColor whiteColor];
    }
    return _contentView;
}
-(UILabel *)dateLabel{
    if(!_dateLabel){
        _dateLabel=[[UILabel alloc] init];
        _dateLabel.text=[NSString stringWithFormat:@"%ld年 %ld月",[self convertDateToYear:self.currentDate],[self convertDateToMonth:self.currentDate]];
    }
    return _dateLabel;
}
-(NSCalendar *)calendar{
    if(!_calendar){
        _calendar=[NSCalendar currentCalendar];
    }
    return _calendar;
}
-(NSDate *)date{
    if(!_date){
        _date=[NSDate date];
    }
    return _date;
}
-(NSDate *)currentDate{
    if(!_currentDate){
        _currentDate=[NSDate date];
    }
    return _currentDate;
}
-(NSDate *)realDate{
    if(!_realDate){
        _realDate=[NSDate date];
    }
    return _realDate;
}
-(UIButton *)leftButton{
    if(!_leftButton){
        UIButton *btn=[UIButton new];
        [btn setTitle:@"上月" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton=btn;
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if(!_rightButton){
        UIButton *btn=[UIButton new];
        [btn setTitle:@"下月" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton=btn;
    }
    return _rightButton;
}
-(UICollectionView *)calendarCollectionView{
    if(!_calendarCollectionView){
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize=CGSizeMake(SCREEN_WIDTH/7, (CalendarViewheight-30)/7);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _calendarCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, CalendarViewheight-30) collectionViewLayout:layout];
        [_calendarCollectionView registerClass:[CalendarCollectionViewCell class] forCellWithReuseIdentifier:@"CalendarCollectionViewCell"];
        _calendarCollectionView.backgroundColor=[UIColor whiteColor];
        _calendarCollectionView.dataSource=self;
        _calendarCollectionView.delegate=self;
    }
    return _calendarCollectionView;
}
@end
