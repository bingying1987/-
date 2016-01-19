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


@interface SpeakPartViewController ()
{
    NSInteger _current6;
    NSInteger _current7;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgmenu;
@property (weak, nonatomic) IBOutlet UITextView *textcontent6;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmain;



@property (nonatomic) NSDictionary *dic6_2;
@property (nonatomic) NSDictionary *dic6_3;
@property (nonatomic) NSDictionary *dic6_4;
@property (nonatomic) NSDictionary *dic6_5;
@property (nonatomic) NSInteger id6;

@property (weak, nonatomic) IBOutlet UIButton *btnAnser;
@property (weak, nonatomic) IBOutlet UIButton *btnspeak;
@property (weak, nonatomic) IBOutlet UIButton *btnxiugai;
@property (weak, nonatomic) IBOutlet UIButton *btnpushguangchang;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@property (weak, nonatomic) IBOutlet UIView *viewother;
@property (weak, nonatomic) IBOutlet UIView *viewjiangjie;
@property (weak, nonatomic) IBOutlet DBImageView *jiangjieBanner;
@property (weak, nonatomic) IBOutlet UIScrollView *jiangjieContent;
@property (weak, nonatomic) IBOutlet DBImageView *jiangjieimg;

@property (weak, nonatomic) IBOutlet DBImageView *otherimgContent;
@property (weak, nonatomic) IBOutlet UIScrollView *otherscroll;
@property (weak, nonatomic) IBOutlet UITextView *textOther;





@end

@implementation SpeakPartViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _id6 = -1;
    _subID = 0;
    _current6 = 0;
    _current7 = 0;
    [_textOther.layer setBorderWidth:3.0f];
    _textOther.layer.borderColor = [UIColor grayColor].CGColor;
    _textOther.layer.cornerRadius = 5.0f;
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
    NSString *pstrBanner = [pdic objectForKey:@"banner"];
    [_jiangjieBanner setImageWithPath:pstrBanner];
    
    NSString *pstrImgContent = [pdic objectForKey:@"内容"];
    [_jiangjieimg setImageWithPath:pstrImgContent];
    CGSize size = [_jiangjieimg GetImageSize];
    [_jiangjieimg setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_jiangjieContent setContentSize:size];
}

- (void)LoadOther:(NSDictionary *)pdic
{
    if (!pdic) {
        return;
    }
    NSString *pstrimg = [pdic objectForKey:@"img内容"];
    [_otherimgContent setImageWithPath:pstrimg];
    CGSize size = _otherimgContent.image.size;
    [_otherimgContent setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_otherscroll setContentSize:size];
    
}


- (void)hidenall
{
    [_btnAnser setHidden:YES];
    [_btnpushguangchang setHidden:YES];
    [_btnspeak setHidden:YES];
    [_btnxiugai setHidden:YES];
    [_textview setHidden:YES];
    [_viewjiangjie setHidden:YES];
    [_viewother setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_dic6_1) {
        return;
    }
    
    NSNumber *pint = [_dic6_1 objectForKey:@"id"];
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
    [self hidenall];
    switch (_current6) {
        case 0://题目
        {
            if (!_dic6_1) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSubjectByRandom?str=%ld",_subID];
                _dic6_1 = [self GetJson:ptmp];
                if (_dic6_1) {
                    _dic6_1 = [_dic6_1 objectForKey:@"talkSubject"];
                }
            }
            NSNumber *pint = [_dic6_1 objectForKey:@"id"];
            _id6 = pint.integerValue;
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
                    _dic6_2 = [_dic6_2 objectForKey:@"talkSubject"];
                }
            }
            [_viewjiangjie setHidden:NO];
            [self LoadJieShuo:_dic6_2];
        }
            break;
        case 2://排列
        {
            if (!_dic6_3) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneConceptionMapByRandom?conceptionMap.module_Name=说&conceptionMap.rank=6分&conceptionMap.stem_num=%ld",_id6];
                _dic6_3 = [self GetJson:ptmp];
                if (_dic6_3) {
                    _dic6_3 = [_dic6_3 objectForKey:@"talkSubject"];
                }
            }
            [_viewother setHidden:NO];
            [self LoadOther:_dic6_3];
        }
            break;
        case 3://模仿
        {
            if (!_dic6_4) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneConceptionMapByRandom?conceptionMap.module_Name=说&conceptionMap.rank=6分&conceptionMap.stem_num=%ld",_id6];
                _dic6_4 = [self GetJson:ptmp];
                if (_dic6_4) {
                    _dic6_4 = [_dic6_4 objectForKey:@"talkSubject"];
                }
            }
            [_viewother setHidden:NO];
            [self LoadOther:_dic6_4];
        }
            break;
        case 4://造句
        {
            if (!_dic6_5) {
                NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneConceptionMapByRandom?conceptionMap.module_Name=说&conceptionMap.rank=6分&conceptionMap.stem_num=%ld",_id6];
                _dic6_5 = [self GetJson:ptmp];
                if (_dic6_5) {
                    _dic6_5 = [_dic6_5 objectForKey:@"talkSubject"];
                }
            }
            [_viewother setHidden:NO];
            [self LoadOther:_dic6_5];
        }
            break;
        default:
            break;
    }
}

- (void)RestView7
{
    
}

- (IBAction)changeclick:(UISegmentedControl *)sender {
    NSString *ptmp;
    if (sender.selectedSegmentIndex == 0) {
        ptmp = [NSString stringWithFormat:@"shuo%02ld.png",_current6];
    }
    else
    {
        ptmp = [NSString stringWithFormat:@"shuo7_%02ld.png",_current7];
    }
    _imgmenu.image = [UIImage imageNamed:ptmp];
}

- (IBAction)btnanser:(id)sender {
    if ([_textOther.text isEqualToString:@""]) {
        return;
    }
    
    if (_segmain.selectedSegmentIndex == 0) {//6分
        NSDictionary *pdic = nil;
        switch (_current6) {
            case 2://排列
                pdic = _dic6_3;
                break;
            case 3:
                pdic = _dic6_4;
                break;
            case 4:
                pdic = _dic6_5;
                break;
            default:
                break;
        }
        
        NSString *strRight = [pdic objectForKey:@"anser"];
        if ([_textOther.text isEqualToString:strRight]) {
            //回答正确
        }
        else
        {
            //答案错误
        }
    }
    else
    {
        
    }
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
        NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneTalkSubjectByRandom?str=%ld",_subID];
        _dic6_1 = [self GetJson:ptmp];
        if (_dic6_1) {
            _dic6_1 = [_dic6_1 objectForKey:@"talkSubject"];
        }
        [self RestView6];
    }
    else
    {
        
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
