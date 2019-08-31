//
//  AddAccountViewController.h
//  TiMi
//
//  Created by 江滨耀 on 2019/7/26.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TransDelegate;
@protocol AddAccountViewControllerDelegate<NSObject>
@required
-(void)reloadTableViewInCenterView;
-(void)AddAccountViewControllerDisMiss;
@end
@interface AddAccountViewController : UIViewController
@property(nonatomic,weak)id<AddAccountViewControllerDelegate> delegate;
@property(nonatomic,strong)TransDelegate *transDelegate;
@property(nonatomic,copy)NSString *bookID;
@property(nonatomic,assign)BOOL isAddAccount;
@property(nonatomic,strong)NSDate *deleteAccountWithDate;
-(void)updateViewsWithSelectedCategoryType:(BOOL)isIncom categoryImageName:(NSString *)imageName moneyString:(NSString *)moneyString date:(NSDate *)date;


@end
