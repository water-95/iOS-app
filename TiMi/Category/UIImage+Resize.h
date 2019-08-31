//
//  UIImage+Resize.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/29.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface UIImage (Resize)
-(UIImage *)imageByResizeToSize:(CGSize)size;
-(UIColor *)mainColor;

@end
