//
//  VipViewController.m
//  雅思英语
//
//  Created by mac on 16/1/5.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "VipViewController.h"
#import "VipPublicViewController.h"


@interface VipViewController ()
{
    UIButton *lastBtn;
    UIImageView *lastImgView;
    NSArray *imgViewArry;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end

@implementation VipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastBtn = _btn1;
    lastImgView = _imgView1;
    imgViewArry = @[_imgView1,_imgView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_click:(UIButton *)sender {
    VipPublicViewController* ptmp = nil;
    ptmp = [self.storyboard instantiateViewControllerWithIdentifier:@"vippublicView"];
    ptmp.itype = sender.tag;
    
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
    [self.navigationController pushViewController:ptmp animated:YES];
    
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
