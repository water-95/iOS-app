//
//  Account.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/10.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "Account.h"

@implementation Account

-(instancetype)initWithCategory:(UsedCategory *)category andDate:(NSDate *)date{
    self=[super init];
    if(self){
        self.category=category;
        self.date=date;
        self.remark=nil;
        self.BookID=nil;
        self.money=0.00f;
    }
    return self;
}
@end
