//
//  PieView.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/22.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieView : UIView

/** 分组数据 */
@property (nonatomic, strong) NSArray *sections;
/** 分组数据对应颜色 */
@property (nonatomic, strong) NSArray *sectionColors;
/** 距离外layer间距 */
@property (nonatomic, assign) CGFloat spacing;      //Default == 6
/** 饼图线条宽*/
@property (nonatomic, assign) CGFloat lineWidth;    //Default == 8
/** 线边颜色 */
@property (nonatomic, strong) UIColor *animationStrokeColor; //Default whiteColor
/** 刷新数据 */
- (void)reloadDataCompletion:(void (^)())completion;
/** 获取layer的位置 */
- (NSInteger)getLayerIndexWithPoint:(CGPoint)point;
/** 消失动画 */
- (void)dismissAnimationByTimeInterval:(NSTimeInterval)time;

@end
