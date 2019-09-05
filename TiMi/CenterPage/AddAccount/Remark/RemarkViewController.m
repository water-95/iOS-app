//
//  RemarkViewController.m
//  TiMi
//
//  Created by 江滨耀 on 2019/8/28.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import "RemarkViewController.h"
#import "UIImage+Resize.h"
#import "Const.h"
#import <Masonry/Masonry.h>
@interface RemarkViewController ()<UITextViewDelegate>
@end

@implementation RemarkViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self configurate];
    [self.remarkTextView becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"text changed");
    if(textView.text.length==0)self.placeholderLabel.hidden=NO;
    else self.placeholderLabel.hidden=YES;
    
    self.wordCountLabel.text=[NSString stringWithFormat:@"%ld/100",textView.text.length];
}
#pragma mark - UIKeyboardWillShowNotification
-(void)keyboardFrameWillChange:(NSNotification *)notification{
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyboard height %f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    CGRect frame1=self.wordCountLabel.frame;
    CGRect frame2=self.saveButton.frame;
    frame1.origin.y=frame.origin.y-frame1.size.height-10;
    frame2.origin.y=frame.origin.y-frame2.size.height-10;
    self.wordCountLabel.frame=frame1;
    self.saveButton.frame=frame2;
}

#pragma mark - private method
- (void)configurate {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImage *image = [[UIImage imageNamed:@"btn_item_close-1"] imageByResizeToSize:backBtn.frame.size];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickDisMissBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.title=@"备注";
    
    NSDateFormatter *formate=[[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy年mm月dd日"];
    NSString *dateStr=[formate stringFromDate:[self.datasource seletedDate]];
    _selectedDateLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height+5, self.view.bounds.size.width, 20)];
    _selectedDateLabel.textColor=LineColor;
    _selectedDateLabel.font=[UIFont systemFontOfSize:15];
    _selectedDateLabel.text=dateStr;
    [self.view addSubview:_selectedDateLabel];
    
    _remarkTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height+30, SCREEN_WIDTH, SCREEN_HEIGHT-(self.navigationController.navigationBar.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height+10))];
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 30)];
    _placeholderLabel.text=@"记录花销更记录生活...";
    _placeholderLabel.textColor=[UIColor colorWithWhite:0.8 alpha:1];
    _placeholderLabel.font=[UIFont systemFontOfSize:23];
    [_remarkTextView addSubview:_placeholderLabel];
    _remarkTextView.font=[UIFont systemFontOfSize:23];
    _remarkTextView.delegate=self;
    _remarkTextView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_remarkTextView];
    
    _wordCountLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height-20-30, 80, 30)];
    _wordCountLabel.font=[UIFont systemFontOfSize:18];
    _wordCountLabel.textColor=LineColor;
    _wordCountLabel.textAlignment=NSTextAlignmentCenter;
    _wordCountLabel.text=@"0/100";
    [self.view addSubview:_wordCountLabel];
    
    _saveButton=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-20-60, self.view.frame.size.height-20-30, 60, 30)];
    [_saveButton setTitle:@"完成" forState:UIControlStateNormal];
    [_saveButton setTitleColor:kSelectColor forState:UIControlStateNormal];
    [_saveButton.layer setBorderWidth:kBorderWidth];
    [_saveButton.layer setBorderColor:[UIColor colorWithWhite:0.1 alpha:1].CGColor];
    [_saveButton addTarget:self action:@selector(clickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.layer.cornerRadius=4;
    [self.view addSubview:_saveButton];
    
}
#pragma mark - button actions
-(void)clickDisMissBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickSaveBtn:(UIButton *)sender{
    
}

@end
