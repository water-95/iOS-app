//
//  AddAccountViewController.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/26.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "AddAccountViewController.h"
#import "AddAccountHeadView.h"
#import "Const.h"
#import "UIImage+Resize.h"
#import "CategoryCollectionViewFlowLayout.h"
#import "CategoryCollectionViewCell.h"
#import "DBHelper.h"
#import "CalculateView.h"
#import <Masonry/Masonry.h>
#import "UpdateCategoryNameView.h"
#import "CalendarPickerView.h"
#import "Account.h"
#import "DBHelper.h"
#import "TransDelegate.h"
#import "RemarkViewController.h"

static NSString *const collectionIdentifier = @"categoryCell";
@interface AddAccountViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
CalculateViewDelegate,
AddAccountHeadViewDelegate,
UpdateCategoryNameViewDelegate,
CalendarPickerViewDelegate,
RemarkViewControllerDataSource
>
typedef enum : NSUInteger {
    incomecollectionView,
    spendcollectionView1,
    spendcollectionView2
} CurrentCollectionViewType;
@property(nonatomic,strong)AddAccountHeadView *headView;
@property(nonatomic,strong)UIButton *incomeButton;
@property(nonatomic,strong)UIButton *spendButton;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UICollectionView *incomeCategoryCollectionView;
@property(nonatomic,strong)UICollectionView *spendCategoryCollectionView1;
@property(nonatomic,strong)UICollectionView *spendCategoryCollectionView2;
@property(nonatomic,strong)UIScrollView *spendCategoryScrollView;
@property(nonatomic,strong)UIPageControl *pageController;
@property(nonatomic,strong)CalculateView *calculateView;
@property(nonatomic,strong)UsedCategory *selectedCategory;
@property(nonatomic,copy)NSString *numberStr1;
@property(nonatomic,copy)NSString *numberStr2;
@property(nonatomic,assign)BOOL isAdd;
@property(nonatomic,strong)UpdateCategoryNameView *updateCategoryNameView;
@property(nonatomic,strong)UIView *updateCategoryNameContainView;
@property(nonatomic,assign)NSInteger selectedCategoryPathOfRow;
@property(nonatomic,strong)UIImageView *selectedCellImageView;
@property(nonatomic,assign)BOOL isAnimated;
@property(nonatomic,copy)NSString *remark;
//@property(nonatomic,strong)UIView *groundView;
@end

