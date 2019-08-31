//
//  DBHelper.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/25.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UsedCategory.h"
#import "unUsedCategory.h"
#import "Account.h"
#import "Book.h"

@interface DBHelper : NSObject
typedef enum : NSUInteger {
    spendWithOutCheck,
    incomeWithOutCheck,
    spendWithCheck,
    incomeWithCheck
} UsedCategoryType;
+(instancetype)sharedDBHelper;
-(NSArray *)loadUsedCategory;
-(NSArray *)loadUnUsedCategory;
-(NSArray *)loadUsedCategoryWithType:(UsedCategoryType)type;
-(void)updateCategory:(UsedCategory *)category withNewTitle:(NSString *)newTitle;
-(UsedCategory *)loadUsedCategoryWithImageName:(NSString *)imageName;

-(NSArray *)loadAccountWithBookID:(NSString *)bookID;
-(void)addAccount:(Account *)account;
-(void)deleteAccount:(NSDate *)date;

-(NSInteger)numberOfAccountsWithBookName:(NSString *)name;
-(BOOL)addNewBook:(Book *)book;
-(NSArray *)loadBooks;
-(void)updateBookState:(NSString *)bookName;
-(void)dateMigration;
-(void)setVersion;
-(void)showSVProgressHUD:(NSString *)text;

@end
