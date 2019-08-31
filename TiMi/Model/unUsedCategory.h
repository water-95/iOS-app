//
//  unUsedCategory.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/29.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <Realm/Realm.h>

@interface unUsedCategory : RLMObject

@property(nonatomic,copy)NSString *categoryImageFileName;
@property(nonatomic,assign)BOOL isIncome;

@end
