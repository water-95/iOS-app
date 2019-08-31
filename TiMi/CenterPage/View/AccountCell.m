//
//  AccountCell.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/25.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "AccountCell.h"
#import "Const.h"

@implementation AccountCell

#pragma mark life cycle
-(void)prepareForReuse{
    [super prepareForReuse];
    self.dateLabel.text=nil;
    self.isLastAccount=NO;
    self.daylyMoneyLabel.text=nil;
    self.pointView.backgroundColor=LineColor;
    self.ishideCategoryNameAndMoney=NO;
    self.categoryNameLabel.hidden=NO;
    self.moneyLabel.hidden=NO;
    NSMutableArray *deleteAndEditViewArray=[NSMutableArray array];
    for(UIView *view in self.subviews){
        if(view.tag==100 || view.tag==101)[deleteAndEditViewArray addObject:view];
    }
    for(UIView *view in deleteAndEditViewArray)[view removeFromSuperview];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.ishideCategoryNameAndMoney=NO;
        [self.contentView addSubview:self.pointView];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.daylyMoneyLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.categoryIconView];
        [self.contentView addSubview:self.categoryNameLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.remarkLabel];
    }
    return self;
}

#pragma mark private methods
//* 设置label的内容优先级 */
- (void)setContentPriorityWithLabel:(UILabel *)label {
    //* 设置不被压缩 */
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //* 设置不被拉宽 */
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}
#pragma mark public methods
-(void)hideCategoryNameAndMoney{
//    self.categoryNameLabel.textColor=[UIColor whiteColor];
//    self.moneyLabel.textColor=[UIColor whiteColor];
    self.categoryNameLabel.hidden=YES;
    self.moneyLabel.hidden=YES;
}
-(void)showCategoryNameAndMoney{
//    self.categoryNameLabel.textColor=[UIColor blackColor];
//    self.moneyLabel.textColor=LineColor;
    self.categoryNameLabel.hidden=NO;
    self.moneyLabel.hidden=NO;
}
#pragma mark - getters

-(UILabel *)dateLabel{
    if(!_dateLabel){
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kTextFont];
        label.textAlignment = NSTextAlignmentRight;
        
        _dateLabel = label;
    }
    return _dateLabel;
}
-(UILabel *)daylyMoneyLabel{
    if(!_daylyMoneyLabel){
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kTextFont];
        _daylyMoneyLabel = label;
    }
    return _daylyMoneyLabel;
}
-(UIView *)pointView{
    if(!_pointView){
        _pointView = [UIView new];
        _pointView.backgroundColor = LineColor;
        _pointView.layer.cornerRadius = kTimePointViewWidth/2;
    }
    return _pointView;
}
-(UIImageView *)categoryIconView{
    if(!_categoryIconView){
        UIImageView *imgView=[UIImageView new];
        _categoryIconView=imgView;
    }
    return _categoryIconView;
}
-(UILabel *)categoryNameLabel{
    if(!_categoryNameLabel){
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:kMoneyFont];
        label.textAlignment = NSTextAlignmentRight;
        [self setContentPriorityWithLabel:label];
        _categoryNameLabel = label;
    }
    return _categoryNameLabel;
}
-(UILabel *)moneyLabel{
    if(!_moneyLabel){
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kMoneyFont];
        label.textAlignment = NSTextAlignmentRight;
        [self setContentPriorityWithLabel:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}
-(UILabel *)remarkLabel{
    if(!_remarkLabel){
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kRemarkFont];
        label.textAlignment = NSTextAlignmentRight;
        [self setContentPriorityWithLabel:label];
        _remarkLabel = label;
    }
    return _remarkLabel;
}
-(UIView *)lineView{
    if(!_lineView){
        _lineView = [UIView new];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

@end
