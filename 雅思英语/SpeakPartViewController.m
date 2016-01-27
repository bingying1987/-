//
//  SpeakPartViewController.m
//  雅思英语
//
//  Created by mac on 16/1/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SpeakPartViewController.h"
#import "UIViewController+Json.h"
#import "DBImageView.h"
#import "NetMediaViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyRecorder.h"
#import "ASIFormDataRequest.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "MyMovieViewController.h"
#import "ASIFormDataRequest.h"
@interface SpeakPartViewController ()
{
    NSInteger _current6;
    BOOL bspeak6;
    NSInteger _current7;
    BOOL bspeak7;
    NSTimer *tSpeak;
    int tick;
    MyRecorder *recoder;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgmenu;
@property (weak, nonatomic) IBOutlet UITextView *textcontent6;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmain;



@property (nonatomic) NSDictionary *dic6_2;
@property (nonatomic) NSDictionary *dic6_3;
@property (nonatomic) NSDictionary *dic6_4;
@property (nonatomic) NSDictionary *dic6_5;
@property (nonatomic) NSInteger id6;


@property (nonatomic) NSDictionary *dic7_1;
@property (nonatomic) NSDictionary *dic7_2;
@property (nonatomic) NSDictionary *dic7_3;
@property (nonatomic) NSDictionary *dic7_4;
@property (nonatomic) NSDictionary *dic7_5;
@property (nonatomic) NSInteger id7;

@property (weak, nonatomic) IBOutlet UIButton *btnAnser;
@property (weak, nonatomic) IBOutlet UIButton *btnspeak;
@property (weak, nonatomic) IBOutlet UIButton *btnxiugai;
@property (weak, nonatomic) IBOutlet UIButton *btnpushguangchang;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@property (weak, nonatomic) IBOutlet UIView *viewother;
@property (weak, nonatomic) IBOutlet UIView *viewjiangjie;
@property (weak, nonatomic) IBOutlet DBImageView *jiangjieBanner;
@property (weak, nonatomic) IBOutlet UIScrollView *jiangjieContent;
@property (retain, nonatomic) IBOutlet UIImageView *jiangjieimg;

@property (retain,nonatomic) IBOutlet UIImageView *otherimgContent;
@property (weak, nonatomic) IBOutlet UIScrollView *otherscroll;
@property (weak, nonatomic) IBOutlet UITextView *textOther;

@property (weak, nonatomic) IBOutlet UIButton *aw_A;
@property (weak, nonatomic) IBOutlet UIButton *aw_B;
@property (weak, nonatomic) IBOutlet UIButton *aw_C;
@property (weak, nonatomic) IBOutlet UIButton *aw_D;




@end

@implementation SpeakPartViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _id6 = -1;
    _id7 = -1;
    _current6 = 0;
    _current7 = 0;
    tick = 0;
 //   recoder = [[MyRecorder alloc] init];
    recoder = [MyRecorder recorder];
    [_textOther.layer setBorderWidth:3.0f];
    _textOther.layer.borderColor = [UIColor grayColor].CGColor;
    _textOther.layer.cornerRadius = 5.0f;
    [self hidenall];
}

