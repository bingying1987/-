//
//  LoginViewController.m
//  雅思英语
//
//  Created by mac on 16/1/4.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txt_PhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *txt_Password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.title;
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_num.png"]];
    CGRect rc = imgView.bounds;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc.size.width + 10, rc.size.height)];
    [imgView setFrame:CGRectMake(rc.origin.x + 10, 0, rc.size.width, rc.size.height)];
    [view addSubview:imgView];
    _txt_PhoneNum.leftView = view;
    _txt_PhoneNum.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password.png"]];
    CGRect rc1 = imgView.bounds;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc1.size.width + 10, rc1.size.height)];
    [imgView1 setFrame:CGRectMake(rc1.origin.x + 10, 0, rc1.size.width, rc1.size.height)];
    [view1 addSubview:imgView1];
    _txt_Password.leftView = view1;
    _txt_Password.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_UserReg:(id)sender {
    UIViewController *ptmp = [self.storyboard instantiateViewControllerWithIdentifier:@"userregView"];
    [self.navigationController pushViewController:ptmp animated:YES];
}

- (IBAction)ResetPassWord:(id)sender {
    UIViewController *ptmp = [self.storyboard instantiateViewControllerWithIdentifier:@"resetPWView"];
    [self.navigationController pushViewController:ptmp animated:YES];
}


- (IBAction)dismissKeyBoard:(UITextField *)sender {
    [self resignFirstResponder];
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
