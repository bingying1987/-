//
//  ResetPasswordViewController.m
//  雅思英语
//
//  Created by mac on 16/1/4.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "UIViewController+Json.h"
#import "SMS_SDK/SMSSDK.h"

@interface ResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt_PhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *txt_code;
@property (weak, nonatomic) IBOutlet UITextField *txt_PW_1;
@property (weak, nonatomic) IBOutlet UITextField *txt_PW_2;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissKeyBoard:(UITextField *)sender {
    [sender resignFirstResponder];
}


- (IBAction)btn_Reg:(id)sender {
    if ([_txt_PhoneNum.text  isEqualToString: @""]) {
        return;
    }
    
    if ([_txt_PhoneNum.text length] != 11) {
        return;
    }
    
    if ([_txt_code.text isEqualToString:@""]) {
        return;
    }
    
    if (![_txt_PW_1.text isEqualToString:_txt_PW_2.text]) {
        return;
    }
    
    
    
    
    
    [SMSSDK commitVerificationCode:_txt_code.text phoneNumber:_txt_PhoneNum.text zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"验证成功");
            //跳转到主页
            NSString *path = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/updatePasswordByhql?userInfo.phone_Number=%@&userInfo.passWord=%@",_txt_PhoneNum.text,_txt_PW_1.text];
            NSDictionary *dic = [self GetJson:path];
            if (dic == nil) {
                return;
            }
            NSNumber* lat = [dic objectForKey:@"Result"];
            if (lat.intValue == 1) {
                [self.navigationController popViewControllerAnimated:YES];
             //   return; //注册成功,跳转到主页
            }
            else
            {
                NSString *str1 = [dic objectForKey:@"Message"];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:str1
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            NSLog(@"错误信息:%@",error);
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"验证码验证失败"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    
}

- (IBAction)btn_code:(id)sender {
    if ([_txt_PhoneNum.text  isEqual: @""]) {
        return;
    }
    
    if ([_txt_PhoneNum.text length] != 11) {
        return;
    }
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_txt_PhoneNum.text zone:@"86" customIdentifier:nil result:^(NSError *error){
        if (!error)
        {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
    
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
