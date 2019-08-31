//
//  ManageBookViewController.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/18.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "ManageBookViewController.h"
#import "ManageBookHeadView.h"
#import "Const.h"
#import "BookCell.h"
#import <Masonry/Masonry.h>
#import "DBHelper.h"
#import "ManageViewController.h"
#import "AddNewBookView.h"
#import "AddNewBookView.h"
#import "Book.h"
@interface ManageBookViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,AddNewBookViewDelegate>
@property(nonatomic,strong)ManageBookHeadView *headView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,copy)NSArray *booksArray;
@property(nonatomic,copy)AddNewBookView *addBookView;
@property(nonatomic,strong)UIView *maskView;
@end

@implementation ManageBookViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountChange) name:@"account addordelete" object:nil];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.addBookView];
    [self.view sendSubviewToBack:self.addBookView];
}
-(void)viewWillLayoutSubviews{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width, 40));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(kStatusBarHeight+5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.mas_equalTo(self.view.mas_leading).mas_offset(10);
        make.trailing.mas_equalTo(self.view.mas_trailing).mas_offset(-10);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.booksArray.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"bookCell" forIndexPath:indexPath];
    if(indexPath.row>=self.booksArray.count){
        cell.bookCoverImageView.image=[UIImage imageNamed:@"menu_cell_add"];
        return cell;
    }
    Book *book=self.booksArray[indexPath.row];
    cell.bookCoverImageView.image=[UIImage imageNamed:book.coverImageNameString];
    cell.titleLabel.text=book.bookNameString;
    NSInteger numberOfAccounts=[[DBHelper sharedDBHelper] numberOfAccountsWithBookName:book.bookNameString];
    cell.numberOfAccountsLabel.text=[NSString stringWithFormat:@"%ld笔",numberOfAccounts];
    cell.isSelected=book.isSelected;
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld---%ld",indexPath.section,indexPath.row);
    if(indexPath.row==self.booksArray.count){
        [self.view bringSubviewToFront:self.addBookView];
        [self.addBookView.bookNameTextField becomeFirstResponder];
    }else{
        if(indexPath.row==0){
            [self transitionToNextViewController];
            return;
        }
        BookCell *cell=(BookCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [[DBHelper sharedDBHelper] updateBookState:cell.titleLabel.text];
        [self transitionToNextViewController];
        [self reloadBookArray];
        [self.collectionView reloadData];
    }
}
#pragma mark - AddNewBookViewDelegate
-(void)cancelAddBook{
    self.addBookView.bookNameTextField.text=nil;
    [self.addBookView.bookNameTextField resignFirstResponder];
    [self.view sendSubviewToBack:self.addBookView];
}
-(void)addBookWithTitle:(NSString *)title CoverImage:(NSString *)imageName{
    Book *book=[Book new];
    book.isSelected=YES;
    book.bookNameString=title;
    book.coverImageNameString=imageName;
    if([[DBHelper sharedDBHelper] addNewBook:book]){
        [self reloadBookArray];
        [self.collectionView reloadData];
    }
    [self dismissAddBookView];
}
#pragma mark - private method
-(void)dismissAddBookView{
    [self cancelAddBook];
}
-(void)reloadBookArray{
    _booksArray=[[DBHelper sharedDBHelper] loadBooks];
}
-(void)transitionToNextViewController{
    id tempVC=self;
    while ([tempVC parentViewController]) {
        tempVC=[tempVC parentViewController];
        if([[tempVC class] isEqual:[ManageViewController class]]){
            [tempVC transitionToViewControllerAtIndex:1];
            break;
        }
    }
}
#pragma mark - notification
-(void)accountChange{
    [self.collectionView reloadData];
//    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
}
#pragma mark - getters
-(ManageBookHeadView *)headView{
    if(!_headView){
        _headView=[ManageBookHeadView new];
    }
    return _headView;
}
-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 20;
        layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize=CGSizeMake((SCREEN_SIZE.width-20-2*layout.minimumInteritemSpacing)/3, 1.3*(SCREEN_SIZE.width-20-2*layout.minimumInteritemSpacing)/3);
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[BookCell class] forCellWithReuseIdentifier:@"bookCell"];
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
    }
    return _collectionView;
}
-(NSArray *)booksArray{
    if(!_booksArray){
        //_booksArray=[[DBHelper sharedDBHelper] loadBooks];
        [self reloadBookArray];
    }
    return _booksArray;
}
-(AddNewBookView *)addBookView{
    if(!_addBookView){
        _addBookView=[[AddNewBookView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
        _addBookView.delegate=self;
    }
    return _addBookView;
}
-(UIView *)maskView{
    if(!_maskView){
        _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
        _maskView.backgroundColor=[UIColor whiteColor];
    }
    return _maskView;
}


@end
