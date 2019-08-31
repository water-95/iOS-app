//
//  CalendarCollectionViewCell.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/7.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "CalendarCollectionViewCell.h"

@implementation CalendarCollectionViewCell
#pragma mark - life cycle
-(void)prepareForReuse{
    self.label.text=nil;
    self.label.backgroundColor=[UIColor whiteColor];
    self.label.textColor=[UIColor blackColor];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}
#pragma mark - getters
-(UILabel *)label{
    if(!_label){
        _label=[UILabel new];
        _label.frame=self.bounds;
        [_label setFont:[UIFont systemFontOfSize:17]];
        _label.textAlignment=NSTextAlignmentCenter;
    }
    return _label;
}
@end
