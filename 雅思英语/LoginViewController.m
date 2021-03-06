//
//  LoginViewController.m
//  雅思英语
//
//  Created by mac on 16/1/4.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+Json.h"
#import "YSFirstViewController.h"
#import "AppDelegate.h"
#import "DBImageView.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txt_PhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *txt_Password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [DBImageView clearCache];
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


- (IBAction)btn_Login:(id)sender {
    YSFirstViewController *ptmp = [[YSFirstViewController alloc] init];
    [self.navigationController pushViewController:ptmp animated:YES];
//    UIViewController *ptmp = [self.storyboard instantiateViewControllerWithIdentifier:@"speakpartView"];
//    [self.navigationController pushViewController:ptmp animated:YES];
    return;//调试使用
    
    
    
    NSString *Num = _txt_PhoneNum.text;
    if ([Num isEqualToString:@""] || Num.length != 11) {
        return;
    }
    NSString *Pw = _txt_Password.text;
    if ([Pw isEqualToString:@""]) {
        return;
    }
    
    if (Pw.length < 8 || Pw.length > 12) {
        return;
    }
    
    
    NSString *path = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneUserInfoByLoginJudge?userInfo.phone_Number=%@&userInfo.passWord=%@",Num,Pw];
    
    
    NSDictionary *dic = [self GetJson:path];
    
    if (dic == nil) {
        return;
    }
    NSNumber* lat = [dic objectForKey:@"Result"];
    if (lat.intValue == 1) {
         //登录成功,跳转到主页
        AppDelegate *pdelegate = [[UIApplication sharedApplication] delegate];
        pdelegate.ph_num = Num;
        pdelegate.ph_pw = Pw;
        YSFirstViewController *ptmp = [[YSFirstViewController alloc] init];
        [self.navigationController pushViewController:ptmp animated:YES];
    }
    {
        NSString *str1 = [dic objectForKey:@"Message"];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:str1
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
    
    /*
    //一下为自定义解析， 自己想怎么干就怎么干
    
    NSArray* arrayResult =[dic objectForKey:@"results"];
    NSDictionary* resultDic = [arrayResult objectAtIndex:0];
    NSDictionary* geometryDic = [resultDic objectForKey:@"geometry"];
    NSLog(@"geometryDic: %@,  resultDic:%@",geometryDic,resultDic);
    NSDictionary* locationDic = [geometryDic objectForKey:@"location"];
    NSNumber* lat = [locationDic objectForKey:@"lat"];
    NSNumber* lng = [locationDic objectForKey:@"lng"];
    NSLog(@"lat = %@, lng = %@",lat,lng);
    [jsonString release];
     */
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