@implementation AddAccountViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",[self.presentingViewController class]);
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupNavigationBar];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.spendCategoryScrollView];
    [self.view addSubview:self.incomeCategoryCollectionView];
    [self.view addSubview:self.pageController];
    [self.view addSubview:self.calculateView];
    [self.view addSubview:self.updateCategoryNameContainView];
    [self.updateCategoryNameContainView addSubview:self.updateCategoryNameView];
    [self.view addSubview:self.selectedCellImageView];
    [self.view sendSubviewToBack:self.updateCategoryNameContainView];
    [self.view sendSubviewToBack:self.incomeCategoryCollectionView];
    [self.view sendSubviewToBack:self.selectedCellImageView];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.calculateView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.pageController.mas_bottom).offset(15);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    [self.updateCategoryNameView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(300, 140));
        make.top.mas_equalTo(self.view.mas_top).offset(kCollectionFrame.origin.y+25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        //make.top.mas_equalTo(self.incomeCategoryCollectionView.mas_top);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - button actions
-(void)clickIncomeBtn:(UIButton *)sender{
    if(self.incomeButton.selected==NO){
        self.isAnimated=false;
        self.incomeButton.selected=YES;
        self.spendButton.selected=NO;
        [self.view sendSubviewToBack:self.spendCategoryScrollView];
        [self.view bringSubviewToFront:self.incomeCategoryCollectionView];
        //update headview 遵循KVO
        self.selectedCategory=[[DBHelper sharedDBHelper] loadUsedCategoryWithType:incomeWithCheck].firstObject;
        //update pagecontrol
        self.pageController.numberOfPages=1;
    }
    
}
-(void)clickSpendBtn:(UIButton *)sender{
    if(self.spendButton.selected==NO){
        self.isAnimated=false;
        self.spendButton.selected=YES;
        self.incomeButton.selected=NO;
        [self.view sendSubviewToBack:self.incomeCategoryCollectionView];
        [self.view bringSubviewToFront:self.spendCategoryScrollView];
        //update headview 遵循KVO
        self.selectedCategory=[[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck].firstObject;
        //update pagecontrol
        self.pageController.numberOfPages=2;
        //self.pageController.currentPage=0;
        self.spendCategoryScrollView.contentOffset=CGPointMake(0, 0);
    }
}
-(void)clickDisMissBtn:(UIButton *)sender{
    [self dismiss];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView==self.incomeCategoryCollectionView) return [[DBHelper sharedDBHelper] loadUsedCategoryWithType:incomeWithCheck].count + 1;
    else if (collectionView==self.spendCategoryCollectionView1) return 24;
    else return [[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck].count-24 + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    if (collectionView==self.incomeCategoryCollectionView) {//收入类别
        if (indexPath.row == [[DBHelper sharedDBHelper] loadUsedCategoryWithType:incomeWithCheck].count) {
            UsedCategory *category = [UsedCategory new];
            category.categoryImageFileName = @"type_add";
            category.categoryTitle = @"编辑";
            cell.category =category;
        } else {
            cell.category = [[[DBHelper sharedDBHelper] loadUsedCategoryWithType:incomeWithCheck] objectAtIndex:[indexPath row]];
        }
    } else if (collectionView==self.spendCategoryCollectionView1) {
        cell.category = [[[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck] objectAtIndex:[indexPath row]];
    } else {//expenCategoryCollectionView2
        if (indexPath.row+24 == [[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck].count) {
            UsedCategory *category = [UsedCategory new];
            category.categoryImageFileName = @"type_add";
            category.categoryTitle = @"编辑";
            cell.category =category;
        } else {
            cell.category = [[[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck] objectAtIndex:[indexPath row]+24];
        }
    }
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.isAnimated=true;
    if (collectionView==self.incomeCategoryCollectionView) {//收入类别
        
        if(indexPath.row>[[DBHelper sharedDBHelper] loadUsedCategoryWithType:incomeWithCheck].count-1)return;
        //设置selectedCellimageView的frame
        CGRect frame=[collectionView cellForItemAtIndexPath:indexPath].frame;
        frame.origin.y+=self.incomeCategoryCollectionView.frame.origin.y;
        self.selectedCellImageView.frame=frame;
        
        self.selectedCategory=[[[DBHelper sharedDBHelper] loadUsedCategoryWithType:incomeWithCheck] objectAtIndex:indexPath.row];
        self.selectedCategoryPathOfRow=indexPath.row;
        
    } else if (collectionView==self.spendCategoryCollectionView1) {
        
        if(indexPath.row>23)return;
        //设置selectedCellimageView的frame
        CGRect frame=[collectionView cellForItemAtIndexPath:indexPath].frame;
        frame.origin.y+=self.incomeCategoryCollectionView.frame.origin.y;
        self.selectedCellImageView.frame=frame;
        
        self.selectedCategory=[[[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck] objectAtIndex:indexPath.row];
        self.selectedCategoryPathOfRow=indexPath.row;
        
    } else {//expenCategoryCollectionView2
        
        if(indexPath.row+24>[[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck].count-1)return;
        //设置selectedCellimageView的frame
        CGRect frame=[collectionView cellForItemAtIndexPath:indexPath].frame;
        frame.origin.y+=self.incomeCategoryCollectionView.frame.origin.y;
        self.selectedCellImageView.frame=frame;
        
        self.selectedCategory=[[[DBHelper sharedDBHelper] loadUsedCategoryWithType:spendWithCheck] objectAtIndex:indexPath.row+24];
        self.selectedCategoryPathOfRow=indexPath.row+24;
        
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    if(offset.x>0)[self.pageController setCurrentPage:1];
    else [self.pageController setCurrentPage:0];
}

#pragma mark - CalculateViewDelegate
-(void)openRemarkView{
    NSLog(@"openRemarkView");
    RemarkViewController *vc=[[RemarkViewController alloc] init];
    vc.datasource=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)openCalendarView{
    NSLog(@"openCalendarView");
    CalendarPickerView *calendarPickerView=[[CalendarPickerView alloc] initWithSelectedDate:self.calculateView.date];
    calendarPickerView.delegate=self;
    [calendarPickerView showOnWindow];
}
-(void)sendVal:(UIButton *)send{
    NSString *val=send.titleLabel.text;
    if([val isEqualToString:@"+"] || [val isEqualToString:@"-"] || [val isEqualToString:@"="]){
        if(self.numberStr1.length==0 && self.numberStr2.length==0){
            if([val isEqualToString:@"-"])
                self.numberStr1=[self.numberStr1 stringByAppendingString:[NSString stringWithFormat:@"%@0",val]];
            [self.headView updateMoneyLabel:[self moneyLabelString:self.numberStr1]];
            return;
        }
        if(self.numberStr2.length>0){
            float num1,num2;
            num1=[self.numberStr1 floatValue];
            num2=[self.numberStr2 floatValue];
            num2=self.isAdd?num2+num1:num2-num1;
            self.numberStr2=[NSString stringWithFormat:@"%.2f",num2];
            [self.headView updateMoneyLabel:[self moneyLabelString:self.numberStr2]];
            self.numberStr1=nil;
        }else{
            self.numberStr2=self.numberStr1;
            self.numberStr1=nil;
        }
        self.isAdd=[val isEqualToString:@"+"]?true:false;
    }else if ([val isEqualToString:@"清零"]){
        [self.headView clearMoneyLabel];
        self.numberStr2=nil;
        self.numberStr1=nil;
    }else if ([val isEqualToString:@"OK"]){
        //将数据写入到账本中
        if(!self.isAddAccount){
            [[DBHelper sharedDBHelper] deleteAccount:self.deleteAccountWithDate];
        }
        Account *account=[[Account alloc] initWithCategory:self.selectedCategory andDate:self.calculateView.date];
        account.money=[[self.headView.moneyLabel.text substringWithRange:NSMakeRange(2, self.headView.moneyLabel.text.length-2)] floatValue];
        account.BookID=self.bookID;
        account.remark=self.remark;
        [[DBHelper sharedDBHelper] addAccount:account];
        //[self.delegate reloadTableViewInCenterView];
        [self dismiss];
    }else{//输入的值为数字或小数点
        if(![self.numberStr1 containsString:@"."] || self.numberStr1.length-[self.numberStr1 rangeOfString:@"."].location<3){
            //第一位不能是'.'并且不能输入多个'.'
            if([val isEqualToString:@"."]){
                if(self.numberStr1.length==0)return;
                if([self.numberStr1 containsString:@"."])return;
            }
            //不能连续输入0
            if([val isEqualToString:@"0"] && [[self.numberStr1 substringFromIndex:0] isEqualToString:@"0"])return;
            if([val isEqualToString:@"0"] && [[self.numberStr1 substringFromIndex:0] isEqualToString:@"-"] && [[self.numberStr1 substringFromIndex:1] isEqualToString:@"0"])return;
            self.numberStr1=[self.numberStr1 stringByAppendingString:val];
            //若首位是0，第二位是数字，将首位去掉
            if([self.numberStr1 characterAtIndex:0]=='-' && self.numberStr1.length>2){
                if([self.numberStr1 characterAtIndex:1]=='0' && [self.numberStr1 characterAtIndex:2]!='.')self.numberStr1=[self.numberStr1 stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:[self.numberStr1 substringFromIndex:2]];
            }
            if([self.numberStr1 characterAtIndex:0]=='0' && self.numberStr1.length>1){
                if([self.numberStr1 characterAtIndex:1]!='.')self.numberStr1=[self.numberStr1 stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:[self.numberStr1 substringFromIndex:1]];
            }
            [self.headView updateMoneyLabel:[self moneyLabelString:self.numberStr1]];
        }
    }
}
#pragma mark - AddAccountHeadViewDelegate
-(void)openUpdateCategoryNameView{
    [self.view bringSubviewToFront:self.updateCategoryNameContainView];
    self.updateCategoryNameContainView.backgroundColor=[UIColor colorWithWhite:0.750 alpha:0.3];
    [self.updateCategoryNameView.inputNameTextField becomeFirstResponder];
}
#pragma mark - UpdateCategoryNameViewDelegate
-(void)updateCategoryWithNewName:(NSString *)newName{
    [[DBHelper sharedDBHelper] updateCategory:self.selectedCategory withNewTitle:newName];
    [self reloadAfterUpdateCategoryName:newName];
    [self clickedCancelBtn];
}
-(void)clickedCancelBtn{
    [self.view sendSubviewToBack:self.updateCategoryNameContainView];
    self.updateCategoryNameContainView.backgroundColor=[UIColor whiteColor];
    [self.updateCategoryNameView.inputNameTextField resignFirstResponder];
}
#pragma mark - CalendarPickViewDelegate
-(void)updateCalculateViewWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day{
    NSLog(@"更新datelabel");
    self.calculateView.yearLabel.text=[NSString stringWithFormat:@"%ld",year];
    self.calculateView.monthLabel.text=[NSString stringWithFormat:@"%ld月%ld日",month,day];
    [self.calculateView.yearLabel setTextColor:[UIColor colorWithRed:255/255.0f green:128/255.0f blue:0 alpha:1]];
    [self.calculateView.monthLabel setTextColor:[UIColor colorWithRed:255/255.0f green:128/255.0f blue:0 alpha:1]];
}
-(void)updateCalculateViewWithDate:(NSDate *)date{
    //给calculateview的date属性赋值
    self.calculateView.date=date;
}
#pragma mark - RemarkViewControllerDataSource
-(NSDate *)seletedDate{
    return self.calculateView.date;
}
#pragma mark - private method
- (void)setupNavigationBar {
    
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    
    self.incomeButton.frame = CGRectMake(0, 0, self.titleView.bounds.size.width/2, self.titleView.bounds.size.height);
    
    [self.titleView addSubview:self.incomeButton];
    
    self.spendButton.frame = CGRectMake(self.titleView.bounds.size.width/2, 0, self.titleView.bounds.size.width/2, self.titleView.bounds.size.height);
    
    [self.titleView addSubview:self.spendButton];
    self.navigationItem.titleView = self.titleView;

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImage *image = [[UIImage imageNamed:@"btn_item_close-1"] imageByResizeToSize:backBtn.frame.size];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickDisMissBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
//更新headview的类别图案和名称
-(void)reloadHeadViewWithCategory:(UsedCategory *)category{
    UIImage *preImg=self.headView.categoryImageView.image;
    self.headView.category=category;
    UIImage *currentImg=self.headView.categoryImageView.image;
    if(![preImg isEqual:currentImg]){
        self.headView.backgroundColor=[currentImg mainColor];
        self.headView.maskView.backgroundColor=[preImg mainColor];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=self.headView.maskView.frame;
            frame.origin.x+=frame.size.width;
            self.headView.maskView.frame=frame;
        } completion:^(BOOL finished){
            self.headView.maskView.backgroundColor=[UIColor clearColor];
            CGRect frame=self.headView.maskView.frame;
            frame.origin.x-=frame.size.width;
            self.headView.maskView.frame=frame;
        }];
    };
}
//将字符串转变成moneylabel格式的字符串
-(NSString *)moneyLabelString:(NSString *)numberString{
    NSString *title;
    if(![numberString containsString:@"."]){
        //不包含小数点
        title=[NSString stringWithFormat:@"¥ %@.00",numberString];
    }else{
        //包含小数点
        if(numberString.length-[numberString rangeOfString:@"."].location == 1){
            title=[NSString stringWithFormat:@"¥ %@00",numberString];
        }else if(numberString.length-[numberString rangeOfString:@"."].location == 2){
            title=[NSString stringWithFormat:@"¥ %@0",numberString];
        }else{
            title=[NSString stringWithFormat:@"¥ %@",numberString];
        }
    }
    return title;
}
-(void)reloadAfterUpdateCategoryName:(NSString *)newName{
    //self.selectedCategory.categoryTitle=newName;
    [self reloadHeadViewWithCategory:self.selectedCategory];
    if(self.selectedCategory.isIncome){
        [self.incomeCategoryCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.selectedCategoryPathOfRow inSection:0], nil]];
    }else{
        if(self.selectedCategoryPathOfRow>23){
            [self.spendCategoryCollectionView2 reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.selectedCategoryPathOfRow-24 inSection:0], nil]];
        }else{
            [self.spendCategoryCollectionView1 reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.selectedCategoryPathOfRow inSection:0], nil]];
        }
    }
}
-(void)dismiss{
    if(self.delegate && [self.delegate respondsToSelector:@selector(AddAccountViewControllerDisMiss)]){
        [self.delegate AddAccountViewControllerDisMiss];
    }
}
#pragma mark - public method
-(void)updateViewsWithSelectedCategoryType:(BOOL)isIncom categoryImageName:(NSString *)imageName moneyString:(NSString *)moneyString date:(NSDate *)date{
    //设置是收入还是支出按钮
    if(isIncom)[self.incomeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    else [self.spendButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    //修改选中的category
    self.selectedCategory=[[DBHelper sharedDBHelper] loadUsedCategoryWithImageName:imageName];
    //修改headview.image and name
    self.headView.category=self.selectedCategory;
    //修改date
    self.deleteAccountWithDate=date;
    self.calculateView.date=date;
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *components=[calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    [self updateCalculateViewWithYear:[components year] Month:[components month] Day:[components day]];
}
#pragma mark - KVO
//监听selectedCategory的值是否改变
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"selectedCategory"]){
        self.updateCategoryNameView.category=[change objectForKey:NSKeyValueChangeNewKey];
        if(self.isAnimated){
            //image移动到headview中的动画
            self.selectedCellImageView.image=[UIImage imageNamed:self.selectedCategory.categoryImageFileName];
            [self.view bringSubviewToFront:self.selectedCellImageView];
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame=self.headView.categoryImageView.frame;
                frame.origin.y+=self.headView.frame.origin.y;
                self.selectedCellImageView.frame=frame;
            } completion:^(BOOL finished){
                [self.view sendSubviewToBack:self.selectedCellImageView];
                [self reloadHeadViewWithCategory:[change objectForKey:NSKeyValueChangeNewKey]];
            }];
        }
        else{
            [self reloadHeadViewWithCategory:[change objectForKey:NSKeyValueChangeNewKey]];
        }
    }
}
#pragma mark - getters
-(AddAccountHeadView *)headView{
    if(!_headView){
        AddAccountHeadView *view=[[AddAccountHeadView alloc] initWithFrame:kCreateBillHeaderViewFrame];
        view.category=self.selectedCategory;
        //view.frame=kAddCountHeadViewFrame;
        _headView=view;
        _headView.delegate=self;
    }
    return _headView;
}
-(UIButton *)incomeButton{
    if(!_incomeButton){
        UIButton *btn=[[UIButton alloc] init];
        [btn setTitle:@"收入" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:kSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickIncomeBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        _incomeButton=btn;
    }
    return _incomeButton;
}
-(UIButton *)spendButton{
    if(!_spendButton){
        UIButton *btn=[[UIButton alloc] init];
        [btn setTitle:@"支出" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:kSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickSpendBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        btn.selected=YES;
        _spendButton=btn;
    }
    return _spendButton;
}
- (UICollectionView *)spendCategoryCollectionView1 {
    if (!_spendCategoryCollectionView1) {
        _spendCategoryCollectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 - 10) collectionViewLayout:[[CategoryCollectionViewFlowLayout alloc] init]];
        _spendCategoryCollectionView1.delegate = self;
        _spendCategoryCollectionView1.dataSource = self;
        _spendCategoryCollectionView1.backgroundColor = [UIColor whiteColor];
        [_spendCategoryCollectionView1 registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    }
    return _spendCategoryCollectionView1;
}
- (UICollectionView *)spendCategoryCollectionView2
{
    if (!_spendCategoryCollectionView2) {
        _spendCategoryCollectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 -10) collectionViewLayout:[[CategoryCollectionViewFlowLayout alloc] init]];
        _spendCategoryCollectionView2.delegate = self;
        _spendCategoryCollectionView2.dataSource = self;
        _spendCategoryCollectionView2.backgroundColor = [UIColor whiteColor];
        [_spendCategoryCollectionView2 registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    }
    return _spendCategoryCollectionView2;
}
- (UIScrollView *)spendCategoryScrollView
{
    if (!_spendCategoryScrollView) {
        _spendCategoryScrollView = [[UIScrollView alloc] initWithFrame:kCollectionFrame];
        _spendCategoryScrollView.contentSize = CGSizeMake(kCollectionFrame.size.width * 2, kCollectionFrame.size.height);
        _spendCategoryScrollView.delegate = self;
        [_spendCategoryScrollView addSubview:self.spendCategoryCollectionView1];
        [_spendCategoryScrollView addSubview:self.spendCategoryCollectionView2];
        _spendCategoryScrollView.pagingEnabled=YES;
        _spendCategoryScrollView.showsHorizontalScrollIndicator=NO;
        _spendCategoryScrollView.bounces=NO;
        _spendCategoryScrollView.scrollEnabled=YES;
    }
    return _spendCategoryScrollView;
}
- (UICollectionView *)incomeCategoryCollectionView
{
    if (!_incomeCategoryCollectionView) {
        _incomeCategoryCollectionView = [[UICollectionView alloc] initWithFrame:kCollectionFrame collectionViewLayout:[[CategoryCollectionViewFlowLayout alloc] init]];
        _incomeCategoryCollectionView.delegate = self;
        _incomeCategoryCollectionView.dataSource = self;
        _incomeCategoryCollectionView.backgroundColor = [UIColor whiteColor];
        [_incomeCategoryCollectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    }
    return _incomeCategoryCollectionView;
}
- (UIPageControl *)pageController
{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc] initWithFrame:kPageControllerFrame];
        _pageController.numberOfPages = 2;
        _pageController.userInteractionEnabled = NO;
        _pageController.pageIndicatorTintColor = [UIColor colorWithWhite:0.829 alpha:1.000];
        _pageController.currentPageIndicatorTintColor = kSelectColor;
    }
    return _pageController;
}
-(CalculateView *)calculateView{
    if(!_calculateView){
        _calculateView=[CalculateView new];
        _calculateView.calculateViewDelegate=self;
    }
    return _calculateView;
}
-(UsedCategory *)selectedCategory{
    if(!_selectedCategory){
        [self addObserver:self forKeyPath:@"selectedCategory" options:NSKeyValueObservingOptionNew context:nil];
        _selectedCategory=[[DBHelper sharedDBHelper] loadUsedCategory].firstObject;
    }
    return _selectedCategory;
}
-(NSString *)numberStr1{
    if(!_numberStr1){
        _numberStr1=[NSString new];
    }
    return _numberStr1;
}
-(NSString *)numberStr2{
    if(!_numberStr2){
        _numberStr2=[NSString new];
    }
    return _numberStr2;
}
-(UpdateCategoryNameView *)updateCategoryNameView{
    if(!_updateCategoryNameView){
        _updateCategoryNameView=[[UpdateCategoryNameView alloc] init];
        _updateCategoryNameView.delegate=self;
    }
    return _updateCategoryNameView;
}
-(UIView *)updateCategoryNameContainView{
    if(!_updateCategoryNameContainView){
        _updateCategoryNameContainView=[[UIView alloc] initWithFrame:self.view.bounds];
        _updateCategoryNameContainView.backgroundColor=[UIColor whiteColor];
    }
    return _updateCategoryNameContainView;
}
-(UIImageView *)selectedCellImageView{
    if(!_selectedCellImageView){
        _selectedCellImageView=[UIImageView new];
    }
    return _selectedCellImageView;
}
-(TransDelegate *)transDelegate{
    if(!_transDelegate){
        _transDelegate=[TransDelegate new];
    }
    return _transDelegate;
}

@end
