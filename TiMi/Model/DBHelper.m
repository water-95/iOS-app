//
//  DBHelper.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/25.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "DBHelper.h"
#import <SVProgressHUD/SVProgressHUD.h>
static NSString *const CategoryFileType             =   @"plist";
static NSString *const UsedCategoryPath             =   @"UsedCategory";
static NSString *const UnUsedCategoryPath           =   @"UnUsedCategory";
static NSString *const UsedCategoryIsIncome         =   @"isIncome";
static NSString *const UsedCategoryImageFileName    =   @"categoryImageFileName";
static NSString *const UsedCategoryTitle            =   @"categoryTitle";
static NSString *const UnUsedCategoryImageFileName  =   @"categoryImageFileName";
static NSString *const UnUsedCategoryIsIncome       =   @"isIncome";

static DBHelper *sharedDBHelper=nil;
static NSInteger realmCurrentVersion = 1;
@implementation DBHelper
#pragma mark - init method
+(instancetype)sharedDBHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDBHelper=[[self alloc] init];
    });
    return sharedDBHelper;
}
#pragma mark - UsedCategory method
-(NSArray *)loadUsedCategory{
    NSMutableArray *usedCategorys=[NSMutableArray array];
    RLMResults *categoryArray=[UsedCategory allObjects];
    if(categoryArray.count==0){
        //从plist中拿到category
        NSString *filePath=[[NSBundle mainBundle] pathForResource:UsedCategoryPath ofType:CategoryFileType];
        NSArray *tempArray=[NSArray arrayWithContentsOfFile:filePath];
        for(int i=0;i<tempArray.count;i++){
            UsedCategory *category=[UsedCategory new];
            category.isIncome=[[tempArray[i] objectForKey:UsedCategoryIsIncome] intValue];
            category.categoryImageFileName=[tempArray[i] objectForKey:UsedCategoryImageFileName];
            category.categoryTitle=[tempArray[i] objectForKey:UsedCategoryTitle];
            category.isChecked=YES;
            [usedCategorys addObject:category];
        }
        //将category加入到realm
        RLMRealm *realm=[RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            for(UsedCategory *category in usedCategorys)[realm addObject:category];
        }];
    }else{
        for(int i=0;i<categoryArray.count;i++)[usedCategorys addObject:[categoryArray objectAtIndex:i]];
    }
    return usedCategorys;
}
-(NSArray *)loadUsedCategoryWithType:(UsedCategoryType)type{
    NSMutableArray *result=[NSMutableArray array];
    NSArray *usedCategorys=[self loadUsedCategory];
    for(UsedCategory *category in usedCategorys){
        switch (type) {
            case spendWithCheck:
                if(!category.isIncome && category.isChecked)[result addObject:category];
                break;
            case spendWithOutCheck:
                if(!category.isIncome && !category.isChecked)[result addObject:category];
                break;
            case incomeWithCheck:
                if(category.isIncome && category.isChecked)[result addObject:category];
                break;
            case incomeWithOutCheck:
                if(category.isIncome && !category.isChecked)[result addObject:category];
                break;
            default:
                break;
        }
    }
    return result;
}
-(UsedCategory *)loadUsedCategoryWithImageName:(NSString *)imageName{
    RLMResults *result=[UsedCategory objectsWhere:@"categoryImageFileName = %@",imageName];
    return result.firstObject;
}
-(void)updateCategory:(UsedCategory *)category withNewTitle:(NSString *)newTitle{
    if(newTitle.length>4){
        [self showSVProgressHUD:@"类别名称不能超过4个字符"];
        return;
    }
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        category.categoryTitle=newTitle;
    }];
}

#pragma mark - unUsedCategory method
-(NSArray *)loadUnUsedCategory{
    NSMutableArray *unUsedCategorys=[NSMutableArray array];
    RLMResults *categoryArray=[unUsedCategory allObjects];
    if(categoryArray.count==0){
        //从plist中拿到category
        NSString *filePath=[[NSBundle mainBundle] pathForResource:UnUsedCategoryPath ofType:CategoryFileType];
        NSArray *tempArray=[NSArray arrayWithContentsOfFile:filePath];
        for(int i=0;i<tempArray.count;i++){
            unUsedCategory *category=[unUsedCategory new];
            category.isIncome=[[tempArray[i] objectForKey:UnUsedCategoryIsIncome] intValue];
            category.categoryImageFileName=[tempArray[i] objectForKey:UnUsedCategoryImageFileName];
            [unUsedCategorys addObject:category];
        }
        //将category加入到realm
        RLMRealm *realm=[RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            for(unUsedCategory *category in unUsedCategorys)[realm addObject:category];
        }];
    }else{
        for(int i=0;i<categoryArray.count;i++)[unUsedCategorys addObject:[categoryArray objectAtIndex:i]];
    }
    return unUsedCategorys;
}

