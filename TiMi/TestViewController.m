//
//  TestViewController.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/28.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "TestViewController.h"
#import "DBHelper.h"
#import <Realm/Realm.h>

@interface TestViewController ()
@property(nonatomic,strong)DBHelper *dbHelper;
@end

@implementation TestViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //delete allobjects
//    RLMRealm *realm=[RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm deleteAllObjects];
//    }];
    
//    //load categorys
//    [self.dbHelper loadUsedCategory];
//    [self.dbHelper loadUnUsedCategory];
    
    //update category title
    NSArray *categoryArray=[NSArray arrayWithArray:[self.dbHelper loadUsedCategory]];
    for(UsedCategory *category in categoryArray){
        if([category.categoryTitle isEqualToString:@"用餐test"]){
            NSLog(@"start to update");
            [self.dbHelper updateCategory:category.categoryImageFileName withNewTitle:@"用餐"];
            break;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - getters
-(DBHelper *)dbHelper{
    if(!_dbHelper){
        _dbHelper=[DBHelper sharedDBHelper];
    }
    return _dbHelper;
}
@end
