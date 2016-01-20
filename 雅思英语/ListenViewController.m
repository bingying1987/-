//
//  ListenViewController.m
//  雅思英语
//
//  Created by mac on 16/1/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ListenViewController.h"

@interface ListenViewController ()
{
    UIButton *lastBtn;
    UIImageView *lastImgView;
    NSArray *imgViewArry;
}
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;
@end

@implementation ListenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastBtn = _btn1;
    imgViewArry = @[_img1,_img2,_img3,_img4,_img5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnclick:(UIButton *)sender {
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
