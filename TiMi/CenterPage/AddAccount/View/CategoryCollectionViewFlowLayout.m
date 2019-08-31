//
//  CategoryCollectionViewFlowLayout.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/26.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "CategoryCollectionViewFlowLayout.h"
#import "Const.h"
@implementation CategoryCollectionViewFlowLayout

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        //* 设置item的尺寸 */
        self.itemSize=CGSizeMake(kCollectionCellWidth, kCollectionCellWidth);
        //* 设置 “列” 间距 */
        self.minimumInteritemSpacing=0;
        //* 设置 “行” 间距 */
        //        self.minimumLineSpacing=10;
        
        /** 设置瀑布流方向 */
        //        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return self;
}

@end
