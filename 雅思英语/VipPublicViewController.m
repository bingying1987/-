//
//  VipPublicViewController.m
//  雅思英语
//
//  Created by mac on 16/1/5.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "VipPublicViewController.h"

@interface VipPublicViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scView;

@end

@implementation VipPublicViewController

- (void)initScrollView
{
    int nCount = 7;//多少个按钮
    int nWidth = 132;//每个按钮的长
    int nHeight = 120;//按钮的高
    int nCell = nCount / 2;
    nCell += nCount % 2;
    
    int nRight = 2;
    int nBottom = 3;
    //默认为2x3
    
    CGRect bd = _scView.bounds;
    int OffsetHor = (bd.size.width - nWidth * nRight) / (nRight + 1);//按钮距离左右两边的边距
    int OffsetVer = (bd.size.height - nHeight * nBottom) / (nBottom + 1); //按钮距离上下两边的边距
    
    
    
    
    [_scView setContentSize:CGSizeMake(bd.size.width, (OffsetVer + nHeight) * nCell + OffsetVer)];
    
    
    
    for (int i = 0; i < nCount; i++) {
        UIImage *img = [UIImage imageNamed:@"bg_1.png"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake((i % 2) * (nWidth + OffsetHor) + OffsetHor, (i / 2) * (nHeight + OffsetVer) + OffsetVer, nWidth, nHeight)];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn setTitle:@"吕浩民" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(48,-85,0,0)];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.font = [UIFont systemFontOfSize:13.0];
        label1.text = @"在线授课";
        label1.textColor = [UIColor lightGrayColor];
        [label1 setFrame:CGRectMake(74, 74, 58, 21)];
        [btn addSubview:label1];
        
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = [UIFont systemFontOfSize:13.0];
        label2.text = @"2015.10.20";
        label2.textColor = [UIColor lightGrayColor];
        [label2 setFrame:CGRectMake(4, 100, 70, 21)];
        [btn addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.font = [UIFont systemFontOfSize:13.0];
        label3.text = @"20:00";
        label3.textColor = [UIColor lightGrayColor];
        [label3 setFrame:CGRectMake(90, 100, 36, 21)];
        [btn addSubview:label3];
        
        [_scView addSubview:btn];
        
        
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initScrollView];
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
