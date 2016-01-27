//
//  LiangDianViewController.m
//  雅思英语
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "LiangDianViewController.h"
#import "UIViewController+Json.h"
#import "AppDelegate.h"
@interface LiangDianViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *tableView;
@property (retain,nonatomic) UIImageView *otherimgContent;
@property (weak, nonatomic) IBOutlet UIScrollView *otherscroll;
@end

@implementation LiangDianViewController
@synthesize dic;
@synthesize subID;

- (void)LoadLianJu:(NSDictionary *)pdic//联句
{
    if (!pdic) {
        return;
    }
    
    NSString *bashURL = [pdic objectForKey:@"basePath"];
    
    pdic = [pdic objectForKey:@"Data"];
    NSString *pstrImgContent = [pdic objectForKey:@"expression"];
    pstrImgContent = [bashURL stringByAppendingString:pstrImgContent];
    
    NSURL *url = [NSURL URLWithString:pstrImgContent];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if (!data) {
        return;
    }
    UIImage *img = [UIImage imageWithData:data];
    
    CGSize size = img.size;
    if (size.width == 0) {
        return;
    }
    
    UIView *pview = [_otherscroll viewWithTag:-1];
    if (pview) {
        [pview removeFromSuperview];
    }
    
    if (!_otherimgContent) {
        _otherimgContent = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width / 2, size.height / 2)];
    }
    else
    {
        [_otherimgContent setFrame:CGRectMake(0, 0, size.width / 2, size.height / 2)];
    }
    _otherimgContent.tag = -1;
    _otherimgContent.image = img;
    [_otherscroll setContentSize:CGSizeMake(size.width / 2, size.height / 2)];
    [_otherscroll addSubview:_otherimgContent];
    [_otherscroll setContentOffset:CGPointMake(0, 0)];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self LoadLianJu:dic];
}

- (BOOL)CheckAnswerZuDuan:(NSInteger)selectid
{
    if (dic) {
        NSDictionary *pdic = [dic objectForKey:@"Data"];
        NSString *strRight = [pdic objectForKey:@"answer"];
        NSString *strcurrent = nil;
        switch (selectid) {
            case 0:
                strcurrent = @"A";
                break;
            case 1:
                strcurrent = @"B";
                break;
            case 2:
                strcurrent = @"C";
                break;
            case 3:
                strcurrent = @"D";
            default:
                strcurrent = @"1";
                break;
        }
        NSNumber *titleNum = [pdic objectForKey:@"titleNumber"];
        if (![strRight isEqualToString:strcurrent]) {//回答错误,给出提示框
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"回答错误"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            //传递错题接口
            AppDelegate *papp = [[UIApplication sharedApplication] delegate];
            NSString *strNum = papp.ph_num;
            NSString *pstr = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English//saveOneWrongTopic?wrongTopic.moduleName=说&wrongTopic.subModuleName=组段&wrongTopic.titleNumber=%ld&str=%@",titleNum.integerValue,strNum];
            [self GetJson:pstr];
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    return FALSE;
    
}


- (IBAction)selectAnswer:(UIButton *)sender {
    [self CheckAnswerZuDuan:sender.tag];
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneHighlightExpressionByRandom?str=%ld",subID];
    dic = [self GetJson:url];
    if (dic) {
        url = [dic objectForKey:@"Result"];
        if ([url isEqualToString:@"0"]) {
            dic = nil;
            return;
        }
    }
    
    [self LoadLianJu:dic];
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
