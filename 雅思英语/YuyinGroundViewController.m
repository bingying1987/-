//
//  YuyinGroundViewController.m
//  雅思英语
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "YuyinGroundViewController.h"
#import "UIViewController+Json.h"
#import "ASIHTTPRequest.h"
#import "DBImageViewCache.h"
#import "MyRecorder.h"
@interface YuyinGroundViewController ()
@property (nonatomic)NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;
@end

@implementation YuyinGroundViewController
@synthesize dic;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = @"http://192.168.1.231:8080/YaSi_English/selectSomeVoiceSquareByIOS";
    dic = [self GetJson:url];
    if (dic) {
        NSString *res = [dic objectForKey:@"Result"];
        if ([res isEqualToString:@"0"]) {
            dic = nil;
            return;
        }
    }
    // Do any additional setup after loading the view.
}

- (void)LoadTitle:(NSDictionary *)pdic
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
    
    NSString *pstrImgContent = [pdic objectForKey:@"题目"];
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
    
    UIView *pview = [_scrollContent viewWithTag:-1];
    if (pview) {
        [pview removeFromSuperview];
    }
    
    static UIImageView *contentImg = nil;
    
    if (!contentImg) {
        contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width / 2, size.height / 2)];
    }
    else
    {
        [contentImg setFrame:CGRectMake(0, 0, size.width / 2, size.height / 2)];
    }
    contentImg.tag = -1;
    contentImg.image = img;
    [_scrollContent setContentSize:CGSizeMake(size.width / 2, size.height / 2)];
    [_scrollContent addSubview:contentImg];
    [_scrollContent setContentOffset:CGPointMake(0, 0)];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self LoadTitle:dic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!dic) {
        return nil;
    }
    static BOOL bflag = false;
    UITableViewCell *cell = nil;
    if(!bflag) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NOdetail"];
        bflag = true;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NoDetail" forIndexPath:indexPath];
    }
    
    NSString *basePath = [dic objectForKey:@"basePath"];
    
    NSArray *parr = [dic objectForKey:@"voiceSquares"];
    NSDictionary *dictmp = [parr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dictmp objectForKey:@"nickname"];
    cell.detailTextLabel.text = [dictmp objectForKey:@"pubdate"];
    NSString *imgPath = [dictmp objectForKey:@"avatar"];
    
    imgPath = [basePath stringByAppendingString:imgPath];
    NSURL *url = [NSURL URLWithString:imgPath];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if (!data) {
        return cell;
    }
    UIImage *img = [UIImage imageWithData:data];
    cell.imageView.image = img;
    
    UIButton *lb = (UIButton*)[cell viewWithTag:-1];
    if (lb) {
        [lb setUserInteractionEnabled:NO];
        lb.tag = indexPath.row;
    }
    else
    {
        CGRect rc = [cell.imageView frame];
        rc.origin.x = rc.origin.x + 200;
        rc.origin.y += 10;
        rc.size.height -= 20;
        rc.size.width += 30;
        
        lb = [UIButton buttonWithType:UIButtonTypeCustom];
        [lb setFrame:rc];
        [lb setBackgroundImage:[UIImage imageNamed:@"语音.png"] forState:UIControlStateNormal];
        lb.tag = -1;
        [lb setUserInteractionEnabled:NO];
        
        [lb addTarget:self action:@selector(playvoice:) forControlEvents:UIControlEventTouchUpInside];
        lb.tag = indexPath.row;
        [cell.contentView addSubview:lb];
    }
    
    NSString *mp3path = [dictmp objectForKey:@"imitation_voice"];
    NSString *mp3url = [mp3path stringByAppendingString:basePath];
    NSURL *urlmp3 = [NSURL URLWithString:mp3url];
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    
    dir = [dir stringByAppendingString:mp3path];
    
    
    ASIHTTPRequest *quest = [[ASIHTTPRequest alloc] initWithURL:urlmp3];
    [quest setDownloadDestinationPath:dir];
    [quest setDidFinishSelector:@selector(requestFinished1:)];
    quest.tag = indexPath.row;
    return cell;
}

- (void)playvoice:(UIButton*)sender
{
    NSArray *parr = [dic objectForKey:@"voiceSquares"];
    NSDictionary *dictmp = [parr objectAtIndex:sender.tag];
    NSString *mp3path = [dictmp objectForKey:@"imitation_voice"];
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    dir = [dir stringByAppendingString:mp3path];
    MyRecorder *recorder = [MyRecorder recorder];
    [recorder StopPlaying];
    [recorder PlayFile:dir];
}

- (void)requestFinished1:(ASIHTTPRequest *)request
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:request.tag inSection:0];
    UITableViewCell *cell = [__tableView cellForRowAtIndexPath:index];
    UIButton *lb = (UIButton*)[cell viewWithTag:-1];
    if (lb) {
        [lb setUserInteractionEnabled:YES];
    }
}

- (IBAction)nextqustion:(id)sender {
    NSString *url = @"http://192.168.1.231:8080/YaSi_English/selectSomeVoiceSquareByIOS";
    dic = [self GetJson:url];
    if (dic) {
        NSString *res = [dic objectForKey:@"Result"];
        if ([res isEqualToString:@"0"]) {
            dic = nil;
            return;
        }
    }
    
    [self LoadTitle:dic];
    [__tableView reloadData];
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
