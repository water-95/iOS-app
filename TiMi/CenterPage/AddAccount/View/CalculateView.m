//
//  CalculateView.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/30.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "CalculateView.h"
#import <Masonry/Masonry.h>
#define buttonColor [UIColor colorWithWhite:0.950 alpha:1.000];

@implementation CalculateView
#pragma mark - life cycle
-(instancetype)init{
    self=[super init];
    if(self){
        [self addSubview:self.headView];
        [self addSubview:self.containView1];
        [self addSubview:self.containView2];
        [self addSubview:self.containView3];
        [self addSubview:self.containView4];
        [self addSubview:self.footView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //headview
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.18);
    }];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_top).offset(5);
        make.centerX.mas_equalTo(self.headView.mas_centerX).multipliedBy(0.25);
        make.size.mas_equalTo(CGSizeMake(60, 13.5));
        
    }];
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yearLabel.mas_bottom);
        make.centerX.mas_equalTo(self.yearLabel.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 16.5));
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yearLabel.mas_top);
        make.centerX.mas_equalTo(self.yearLabel.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headView.mas_centerX).multipliedBy(1.75);
        make.centerY.mas_equalTo(self.leftButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    //containview1
    [self.containView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.headView.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.headView.mas_leading);
        make.width.mas_equalTo(self.mas_width).offset(-0.75).multipliedBy(0.25);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-25);
    }];
    [self.Button1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView1.mas_centerX);
        make.top.left.right.mas_equalTo(self.containView1);
        make.height.mas_equalTo(self.containView1.mas_height).offset(-0.75).multipliedBy(0.25);
    }];
    [self.Button4 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView1.mas_centerX);
        make.top.mas_equalTo(self.Button1.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView1.mas_leading);
        make.trailing.mas_equalTo(self.containView1.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.Button7 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView1.mas_centerX);
        make.top.mas_equalTo(self.Button4.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView1.mas_leading);
        make.trailing.mas_equalTo(self.containView1.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.ButtonClear mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView1.mas_centerX);
        make.top.mas_equalTo(self.Button7.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView1.mas_leading);
        make.trailing.mas_equalTo(self.containView1.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    //containview2
    [self.containView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.headView.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView1.mas_trailing).offset(1);
        make.width.mas_equalTo(self.containView1.mas_width);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-25);
    }];
    [self.Button2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView2.mas_centerX);
        make.top.left.right.mas_equalTo(self.containView2);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.Button5 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView2.mas_centerX);
        make.top.mas_equalTo(self.Button2.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView2.mas_leading);
        make.trailing.mas_equalTo(self.containView2.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.Button8 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView2.mas_centerX);
        make.top.mas_equalTo(self.Button5.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView2.mas_leading);
        make.trailing.mas_equalTo(self.containView2.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.Button0 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView2.mas_centerX);
        make.top.mas_equalTo(self.Button8.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView2.mas_leading);
        make.trailing.mas_equalTo(self.containView2.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    //containview3
    [self.containView3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.headView.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView2.mas_trailing).offset(1);
        make.width.mas_equalTo(self.containView1.mas_width);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-25);
    }];
    [self.Button3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView3.mas_centerX);
        make.top.leading.trailing.mas_equalTo(self.containView3);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.Button6 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView3.mas_centerX);
        make.top.mas_equalTo(self.Button3.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView3.mas_leading);
        make.trailing.mas_equalTo(self.containView3.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.Button9 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView3.mas_centerX);
        make.top.mas_equalTo(self.Button6.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView3.mas_leading);
        make.trailing.mas_equalTo(self.containView3.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.ButtonPoint mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView3.mas_centerX);
        make.top.mas_equalTo(self.Button9.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView3.mas_leading);
        make.trailing.mas_equalTo(self.containView3.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    //containview4
    [self.containView4 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.headView.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView3.mas_trailing).offset(1);
        make.width.mas_equalTo(self.containView1.mas_width);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-25);
    }];
    [self.ButtonAdd mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView4.mas_centerX);
        make.top.left.right.mas_equalTo(self.containView4);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.ButtonMinus mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView4.mas_centerX);
        make.top.mas_equalTo(self.ButtonAdd.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView4.mas_leading);
        make.trailing.mas_equalTo(self.containView4.mas_trailing);
        make.height.mas_equalTo(self.Button1.mas_height);
    }];
    [self.ButtonSave mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.containView4.mas_centerX);
        make.top.mas_equalTo(self.ButtonMinus.mas_bottom).offset(1);
        make.leading.mas_equalTo(self.containView4.mas_leading);
        make.trailing.mas_equalTo(self.containView4.mas_trailing);
        make.bottom.mas_equalTo(self.containView4.mas_bottom);
    }];
    //footview
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.containView1.mas_bottom).offset(1);
        make.left.right.bottom.mas_equalTo(self);
    }];
    
    

    
}
#pragma mark - action
-(void)didclickBtn:(UIButton *)sender{
    //tag:0 left button
    //tag:1 right button
    //tag:2 other button
    switch (sender.tag) {
        case 0:
            NSLog(@"openCalendarView");
            [self.calculateViewDelegate openCalendarView];
            break;
        case 1:
            [self.calculateViewDelegate openRemarkView];
            break;
        case 2:
            [self.calculateViewDelegate sendVal:sender];
            if([sender.titleLabel.text isEqualToString:@"+"] || [sender.titleLabel.text isEqualToString:@"-"])[self.ButtonSave setTitle:@"=" forState:UIControlStateNormal];
            else if ([sender.titleLabel.text isEqualToString:@"="])[self.ButtonSave setTitle:@"OK" forState:UIControlStateNormal];
            break;
    }
}
-(void)didclickBtn:(UIButton *)send completion:(void(^)(UIButton *send)) block{
    //tag:0 left button
    //tag:1 right button
    //tag:2 other button
    block(send);
}
#pragma mark - getters
-(UILabel *)yearLabel{
    if(!_yearLabel){
        NSDate *  currentDate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy"];
        NSString *currentYearString=[dateformatter stringFromDate:currentDate];
        _yearLabel=[[UILabel alloc] init];
        _yearLabel.font=[UIFont systemFontOfSize:11];
        _yearLabel.textColor=[UIColor colorWithWhite:0.5 alpha:1];
        _yearLabel.backgroundColor=[UIColor clearColor];
        _yearLabel.text=currentYearString;
        _yearLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _yearLabel;
}
-(UILabel *)monthLabel{
    if(!_monthLabel){
        _monthLabel=[[UILabel alloc] init];
        _monthLabel.font=[UIFont systemFontOfSize:13];
        _monthLabel.text=@"今天";
        _monthLabel.textAlignment=NSTextAlignmentCenter;
        _monthLabel.textColor=[UIColor colorWithWhite:0.5 alpha:1];
        _monthLabel.backgroundColor=[UIColor clearColor];
    }
    return _monthLabel;
}
-(UIButton *)leftButton{
    if(!_leftButton){
        UIButton *btn=[UIButton new];
        btn.tag=0;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        _leftButton=btn;
    }
    return _leftButton;
}
-(UIView *)headView{
    if(!_headView){
        _headView=[UIView new];
        _headView.backgroundColor=[UIColor colorWithWhite:0.986 alpha:1.000];
        [_headView addSubview:self.yearLabel];
        [_headView addSubview:self.monthLabel];
        [_headView addSubview:self.leftButton];
        [_headView addSubview:self.rightButton];
    }
    return _headView;
}
-(UIButton *)rightButton{
    if(!_rightButton){
        UIButton *btn=[UIButton new];
        btn.tag=1;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        if(btn.imageView.image==nil)NSLog(@"图片丢失了");
        _rightButton=btn;
    }
    return _rightButton;
}
-(UIButton *)Button0{
    if(!_Button0){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"0" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
        _Button0=btn;
    }
    return _Button0;
}
-(UIButton *)Button1{
    if(!_Button1){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"1" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button1=btn;
    }
    return _Button1;
}
-(UIButton *)Button2{
    if(!_Button2){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"2" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button2=btn;
    }
    return _Button2;
}
-(UIButton *)Button3{
    if(!_Button3){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"3" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button3=btn;
    }
    return _Button3;
}
-(UIButton *)Button4{
    if(!_Button4){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"4" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button4=btn;
    }
    return _Button4;
}
-(UIButton *)Button5{
    if(!_Button5){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"5" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button5=btn;
    }
    return _Button5;
}
-(UIButton *)Button6{
    if(!_Button6){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"6" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button6=btn;
    }
    return _Button6;
}
-(UIButton *)Button7{
    if(!_Button7){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"7" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button7=btn;
    }
    return _Button7;
}
-(UIButton *)Button8{
    if(!_Button8){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"8" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button8=btn;
    }
    return _Button8;
}
-(UIButton *)Button9{
    if(!_Button9){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"9" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button9=btn;
    }
    return _Button9;
}
-(UIButton *)ButtonPoint{
    if(!_ButtonPoint){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"." forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ButtonPoint=btn;
    }
    return _ButtonPoint;
}
-(UIButton *)ButtonAdd{
    if(!_ButtonAdd){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"+" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ButtonAdd=btn;
    }
    return _ButtonAdd;
}
-(UIButton *)ButtonMinus{
    if(!_ButtonMinus){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"-" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ButtonMinus=btn;
    }
    return _ButtonMinus;
}
-(UIButton *)ButtonClear{
    if(!_ButtonClear){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"清零" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ButtonClear=btn;
    }
    return _ButtonClear;
}
-(UIButton *)ButtonSave{
    if(!_ButtonSave){
        UIButton *btn=[UIButton new];
        btn.tag=2;
        [btn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=buttonColor;
        [btn setTitle:@"OK" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:26 weight:UIFontWeightLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ButtonSave=btn;
    }
    return _ButtonSave;
}
-(UIView *)containView1{
    if(!_containView1){
        _containView1=[UIView new];
        _containView1.backgroundColor=[UIColor clearColor];
        [_containView1 addSubview:self.Button1];
        [_containView1 addSubview:self.Button4];
        [_containView1 addSubview:self.Button7];
        [_containView1 addSubview:self.ButtonClear];
    }
    return _containView1;
}
-(UIView *)containView2{
    if(!_containView2){
        _containView2=[UIView new];
        _containView2.backgroundColor=[UIColor clearColor];
        [_containView2 addSubview:self.Button2];
        [_containView2 addSubview:self.Button5];
        [_containView2 addSubview:self.Button8];
        [_containView2 addSubview:self.Button0];
    }
    return _containView2;
}
-(UIView *)containView3{
    if(!_containView3){
        _containView3=[UIView new];
        _containView3.backgroundColor=[UIColor clearColor];
        [_containView3 addSubview:self.Button3];
        [_containView3 addSubview:self.Button6];
        [_containView3 addSubview:self.Button9];
        [_containView3 addSubview:self.ButtonPoint];
    }
    return _containView3;
}
-(UIView *)containView4{
    if(!_containView4){
        _containView4=[UIView new];
        _containView4.backgroundColor=[UIColor clearColor];
        [_containView4 addSubview:self.ButtonAdd];
        [_containView4 addSubview:self.ButtonMinus];
        [_containView4 addSubview:self.ButtonSave];
    }
    return _containView4;
}
-(UIView *)footView{
    if(!_footView){
        _footView=[UIView new];
        _footView.backgroundColor=buttonColor;
    }
    return _footView;
}
-(NSDate *)date{
    if(!_date){
        _date=[NSDate date];
    }
    return _date;
}
@end
