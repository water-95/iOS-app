//
//  CenterViewController.m
//  TiMi
//
//  Created by 江滨耀 on 2019/7/21.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterHeadView.h"
#import "Const.h"
#import "IncomeAccountCell.h"
#import "SpendAccountCell.h"
#import "AddAccountViewController.h"
#import "TransDelegate.h"
#import <Realm/Realm.h>
#import "DBHelper.h"
#import "Account.h"
#import "SpendAccountCell.h"
#import "IncomeAccountCell.h"
#import <Masonry/Masonry.h>
#import "Book.h"
#import "ManageViewController.h"

@interface AddAccountViewControllerConfiguration:NSObject
@property(nonatomic,assign)BOOL isNeed;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,assign)BOOL isIncome;
@property(nonatomic,strong)NSDate *date;
@end
@implementation AddAccountViewControllerConfiguration
@end

static NSString *const IncomeAccountCellID = @"IncomeAccountCellID";
static NSString *const SpendAccountCellID = @"SpendAccountCellID";
static NSInteger deleteCellTag = 100;
static NSInteger editCellTag = 101;
@interface CenterViewController ()<CenterHeadViewDelegate,AddAccountViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CenterHeadView *headView;
@property(nonatomic,copy)NSArray *accountsArray;
@property(nonatomic,copy)NSString *bookTitle;
@property(nonatomic,strong)UIColor *bookColor;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CATransition *pushAnimation;
@end

@implementation CenterViewController

#pragma mark - life cycle
-(void)loadView{
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountChange) name:@"account addordelete" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
    [self initBookID];
    [self loadAccounts];
    [self updateMoneyLabelOnHeadView];
    self.view.backgroundColor=[UIColor whiteColor];
    //self.transDelegate=[TransDelegate new];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    //其实在viewWillAppear这里改变UI元素不是很可靠，Autolayout发生在viewWillAppear之后，严格来说这里通常不做视图位置的修改，而用来更新Form数据。改变位置可以放在viewWilllayoutSubview或者didLayoutSubview里，而且在viewDidLayoutSubview确定UI位置关系之后设置autoLayout比较稳妥。另外，viewWillAppear在每次页面即将显示都会调用，viewWillLayoutSubviews虽然在lifeCycle里调用顺序在viewWillAppear之后，但是只有在页面元素需要调整时才会调用，避免了Constraints的重复添加。
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    NSLog(@"view will appear");
    [self initBookID];
    [self loadAccounts];
    NSLog(@"accounts:%ld",self.accountsArray.count);
    [self updateMoneyLabelOnHeadView];
    [self.tableView reloadData];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    //CGFloat top = iPhoneX ? -44 : SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11")?-20:0;
