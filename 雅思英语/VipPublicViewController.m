//
//  VipPublicViewController.m
//  雅思英语
//
//  Created by mac on 16/1/5.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "VipPublicViewController.h"
#import "DBImageView.h"
#import "UIViewController+Json.h"
#import "VipPublicDetailViewController.h"
#import "VipOneByOneViewController.h"

@interface VipPublicViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scView;

@end

@implementation VipPublicViewController
@synthesize itype;

- (void)initScrollView
{
    
    if (itype == 0) {
        NSDictionary *dic = [self GetJson:@"http://192.168.1.231:8080/YaSi_English/upload/selectSomeCourseForOpenByHql"];
        if (dic == nil) {
            return;
        }
        
        [DBImageView clearCache];
        
        NSString *preaddr = [dic objectForKey:@"basePath"];
        
        NSArray* arrayResult =[dic objectForKey:@"list"];
        int nCount = (int)arrayResult.count;
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
        
        
        NSDictionary* resultDic;
        
        
        
        [_scView setContentSize:CGSizeMake(bd.size.width, (OffsetVer + nHeight) * nCell + OffsetVer)];
        
        
        
        for (int i = 0; i < nCount; i++) {
            resultDic = [arrayResult objectAtIndex:i];
            NSString *Url =[preaddr stringByAppendingString:[resultDic objectForKey:@"course_Address"]];
            
            DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 0, 0, nWidth, nHeight }];
            [imageView setImageWithPath:Url];
            [imageView setUserInteractionEnabled:NO];
            
            
            //       UIImage *img = [UIImage imageNamed:@"bg_1.png"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake((i % 2) * (nWidth + OffsetHor) + OffsetHor, (i / 2) * (nHeight + OffsetVer) + OffsetVer, nWidth, nHeight)];
            
            [btn addSubview:imageView];
            
            NSNumber *ntag = [resultDic objectForKey:@"id"];
            
            btn.tag = ntag.intValue;
            
            
            //       [btn setBackgroundImage:img forState:UIControlStateNormal];
            
            NSString *title = [resultDic objectForKey:@"lecturer"];
            
            //        [btn setTitle:@"吕浩民" forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(48,-85,0,0)];
            
            
            NSString *teach = [resultDic objectForKey:@"class_shape"];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.font = [UIFont systemFontOfSize:13.0];
            //        label1.text = @"在线授课";
            label1.text = teach;
            label1.textColor = [UIColor lightGrayColor];
            [label1 setFrame:CGRectMake(74, 74, 58, 21)];
            [btn addSubview:label1];
            
            
            NSString *date = [resultDic objectForKey:@"class_time"];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.font = [UIFont systemFontOfSize:13.0];
            //        label2.text = @"2015.10.20";
            label2.text = date;
            label2.textColor = [UIColor lightGrayColor];
            [label2 setFrame:CGRectMake(4, 100, 112, 21)];
            [btn addSubview:label2];
            
            /*
             UILabel *label3 = [[UILabel alloc] init];
             label3.font = [UIFont systemFontOfSize:13.0];
             label3.text = @"20:00";
             label3.textColor = [UIColor lightGrayColor];
             [label3 setFrame:CGRectMake(90, 100, 36, 21)];
             [btn addSubview:label3];
             */
            
            
            [btn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
            
            [_scView addSubview:btn];
        }
    }
    else
    {
        NSDictionary *dic = [self GetJson:@"http://192.168.1.231:8080/YaSi_English/selectSomeCourseForVIPByHql"];
        if (dic == nil) {
            return;
        }
        
        [DBImageView clearCache];
        
        NSString *preaddr = [dic objectForKey:@"basePath"];
        
        NSArray* arrayResult =[dic objectForKey:@"list"];
        int nCount = (int)arrayResult.count;
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
        
        
        NSDictionary* resultDic;
        
        
        
        [_scView setContentSize:CGSizeMake(bd.size.width, (OffsetVer + nHeight) * nCell + OffsetVer)];
        
        
        
        for (int i = 0; i < nCount; i++) {
            resultDic = [arrayResult objectAtIndex:i];
            NSString *strtmp = [resultDic objectForKey:@"course_Address"];
            NSString *Url =[preaddr stringByAppendingString:strtmp];
            
            DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 0, 0, nWidth, nHeight }];
            [imageView setImageWithPath:Url];
            [imageView setUserInteractionEnabled:NO];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake((i % 2) * (nWidth + OffsetHor) + OffsetHor, (i / 2) * (nHeight + OffsetVer) + OffsetVer, nWidth, nHeight)];
            
            [btn addSubview:imageView];
            
            NSNumber *ntag = [resultDic objectForKey:@"id"];
            
            btn.tag = ntag.intValue;
            
            
            //       [btn setBackgroundImage:img forState:UIControlStateNormal];
            
            NSString *title = [resultDic objectForKey:@"lecturer"];
            
            //        [btn setTitle:@"吕浩民" forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(48,-85,0,0)];
            
            
            NSNumber *num1 = [resultDic objectForKey:@"apply_number"];
            NSString *teach = [NSString stringWithFormat:@"已报名%d人",num1.intValue];
            
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.font = [UIFont systemFontOfSize:13.0];
            //        label1.text = @"在线授课";
            label1.text = teach;
            label1.textColor = [UIColor lightGrayColor];
            [label1 setFrame:CGRectMake(56, 74, 76, 21)];
            [btn addSubview:label1];
            
            
            NSString *date = [resultDic objectForKey:@"class_time"];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.font = [UIFont systemFontOfSize:13.0];
            //        label2.text = @"2015.10.20";
            label2.text = date;
            label2.textColor = [UIColor lightGrayColor];
            [label2 setFrame:CGRectMake(4, 100, 112, 21)];
            [btn addSubview:label2];
            
            /*
             UILabel *label3 = [[UILabel alloc] init];
             label3.font = [UIFont systemFontOfSize:13.0];
             label3.text = @"20:00";
             label3.textColor = [UIColor lightGrayColor];
             [label3 setFrame:CGRectMake(90, 100, 36, 21)];
             [btn addSubview:label3];
             */
            
            
            [btn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
            
            [_scView addSubview:btn];
        }

    }
    
    
    
}


-(void)btn_click:(UIButton*)sender
{
    switch (itype) {
        case 0://公开课详情
        {
            NSString *pstr = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/pages/selectOneCourseForOpenByHql?str=%ld",sender.tag];
            
            NSDictionary *dic = [self GetJson:pstr];
            VipPublicDetailViewController *ptmp = [self.storyboard instantiateViewControllerWithIdentifier:@"pubdetailView"];
            ptmp.dic1 = dic;
            [self.navigationController pushViewController:ptmp animated:YES];
        }
            break;
        case 1:
        {
            NSString *pstr = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneCourseForVIPByHql?commonStr=VIP&str=%ld",sender.tag];
            
            NSDictionary *dic = [self GetJson:pstr];
            VipOneByOneViewController *ptmp = [self.storyboard instantiateViewControllerWithIdentifier:@"onebyoneView"];
            ptmp.dic1 = dic;
            ptmp.id_ke = sender.tag;
            [self.navigationController pushViewController:ptmp animated:YES];
        }
            break;
        default:
            break;
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
