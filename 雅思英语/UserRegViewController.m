//
//  UserRegViewController.m
//  雅思英语
//
//  Created by mac on 16/1/4.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "UserRegViewController.h"

@interface UserRegViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt_userName;
@property (weak, nonatomic) IBOutlet UITextField *txt_phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *txt_code;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;

@end

@implementation UserRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.title;
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username.png"]];
    CGRect rc = imgView.bounds;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc.size.width + 10, rc.size.height)];
    [imgView setFrame:CGRectMake(rc.origin.x + 10, 0, rc.size.width, rc.size.height)];
    [view addSubview:imgView];
    _txt_userName.leftView = view;
    _txt_userName.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_num.png"]];
    CGRect rc1 = imgView1.bounds;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc1.size.width + 10, rc1.size.height)];
    [imgView1 setFrame:CGRectMake(rc1.origin.x + 10, 0, rc1.size.width, rc1.size.height)];
    [view1 addSubview:imgView1];
    _txt_phoneNum.leftView = view1;
    _txt_phoneNum.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"code.png"]];
    CGRect rc2 = imgView2.bounds;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc2.size.width + 10, rc2.size.height)];
    [imgView2 setFrame:CGRectMake(rc2.origin.x + 10, 0, rc2.size.width, rc2.size.height)];
    [view2 addSubview:imgView2];
    _txt_code.leftView = view2;
    _txt_code.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password.png"]];
    CGRect rc3 = imgView3.bounds;
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc3.size.width + 10, rc3.size.height)];
    [imgView3 setFrame:CGRectMake(rc3.origin.x + 10, 0, rc3.size.width, rc3.size.height)];
    [view3 addSubview:imgView3];
    _txt_password.leftView = view3;
    _txt_password.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissKeyBoard:(UITextField *)sender {
    [sender resignFirstResponder];
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
