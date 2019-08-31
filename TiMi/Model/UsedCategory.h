//
//  UsedCategory.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/28.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <Realm/Realm.h>

@interface UsedCategory : RLMObject

@property(nonatomic,copy)NSString *categoryTitle;
@property(nonatomic,copy)NSString *categoryImageFileName;
@property(nonatomic,assign)BOOL isIncome;
@property(nonatomic,assign)BOOL isChecked;

@end