- (IBAction)playmovie:(id)sender {
    if (_segmain.selectedSegmentIndex == 0) {//6分
        if (!_dic6_2) {
            return;
        }
        NSString *pmovUrl = [_dic6_2 objectForKey:@"video_Address"];
        NSString *ptmp = [pmovUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NetMediaViewController *pview = [self.storyboard instantiateViewControllerWithIdentifier:@"movieView"];
        pview.moviePath = ptmp;
        [self presentViewController:pview animated:YES completion:nil];
    }
    else //7分
    {
        
    }
}



- (void)loadContent6:(NSDictionary *)pdic
{
    if (!pdic) {
        return;
    }
    
    NSString *pContent = [pdic objectForKey:@"content"];
    pContent = [pContent stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
    _textcontent6.text = pContent;
}

- (void)LoadTitle:(NSDictionary *)pdic
{
    if (!pdic) {
        return;
    }
    NSString *pTitle = [pdic objectForKey:@"questions_stems"];
    pTitle = [pTitle stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
    pTitle = [pTitle stringByAppendingString:@"\r\r"];
    
    NSString *pTitleDec = [pdic objectForKey:@"questions_stems_explain"];
    pTitleDec = [pTitleDec stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
    
    pTitle = [pTitle stringByAppendingString:pTitleDec];
    _textcontent6.text = pTitle;
}


- (void)LoadJieShuo:(NSDictionary *)pdic
{
    if (!pdic) {
        return;
    }
    
    NSString *bashURL = [pdic objectForKey:@"basePath"];
    
    pdic = [pdic objectForKey:@"talkSubject"];
    
    /*
    NSString *pstrBanner = [pdic objectForKey:@"image_Text"];
    pstrBanner = [bashURL stringByAppendingString:pstrBanner];
    [_jiangjieBanner setImageWithPath:pstrBanner];
    */
    
    NSString *pstrImgContent = [pdic objectForKey:@"image_Text"];
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
    
    UIView *pview = [_jiangjieContent viewWithTag:-1];
    if (pview) {
        [pview removeFromSuperview];
    }
    
    if (!_jiangjieimg) {
        _jiangjieimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width / 2, size.height / 2)];
    }
    else
    {
        [_jiangjieimg setFrame:CGRectMake(0, 0, size.width / 2, size.height / 2)];
    }
    _jiangjieimg.tag = -1;
    _jiangjieimg.image = img;
    [_jiangjieContent setContentSize:CGSizeMake(size.width / 2, size.height / 2)];
    [_jiangjieContent addSubview:_jiangjieimg];
    [_jiangjieContent setContentOffset:CGPointMake(0, 0)];
}

- (void)LoadZuDuan:(NSDictionary *)pdic//组段
{
    if (!pdic) {
        return;
    }
    
    NSString *bashURL = [pdic objectForKey:@"basePath"];
    
    pdic = [pdic objectForKey:@"talkGroup"];
    NSString *pstrImgContent = [pdic objectForKey:@"sentence"];
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


- (void)LoadLianJu:(NSDictionary *)pdic//联句
{
    if (!pdic) {
        return;
    }
    
    NSString *bashURL = [pdic objectForKey:@"basePath"];
    
    pdic = [pdic objectForKey:@"talkCouplet"];
    NSString *pstrImgContent = [pdic objectForKey:@"sentence"];
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

- (void)LoadOther:(NSDictionary *)pdic //排列
{
    if (!pdic) {
        return;
    }
    
    NSString *bashURL = [pdic objectForKey:@"basePath"];
    
    pdic = [pdic objectForKey:@"talkSort"];
    NSString *pstrImgContent = [pdic objectForKey:@"sentence"];
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

- (void)LoadMofang:(NSDictionary *)pdic //模仿
{
    if (!pdic) {
        return;
    }
    
    NSString *bashURL = [pdic objectForKey:@"basePath"];
    
    pdic = [pdic objectForKey:@"talkImitation"];
    NSString *pstrImgContent = [pdic objectForKey:@"imitation_section"];
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

- (void)LoadZaoJu:(NSDictionary *)pdic //造句
{
    if (!pdic) {
        return;
    }
    
    NSString *bashURL = [pdic objectForKey:@"basePath"];
    
    pdic = [pdic objectForKey:@"talkSentenceMaking"];
    NSString *pstrImgContent = [pdic objectForKey:@"sentence"];
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


- (void)hidenall
{
//    [_btnAnser setHidden:YES];
    [self setAnserBtnsHidden:YES];
    [_btnpushguangchang setHidden:YES];
    [_btnspeak setHidden:YES];
    [_btnxiugai setHidden:YES];
    [_textview setHidden:YES];
    [_viewjiangjie setHidden:YES];
    [_viewother setHidden:YES];
    [_textcontent6 setHidden:NO];
}

- (void)setAnserBtnsHidden:(BOOL)bflag
{
    [_aw_A setHidden:bflag];
    [_aw_B setHidden:bflag];
    [_aw_C setHidden:bflag];
    [_aw_D setHidden:bflag];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_dic6_1) {
        return;
    }
    
    NSNumber *pint = [_dic6_1 objectForKey:@"stem_num"];
    _id6 = pint.integerValue;
    [self LoadTitle:_dic6_1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnsubmenu:(UIButton *)sender {
    
    NSString *ptmp;
    if (_segmain.selectedSegmentIndex == 0) {
        ptmp = [NSString stringWithFormat:@"shuo%02ld.png",sender.tag];
        _current6 = sender.tag;
        [self RestView6];
        
    }
    else
    {
        ptmp = [NSString stringWithFormat:@"shuo7_%02ld.png",sender.tag];
        _current7 = sender.tag;
        [self RestView7];
    }
    _imgmenu.image = [UIImage imageNamed:ptmp];
}



- (void)RestView6
{
    switch (_current6) {
        case 0://题目
        {
            if (!_dic6_1) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSubjectByRandom?str=%ld&judge=6分",_subID];
                _dic6_1 = [self GetJson:ptmp];
                ptmp = [_dic6_1 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
                
                if (_dic6_1) {
                    _dic6_1 = [_dic6_1 objectForKey:@"talkSubject"];
                }
                ptmp = [_dic6_1 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            NSNumber *pint = [_dic6_1 objectForKey:@"stem_num"];
            _id6 = pint.integerValue;
            [self hidenall];
            [_textview setHidden:NO];
            [self LoadTitle:_dic6_1];
        }
            break;
        case 1://讲解
        {
            if (!_dic6_2) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneConceptionMapByRandom?conceptionMap.module_Name=说&conceptionMap.rank=6分&conceptionMap.stem_num=%ld",_id6];
                _dic6_2 = [self GetJson:ptmp];
                if (_dic6_2) {
                    ptmp = [_dic6_2 objectForKey:@"Result"];
                }
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [self hidenall];
            [_viewjiangjie setHidden:NO];
            [self LoadJieShuo:_dic6_2];
        }
            break;
        case 2://排列
        {
            if (!_dic6_3) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSortByRandom?str=%ld",_id6];
                _dic6_3 = [self GetJson:ptmp];
                if (_dic6_3) {
                    ptmp = [_dic6_3 objectForKey:@"Result"];
                }
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [self hidenall];
            [_viewother setHidden:NO];
//            [_btnAnser setHidden:NO];
            [self setAnserBtnsHidden:NO];
            [self LoadOther:_dic6_3];
        }
            break;
        case 3://模仿
        {
            if (!_dic6_4) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkImitationByRandom?str=%ld",_id6];
                _dic6_4 = [self GetJson:ptmp];
                if (_dic6_4) {
                    ptmp = [_dic6_4 objectForKey:@"Result"];
                }
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [self hidenall];
            [_viewother setHidden:NO];
            [_btnpushguangchang setHidden:NO];
            [_btnspeak setHidden:NO];
            [_btnxiugai setHidden:NO];
            [self LoadMofang:_dic6_4];
        }
            break;
        case 4://造句
        {
            if (!_dic6_5) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSentenceMakingByRandom?str=%ld&judge=6分",_id6];
                _dic6_5 = [self GetJson:ptmp];
                ptmp = [_dic6_5 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [self hidenall];
            [_viewother setHidden:NO];
            [self setAnserBtnsHidden:NO];
            [self LoadZaoJu:_dic6_5];
        }
            break;
        default:
            break;
    }
}

- (void)RestView7
{
    [self hidenall];
    switch (_current7) {
        case 0://题目
        {
            if (!_dic7_1) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSubjectByRandom?str=%ld&judge=7分",_subID];
                _dic7_1 = [self GetJson:ptmp];
                ptmp = [_dic7_1 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
                
                if (_dic7_1) {
                    _dic7_1 = [_dic7_1 objectForKey:@"talkSubject"];
                }
                ptmp = [_dic7_1 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            NSNumber *pint = [_dic7_1 objectForKey:@"stem_num"];
            _id7 = pint.integerValue;
            [self hidenall];
            [_textview setHidden:NO];
            [self LoadTitle:_dic7_1];
        }
            break;
        case 1://讲解
        {
            if (!_dic7_2) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneConceptionMapByRandom?conceptionMap.module_Name=说&conceptionMap.rank=7分&conceptionMap.stem_num=%ld",_id7];
                _dic7_2 = [self GetJson:ptmp];
                if (_dic7_2) {
                    ptmp = [_dic7_2 objectForKey:@"Result"];
                }
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [self hidenall];
            [_viewjiangjie setHidden:NO];
            [self LoadJieShuo:_dic7_2];
        }
            break;
        case 2://造句
            if (!_dic7_3) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSentenceMakingByRandom?str=%ld&judge=7分",_id7];
                _dic7_3 = [self GetJson:ptmp];
                ptmp = [_dic7_3 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [self hidenall];
            [_viewother setHidden:NO];
            [self setAnserBtnsHidden:NO];
            [self LoadZaoJu:_dic7_3];
            break;
        case 3://联句
        {
            if (!_dic7_4) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkCoupletByRandomForAPP?str=%ld&judge=7分",_id7];
                _dic7_4 = [self GetJson:ptmp];
                ptmp = [_dic7_4 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [_viewother setHidden:NO];
            [self setAnserBtnsHidden:NO];
            [self LoadLianJu:_dic7_4];
        }
            break;
        case 4://组段
        {
            if (!_dic7_5) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkGroupByRandomForAPP?str=%ld",_id7];
                _dic7_5 = [self GetJson:ptmp];
                ptmp = [_dic7_5 objectForKey:@"Result"];
                if ([ptmp isEqualToString:@"0"]) {
                    return;
                }
            }
            [_viewother setHidden:NO];
            [self LoadZuDuan:_dic7_5];
        }
            break;
        default:
            break;
    }
}

- (IBAction)changeclick:(UISegmentedControl *)sender {
    NSString *ptmp;
    if (sender.selectedSegmentIndex == 0) {
        ptmp = [NSString stringWithFormat:@"shuo%02ld.png",_current6];
        [self RestView6];
    }
    else
    {
        ptmp = [NSString stringWithFormat:@"shuo7_%02ld.png",_current7];
        [self RestView7];
    }
    _imgmenu.image = [UIImage imageNamed:ptmp];
}

- (IBAction)btnanser:(id)sender {
    
}

- (IBAction)nextquestion:(id)sender {
    if (_segmain.selectedSegmentIndex == 0) {
        _dic6_1 = nil;
        _dic6_2 = nil;
        _dic6_3 = nil;
        _dic6_4 = nil;
        _dic6_5 = nil;
        
        _current6 = 0;
        _imgmenu.image = [UIImage imageNamed:@"shuo00.png"];
        NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSubjectByRandom?str=%ld&judge=6分",_subID];
        _dic6_1 = [self GetJson:ptmp];
        if (_dic6_1) {
            _dic6_1 = [_dic6_1 objectForKey:@"talkSubject"];
        }
        [self RestView6];
    }
    else
    {
        _dic7_1 = nil;
        _dic7_2 = nil;
        _dic7_3 = nil;
        _dic7_4 = nil;
        _dic7_5 = nil;
        
        _current6 = 0;
        _imgmenu.image = [UIImage imageNamed:@"shuo7_00.png"];
        NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSubjectByRandom?str=%ld&judge=7分",_subID];
        _dic7_1 = [self GetJson:ptmp];
        if (_dic7_1) {
            _dic7_1 = [_dic7_1 objectForKey:@"talkSubject"];
        }
        [self RestView7];
    }
}

- (void)timerfire:(NSTimer*)timer
{
    if (tick > 15) {
        tick = 0;
        [tSpeak invalidate];
        tSpeak = nil;
        //停止录音
        [recoder StartRecording];
        
        if (_segmain.selectedSegmentIndex == 0) {
            bspeak6 = true;
            bspeak7 = false;
        }
        else
        {
            bspeak7 = true;
            bspeak6 = false;
        }
    }
    tick++;
}

- (IBAction)beginspeak:(id)sender {
    if (tSpeak) {
        [tSpeak invalidate];
        tSpeak = nil;
    }
    
    //开始录音
    bspeak6 = false;
    bspeak7 = false;
    [recoder StartRecording];
    tick = 0;
    tSpeak = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerfire:) userInfo:nil repeats:YES];
}


- (IBAction)endspeak:(id)sender {
    if (tSpeak) {
        [tSpeak invalidate];
        tSpeak = nil;
    }
    
    bspeak6 = true;
    bspeak7 = false;
    [recoder StopRecording];
}

- (IBAction)humanFix:(id)sender {
    if (bspeak6) {
        //上传
   //     [recoder PlayRecordingMP3];
        if (!_dic6_4) {
            return;
        }
        AppDelegate *papp = [[UIApplication sharedApplication] delegate];
        NSString *pnum = papp.ph_num;
        pnum = @"13886445784";
        NSString *strFile = [recoder GetRecordFilePathMP3];
        NSDictionary *pdic = [_dic6_4 objectForKey:@"talkImitation"];
        NSString *purl = [pdic objectForKey:@"imitation_section"];
        NSNumber *titleNum = [pdic objectForKey:@"title_number"];
        NSString *strtmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/saveOneCounterProblem?str=%@&problem.stemNumber=%ld&problem.title=说6分题第%ld题&problem.quizContent=%@",pnum,titleNum.integerValue,titleNum.integerValue,purl];
        
        //       NSString *strtmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/updatePhotoGraphByhql?userInfo.phone_Number=%@",pnum];
        NSString *ptmp = [strtmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:ptmp];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setFile:strFile forKey:@"upload"];
        [request startSynchronous];
        if ([request complete]) {
            
            UIAlertView *msgView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传语音成功" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [msgView   show];
        }
        else
        {
            UIAlertView *msgView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传语音失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [msgView   show];
        }

    }
}

- (IBAction)PlayMedia:(id)sender {
    if (_segmain.selectedSegmentIndex == 0) {
        if (_dic6_2) {
            NSString *bashURL = [_dic6_2 objectForKey:@"basePath"];
            NSDictionary *pdic = [_dic6_2 objectForKey:@"talkSubject"];
            NSString *MediaURL = [pdic objectForKey:@"video_Address"];
            MediaURL = [bashURL stringByAppendingString:MediaURL];
            [self PlayMovie:MediaURL];
            return;
        }
    }
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason integerValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            //自动播放下一个
        {
            AppDelegate *papp = [[UIApplication sharedApplication] delegate]; //让视屏支持旋转
            papp._isMovieFullScreen = NO;
            [self dismissMoviePlayerViewControllerAnimated];
        }
            break;
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"error1");
            break;
        case MPMovieFinishReasonUserExited://点击done或完成出发这个事件
        {
            NSLog(@"movie exit");
            AppDelegate *papp = [[UIApplication sharedApplication] delegate]; //让视屏支持旋转
            papp._isMovieFullScreen = NO;
            [self dismissMoviePlayerViewControllerAnimated];
        }
            break;
        default:
            break;
    }
}



- (void)PlayMovie:(NSString *)Url
{
    NSURL* url1 = [NSURL URLWithString:Url];
    MyMovieViewController *pmov = [[MyMovieViewController alloc] initWithContentURL:url1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:pmov.moviePlayer];
    
    
    [pmov.moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
    
    pmov.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    pmov.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    pmov.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
    pmov.moviePlayer.repeatMode = MPMovieRepeatModeNone;
//    AppDelegate *papp = [[UIApplication sharedApplication] delegate]; //让视屏支持旋转
//    papp._isMovieFullScreen = YES;
    [self presentViewController:pmov animated:YES completion:nil];
    
}

- (BOOL)CheckAnswerZuDuan:(NSInteger)selectid
{
    if (_dic7_5) {
        NSDictionary *pdic = [_dic7_5 objectForKey:@"talkGroup"];
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
        NSNumber *titleNum = [pdic objectForKey:@"title_number"];
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

- (BOOL)CheckAnswerLianJu:(NSInteger)selectid
{
    if (_dic7_4) {
        NSDictionary *pdic = [_dic7_4 objectForKey:@"talkCouplet"];
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
        NSNumber *titleNum = [pdic objectForKey:@"title_number"];
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
            NSString *pstr = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English//saveOneWrongTopic?wrongTopic.moduleName=说&wrongTopic.subModuleName=联句&wrongTopic.titleNumber=%ld&str=%@",titleNum.integerValue,strNum];
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


- (BOOL)CheckAnswerZaoju7:(NSInteger)selectid
{
    if (_dic7_3) {
        NSDictionary *pdic = [_dic7_3 objectForKey:@"talkSentenceMaking"];
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
        NSNumber *titleNum = [pdic objectForKey:@"title_number"];
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
            NSString *pstr = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English//saveOneWrongTopic?wrongTopic.moduleName=说&wrongTopic.subModuleName=造句&wrongTopic.titleNumber=%ld&str=%@",titleNum.integerValue,strNum];
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

- (BOOL)CheckAnswerZaoju:(NSInteger)selectid
{
    if (_dic6_5) {
        NSDictionary *pdic = [_dic6_5 objectForKey:@"talkSentenceMaking"];
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
        NSNumber *titleNum = [pdic objectForKey:@"title_number"];
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
            NSString *pstr = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English//saveOneWrongTopic?wrongTopic.moduleName=说&wrongTopic.subModuleName=造句&wrongTopic.titleNumber=%ld&str=%@",titleNum.integerValue,strNum];
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

- (void)CheckAnswerPailie:(NSInteger)selectid
{
    if (_dic6_3) {
        NSDictionary *pdic = [_dic6_3 objectForKey:@"talkSort"];
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
        NSNumber *titleNum = [pdic objectForKey:@"title_number"];
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
            NSString *pstr = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English//saveOneWrongTopic?wrongTopic.moduleName=说&wrongTopic.subModuleName=排列&wrongTopic.titleNumber=%ld&str=%@",titleNum.integerValue,strNum];
            [self GetJson:pstr];
            return;
        }
        else
        {
            return;
        }
    }
    return;
}

- (IBAction)selectAnswer:(UIButton *)sender {
    if (_segmain.selectedSegmentIndex == 0) {//6分
        switch (_current6) {
            case 2://排列
            {
                //无论正确与否都直接去当前下一题
                [self CheckAnswerPailie:sender.tag];
                _dic6_3 = nil; //从新获取新题
                [self RestView6];
            }
                break;
            case 4://造句
            {
                if ([self CheckAnswerZaoju:sender.tag]) {//正确获取当前下一题
                    _dic6_5 = nil;
                    [self RestView6];
                }
                else//错误获取当前相似题
                {
                    NSDictionary *pdic = [_dic6_5 objectForKey:@"talkSentenceMaking"];
                    NSNumber *ptitle = [pdic objectForKey:@"title_number"];
                    NSString* purl = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSentenceMakingBySimilarityRandom?str=%ld",ptitle.integerValue];
                    _dic6_5 = [self GetJson:purl];
                    [self RestView6];
                }

            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (_current7) {
            case 2://造句
            {
                if ([self CheckAnswerZaoju:sender.tag]) {//正确获取当前下一题
                    _dic7_3 = nil;
                    [self RestView7];
                }
                else//错误获取当前相似题
                {
                    NSDictionary *pdic = [_dic7_3 objectForKey:@"talkSentenceMaking"];
                    NSNumber *ptitle = [pdic objectForKey:@"title_number"];
                    NSString* purl = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSentenceMakingBySimilarityRandom?str=%ld",ptitle.integerValue];
                    _dic7_3 = [self GetJson:purl];
                    [self RestView7];
                }
            }
                break;
            case 3://联句
            {
                if ([self CheckAnswerLianJu:sender.tag]) {//正确获取当前下一题
                    _dic7_4 = nil;
                    [self RestView7];
                }
                else//错误获取当前相似题
                {
                    NSDictionary *pdic = [_dic7_4 objectForKey:@"talkCouplet"];
                    NSNumber *ptitle = [pdic objectForKey:@"title_number"];
                    NSString* purl = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkCoupletByRandomAndSimilarForAPP?str=%ld",ptitle.integerValue];
                    _dic7_3 = [self GetJson:purl];
                    [self RestView7];
                }
            }
                break;
            case 4://组段
            {
                [self CheckAnswerZuDuan:sender.tag];
                _dic7_5 = nil; //从新获取新题
                [self RestView7];
            }
                break;
            default:
                break;
        }
    }
}

- (IBAction)btn_pushtoGuangchang:(id)sender {
    if (bspeak6) {
        if (!_dic6_4) {
            return;
        }
        AppDelegate *papp = [[UIApplication sharedApplication] delegate];
        NSString *pnum = papp.ph_num;
        pnum = @"13886445784";
        NSString *strFile = [recoder GetRecordFilePathMP3];
        NSDictionary *pdic = [_dic6_4 objectForKey:@"talkImitation"];
        NSNumber *titleNum = [pdic objectForKey:@"title_number"];
        NSString *strtmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/saveOrUpdateOneVoiceSquare?str=%ld&str1=%@",titleNum.integerValue,pnum];
        
 //       NSString *strtmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/updatePhotoGraphByhql?userInfo.phone_Number=%@",pnum];
        
        NSString *ptmp = [strtmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:ptmp];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setFile:strFile forKey:@"upload"];
        [request startSynchronous];
        if ([request complete]) {
            
            UIAlertView *msgView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传语音成功" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [msgView   show];
        }
        else
        {
            UIAlertView *msgView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传语音失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [msgView   show];
        }
        
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
