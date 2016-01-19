//
//  SpeekMainViewController.m
//  雅思英语
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SpeekMainViewController.h"
#import "UIViewController+Json.h"
#import "SubjectViewController.h"

@interface SpeekMainViewController ()
{
    UIButton *lastBtn;
    UIImageView *lastImgView;
    NSArray *imgViewArry;
}
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@end

@implementation SpeekMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastBtn = _btn1;
    lastImgView = _img1;
    imgViewArry = @[_img1,_img2,_img3,_img4];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_click:(UIButton *)sender {
    if (sender.tag != lastBtn.tag)
    {
        [lastBtn setBackgroundImage:[UIImage imageNamed:@"vip_btn_up.png"] forState:UIControlStateNormal];
        NSString *file = [NSString stringWithFormat:@"vip_list%ld.png",lastBtn.tag + 1];
        lastImgView.image = [UIImage imageNamed:file];
        [sender setBackgroundImage:[UIImage imageNamed:@"vip_btn_down.png"] forState:UIControlStateNormal];
        UIImageView *pview = [imgViewArry objectAtIndex:sender.tag];
        pview.image = [UIImage imageNamed:@"vip_public.png"];
        lastBtn = sender;
        lastImgView = pview;
    }
    
    NSInteger id1 = sender.tag + 1;
    NSString *ptmp = nil;
    if (id1 > 3) {
        return;
    }
    else
    {
        ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectAllTalkTopicClassification_ForApp?commonStr=part%ld&commonInt1=0&commonInt2=20",id1];
    }
    
    
    
    NSDictionary *dic = [self GetJson:ptmp];
    if (dic) {
        SubjectViewController *ptmp1 = [self.storyboard instantiateViewControllerWithIdentifier:@"subjectView"];
        [ptmp1 setDic:dic];
        ptmp1.itype = sender.tag;
        [self.navigationController pushViewController:ptmp1 animated:YES];
    }
    
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