//    CGFloat top=0;
//    self.headView.frame=CGRectMake(0, top, SCREEN_SIZE.width, kHeaderViewHeight);
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width, kHeaderViewHeight));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountCell *cell=(AccountCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSArray *deleteAndEditViews=[self deleteAndEditViews:cell];
    if(deleteAndEditViews.count==0){
        [cell hideCategoryNameAndMoney];
        cell.ishideCategoryNameAndMoney=YES;
    }else{
        [cell showCategoryNameAndMoney];
        cell.ishideCategoryNameAndMoney=NO;
    }
    //animation
    if(cell.ishideCategoryNameAndMoney){
        UIButton *cellDeleteView=[[UIButton alloc] initWithFrame:cell.categoryIconView.frame];
        [cellDeleteView setImage:[UIImage imageNamed:@"menu_operation_delete"] forState:UIControlStateNormal];
        [cellDeleteView addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        cellDeleteView.tag=deleteCellTag;
        [cell addSubview:cellDeleteView];
        NSInteger offsetX=100;
        CGPoint currPosition=cellDeleteView.layer.position;
        cellDeleteView.layer.position=CGPointMake(currPosition.x-offsetX, currPosition.y);
        CABasicAnimation *moveleftAnimation=[CABasicAnimation new];
        moveleftAnimation.keyPath=@"position";
        moveleftAnimation.fromValue=[NSValue valueWithCGPoint:currPosition];
        moveleftAnimation.duration=0.5;
        [cellDeleteView.layer addAnimation:moveleftAnimation forKey:nil];
        
        UIButton *cellEditView=[[UIButton alloc] initWithFrame:cell.categoryIconView.frame];
        [cellEditView addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cellEditView setImage:[UIImage imageNamed:@"menu_operation_edit"] forState:UIControlStateNormal];
        cellEditView.tag=editCellTag;
        [cell addSubview:cellEditView];
        cellEditView.layer.position=CGPointMake(currPosition.x+offsetX, currPosition.y);
        CABasicAnimation *moverightAnimation=[CABasicAnimation new];
        moverightAnimation.keyPath=@"position";
        moverightAnimation.fromValue=[NSValue valueWithCGPoint:currPosition];
        moverightAnimation.duration=0.5;
        [cellEditView.layer addAnimation:moverightAnimation forKey:nil];
    }else{
        for(UIView *view in deleteAndEditViews)[view removeFromSuperview];
    }

}
-(NSArray *)deleteAndEditViews:(AccountCell *)cell{
    NSMutableArray *deleteAndEditViewArray=[NSMutableArray array];
    for(UIView *view in cell.subviews){
        if(view.tag==editCellTag || view.tag==deleteCellTag)[deleteAndEditViewArray addObject:view];
    }
    return deleteAndEditViewArray;
}
-(void)cellButtonClicked:(UIButton *)sender{
    AccountCell *cell=(AccountCell *)[sender superview];
    NSArray *deleteAndEditViews=[self deleteAndEditViews:cell];
    for(UIView *view in deleteAndEditViews)[view removeFromSuperview];
    
    if (sender.tag==deleteCellTag) {
        [[DBHelper sharedDBHelper] deleteAccount:cell.date];
    }else if (sender.tag==editCellTag){
        AddAccountViewControllerConfiguration *configuration=[AddAccountViewControllerConfiguration new];
        configuration.isNeed=YES;
        configuration.isIncome=[cell isMemberOfClass:IncomeAccountCell.class];
        configuration.imageName=cell.categoryImageName;
        configuration.date=cell.date;
        [self translateToAddAccountViewControllerWithConfiguration:configuration];
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accountsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Account *account=[self.accountsArray objectAtIndex:[indexPath row]];
    AccountCell *cell;
    if(account.category.isIncome){
        cell=[tableView dequeueReusableCellWithIdentifier:@"incomeAccountCell"];
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"spendAccountCell"];
    }
    cell.categoryImageName=account.category.categoryImageFileName;
    cell.date=account.date;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.categoryIconView.image=[UIImage imageNamed:account.category.categoryImageFileName];
    cell.categoryNameLabel.text=account.category.categoryTitle;
    cell.moneyLabel.text=[NSString stringWithFormat:@"%.2f",account.money];
    cell.remarkLabel.text=account.remark;
    //是否是每日的最后一笔账单
    NSDateFormatter *formater=[NSDateFormatter new];
    [formater setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr=[formater stringFromDate:account.date];
    Account *acc2=indexPath.row>0?self.accountsArray[indexPath.row-1]:nil;
    if(![dateStr isEqualToString:[formater stringFromDate:acc2.date]]){
        cell.dateLabel.text=dateStr;
        float sum=0;
        for(NSInteger i=indexPath.row;i<self.accountsArray.count;i++){
            Account *temp=self.accountsArray[i];
            if(![dateStr isEqualToString:[formater stringFromDate:temp.date]])break;
            if(temp.category.isIncome)continue;
            sum+=temp.money;
        }
        cell.daylyMoneyLabel.text=[NSString stringWithFormat:@"%.2f",sum];
    }else{cell.pointView.backgroundColor=[UIColor clearColor];}
    cell.isLastAccount=indexPath.row<self.accountsArray.count-1?NO:YES;
    return cell;
}

#pragma mark - CenterHeadViewDelegate
-(NSString *)textForTitleBtn
{
    return self.bookTitle;
}
-(void)clickedCreateBtn{
    AddAccountViewControllerConfiguration *configuration=[AddAccountViewControllerConfiguration new];
    configuration.isNeed=NO;
    [self translateToAddAccountViewControllerWithConfiguration:configuration];
}
-(void)clickedMenuBtn{
    [self transitionToLeftViewController];
}
#pragma mark - AddAccountViewControllerDelegate
//
-(void)reloadTableViewInCenterView{
    NSLog(@"reload data");
    [self loadAccounts];
    [self updateMoneyLabelOnHeadView];
    [self.tableView reloadData];
}
-(void)AddAccountViewControllerDisMiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Notification
-(void)accountChange{
    [self loadAccounts];
    [self.tableView reloadData];
    [self updateMoneyLabelOnHeadView];
}


#pragma mark - private methods
-(void)initBookID{
    NSArray *books=[[DBHelper sharedDBHelper] loadBooks];
    if(books.count==0){
        Book *book=[Book new];
        book.bookNameString=@"日常账本";
        book.coverImageNameString=@"book_cover_0";
        book.isSelected=YES;
        [[DBHelper sharedDBHelper] addNewBook:book];
        self.bookTitle=@"日常账本";
    }
    else for(Book *temp in books)if(temp.isSelected)self.bookTitle=temp.bookNameString;
    [self.headView.bookTitleBtn setTitle:self.bookTitle forState:UIControlStateNormal];
}
-(void)loadAccounts{
    self.accountsArray=[[DBHelper sharedDBHelper] loadAccountWithBookID:self.bookTitle];
}
-(void)updateMoneyLabelOnHeadView{
    float incomeSum=0;
    float spendSum=0;
    NSDate *currentDate=[NSDate date];
    NSDateFormatter *formater=[NSDateFormatter new];
    [formater setDateFormat:@"yyyy-MM"];
    NSString *str1=[formater stringFromDate:currentDate];
    for(NSInteger i=0;i<self.accountsArray.count;i++){
        Account *temp=self.accountsArray[i];
        if(![str1 isEqualToString:[formater stringFromDate:temp.date]])break;
        if(temp.category.isIncome)incomeSum+=temp.money;
        else spendSum+=temp.money;
    }
    self.headView.incomeMoneyLabel.text=[NSString stringWithFormat:@"%.2f",incomeSum];
    self.headView.spendMoneyLabel.text=[NSString stringWithFormat:@"%.2f",spendSum];
    
}
-(void)translateToAddAccountViewControllerWithConfiguration:(AddAccountViewControllerConfiguration *)configuration{
    AddAccountViewController *addAccountVC=[AddAccountViewController new];
    addAccountVC.bookID=self.bookTitle;
    addAccountVC.delegate=self;
    UINavigationController *NVC=[[UINavigationController alloc] initWithRootViewController:addAccountVC];
    NVC.transitioningDelegate=addAccountVC.transDelegate;
    self.transitioningDelegate=addAccountVC.transDelegate;
    [self presentViewController:NVC animated:YES completion:nil];
    if(configuration.isNeed){
        addAccountVC.isAddAccount=NO;
        [addAccountVC updateViewsWithSelectedCategoryType:configuration.isIncome categoryImageName:configuration.imageName moneyString:nil date:configuration.date];
    }else addAccountVC.isAddAccount=YES;
}
-(void)transitionToLeftViewController{
    id tempVC=self;
    while ([tempVC parentViewController]) {
        tempVC=[tempVC parentViewController];
        if([[tempVC class] isEqual:[ManageViewController class]]){
            [tempVC transitionToViewControllerAtIndex:0];
            break;
        }
    }
}

#pragma mark - getters
-(CenterHeadView *)headView{
    if(!_headView){
        _headView=[[CenterHeadView alloc] init];
        _headView.headViewDelegate=self;
        [_headView reloadTitle];
    }
    return _headView;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView=[UITableView new];
        _tableView.backgroundColor=[UIColor whiteColor];
        [_tableView registerClass:[SpendAccountCell class] forCellReuseIdentifier:@"spendAccountCell"];
        [_tableView registerClass:[IncomeAccountCell class] forCellReuseIdentifier:@"incomeAccountCell"];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight=64;
    }
    return _tableView;
}




@end
