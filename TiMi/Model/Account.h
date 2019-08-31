//
//  Account.h
//  TiMi
//
//  Created by 江滨耀 on 2019/8/10.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <Realm/Realm.h>
#import "UsedCategory.h"

@interface Account : RLMObject

@property(nonatomic,copy)NSString *remark;
@property(nonatomic,strong)UsedCategory *category;
@property(nonatomic,copy)NSString *BookID;
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,assign)float money;
-(instancetype)initWithCategory:(UsedCategory *)category andDate:(NSDate *)date;
@end

