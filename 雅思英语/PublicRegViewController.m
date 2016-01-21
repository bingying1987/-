//
//  PublicRegViewController.m
//  雅思英语
//
//  Created by mac on 16/1/5.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "PublicRegViewController.h"

@interface PublicRegViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *NicName;
@property (weak, nonatomic) IBOutlet UITextField *textPhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *textOnlineTeach;

@end

@implementation PublicRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //这个frame是初设的，没关系，后面还会重新设置其size。
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.text = @"姓名";
    label.textColor = [UIColor lightGrayColor];
    [label setFrame:CGRectMake(10, 0, 60, 21)];
    
    CGRect rc = label.bounds;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc.size.width + 10, rc.size.height)];
    [label setFrame:CGRectMake(10, 0, rc.size.width, rc.size.height)];
    [view addSubview:label];
    _textName.leftView = view;
    _textName.leftViewMode = UITextFieldViewModeAlways;
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:14.0f];
    label1.text = @"会员名";
    label1.textColor = [UIColor lightGrayColor];
    [label1 setFrame:CGRectMake(10, 0, 60, 21)];
    
    CGRect rc1 = label1.bounds;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc1.size.width + 10, rc1.size.height)];
    [label1 setFrame:CGRectMake(10, 0, rc1.size.width, rc1.size.height)];
    [view1 addSubview:label1];
    _NicName.leftView = view1;
    _NicName.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:14.0f];
    label2.text = @"手机号";
    label2.textColor = [UIColor lightGrayColor];
    [label2 setFrame:CGRectMake(10, 0, 60, 21)];
    
    CGRect rc2 = label2.bounds;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc2.size.width + 10, rc2.size.height)];
    [label2 setFrame:CGRectMake(10, 0, rc2.size.width, rc2.size.height)];
    [view2 addSubview:label2];
    _textPhoneNum.leftView = view2;
    _textPhoneNum.leftViewMode = UITextFieldViewModeAlways;

    
    UILabel *label3 = [[UILabel alloc] init];
    label3.font = [UIFont systemFontOfSize:14.0f];
    label3.text = @"授课形式";
    label3.textColor = [UIColor lightGrayColor];
    [label3 setFrame:CGRectMake(10, 0, 60, 21)];
    
    CGRect rc3 = label3.bounds;
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc3.size.width + 10, rc3.size.height)];
    [label3 setFrame:CGRectMake(10, 0, rc3.size.width, rc3.size.height)];
    [view3 addSubview:label3];
    _textOnlineTeach.leftView = view3;
    _textOnlineTeach.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
