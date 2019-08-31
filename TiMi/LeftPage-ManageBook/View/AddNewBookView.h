//
//  AddNewBookView.h
//  TiMi
//
//  Created by 江滨耀 on 2019/8/21.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddNewBookViewDelegate<NSObject>
-(void)addBookWithTitle:(NSString *)title CoverImage:(NSString *)imageName;
-(void)cancelAddBook;
@end

@interface AddNewBookView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *rowLineView1;
@property(nonatomic,strong)UIView *rowLineView2;
@property(nonatomic,strong)UIView *rowLineView3;
@property(nonatomic,strong)UIView *colLineView;
@property(nonatomic,strong)UITextField *bookNameTextField;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *currencyLabel;
@property(nonatomic,strong)UILabel *currencyLabelSymbol;
@property(nonatomic,strong)UIButton *cacelButton;
@property(nonatomic,strong)UIButton *saveButton;
@property(nonatomic,assign)NSUInteger selectedIndex;
@property(nonatomic,weak)id<AddNewBookViewDelegate> delegate;
@end