#pragma mark - Account method
-(NSArray *)loadAccountWithBookID:(NSString *)bookID{
    NSMutableArray *accounts=[NSMutableArray array];
    RLMResults *results=[[Account objectsWhere:@"BookID = %@",bookID] sortedResultsUsingKeyPath:@"date" ascending:NO];
    for(int i=0;i<results.count;i++)[accounts addObject:[results objectAtIndex:i]];
    return accounts;
}
-(void)addAccount:(Account *)account{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:account];
    }];
    [self postNotificationOfAddOrDeleteAccount];
}
-(void)deleteAccount:(NSDate *)date{
    RLMResults *account=[Account objectsWhere:@"date = %@",date];
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteObject:account.firstObject];
    }];
    [self postNotificationOfAddOrDeleteAccount];
}

#pragma mark - Book method
-(NSInteger)numberOfAccountsWithBookName:(NSString *)bookName{
    NSArray *accountArray=[self loadAccountWithBookID:bookName];
    return accountArray.count;
}
-(BOOL)addNewBook:(Book *)book{
    RLMResults *result=[Book objectsWhere:@"bookNameString = %@",book.bookNameString];
    if(result.count>0){
        [self showSVProgressHUD:@"已经存在相同名字的账本"];
        return NO;
    }
    if(book.bookNameString.length>4){
        [self showSVProgressHUD:@"账本名称不能超过4个字符"];
        return NO;
    }
    result=[Book allObjects];
    RLMRealm *realm=[RLMRealm defaultRealm];
    for(Book *iterator in result){
        [realm transactionWithBlock:^{
            iterator.isSelected=NO;
        }];
    }
    [realm transactionWithBlock:^{
        [realm addObject:book];
    }];
    return YES;
}
-(NSArray *)loadBooks{
    NSMutableArray *books=[NSMutableArray array];
    RLMResults *result=[Book allObjects];
    if(result.count==0){
        Book *book=[Book new];
        book.coverImageNameString=@"book_cover_0";
        book.bookNameString=@"日常账本";
        book.isSelected=YES;
        [self addNewBook:book];
        [books addObject:book];
    }else{
        Book *selectedBook;
        for(int i=0;i<result.count;i++){
            Book *book=[result objectAtIndex:i];
            if(!book.isSelected)[books addObject:book];
            else selectedBook=book;
        }
        [books insertObject:selectedBook atIndex:0];
    }
    return books;
}
-(void)updateBookState:(NSString *)bookName{
    RLMRealm *realm=[RLMRealm defaultRealm];
    RLMResults *result=[Book allObjects];
    for(Book *iterator in result){
        if([iterator.bookNameString isEqualToString:bookName]){
            [realm transactionWithBlock:^{
                iterator.isSelected=YES;
            }];
        }
        else {
            [realm transactionWithBlock:^{
                iterator.isSelected=NO;
            }];
        }
    }
}

#pragma mark - warning method
-(void)showSVProgressHUD:(NSString *)text{
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD showImage:nil status:text];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:18]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}
#pragma mark - date migration
-(void)dateMigration{
    //1.获取默认配置
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    //2.叠加版本号(要比上一次的版本号高) 默认版本号0
    NSInteger oldVersion=config.schemaVersion;
    NSLog(@"oldSchemaVersion=%ld",oldVersion);
    NSInteger newVersion = oldVersion+1;
    config.schemaVersion = newVersion;
    //3.具体怎样迁移
    [config setMigrationBlock:^(RLMMigration *migration, uint64_t oldSchemaVersion){
        if (oldSchemaVersion < newVersion) {
            NSLog(@"需要做迁移操作");
        }
    }];
    //4.让配置生效
    [RLMRealmConfiguration setDefaultConfiguration:config];
    //5.如果需要立即生效
    [RLMRealm defaultRealm];
}
-(void)setVersion{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion=realmCurrentVersion;
    [RLMRealmConfiguration setDefaultConfiguration:config];
}
#pragma mark - number of account changed notification
-(void)postNotificationOfAddOrDeleteAccount{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"account addordelete" object:nil];
}
@end
