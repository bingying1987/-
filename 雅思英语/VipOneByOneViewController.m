//
//  VipPublicDetailViewController.m
//  雅思英语
//
//  Created by mac on 16/1/6.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "VipOneByOneViewController.h"
#import "UIViewController+Json.h"
#import "DBImageView.h"
#import "AppDelegate.h"

@interface Rowdata1 : NSObject
@property (nonatomic) NSString *Title;
@property (nonatomic) BOOL bHaveDetail;
@property (nonatomic) NSInteger NumofDetail;//子cell的个数
@property (nonatomic) BOOL isOpen;
@property (nonatomic) NSInteger ntag;
@property (nonatomic) NSInteger mainRow;
@property (nonatomic) NSInteger subRow;
@property (nonatomic) NSInteger nID;//仅评价时使用
@end


@interface VipOneByOneViewController ()
@property NSMutableArray *objects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *titleImg;
@property (nonatomic,weak) NSDictionary *dic;
@property (nonatomic)NSString *url;
@property (nonatomic)NSInteger ncount_pj;
@property (nonatomic)NSInteger current_pj;
@property (nonatomic)bool bflag;
@property (nonatomic,strong) NSMutableArray *arr_pj;//更多的评论
@property (nonatomic) NSString *basePath;
@property (weak, nonatomic) IBOutlet UIButton *btn_addmore;
@end




@implementation Rowdata1

@end

@implementation VipOneByOneViewController
@synthesize dic1;
@synthesize dic;
@synthesize id_ke;
@synthesize bflag;
@synthesize basePath;

- (void)createFooterView
{
    _tableView.tableFooterView = nil;
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,_tableView.bounds.size.width, 40.0f)];
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 40.0f)];
    [loadMoreText setCenter:tableFooterView.center];
    loadMoreText.textAlignment = NSTextAlignmentCenter;
    [loadMoreText setFont:[UIFont systemFontOfSize:13.0f]];
    [loadMoreText setText:@"正在加载数据..."];
    [tableFooterView addSubview:loadMoreText];
    _tableView.tableFooterView = tableFooterView;
    [_tableView.tableFooterView setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    bflag = true;
    if (dic1 == nil) {
        return;
    }
    dic = [dic1 objectForKey:@"courseForVIP"];
    
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NoDetail"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HaveDetail"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Pingjia"];
    
    
    NSString *pstrtail = nil;
    if (dic) {
        pstrtail = [dic objectForKey:@"course_Name"];
        _url = [dic objectForKey:@"classAddress"];
    }
    
    Rowdata1 *pRow1 = [Rowdata1 new];
    pRow1.Title = pstrtail;
    pRow1.mainRow = 0;
    Rowdata1 *pRow2 = [Rowdata1 new];
    pRow2.Title = @"课程描述";
    pRow2.bHaveDetail = YES;
    pRow2.NumofDetail = 2;
    pRow2.mainRow = 1;
    Rowdata1 *pRow3 = [Rowdata1 new];
    pRow3.Title = @"课程图文详情";
    pRow3.bHaveDetail = YES;
    pRow3.NumofDetail = 0;
    pRow3.mainRow = 2;
    Rowdata1 *pRow4 = [Rowdata1 new];
    pRow4.Title = @"课程信息";
    pRow4.bHaveDetail = YES;
    pRow4.NumofDetail = 3;
    pRow4.mainRow = 3;
    Rowdata1 *pRow5 = [Rowdata1 new];
    pRow5.Title = @"课程评价   ";
    pRow5.bHaveDetail = YES;
    pRow5.NumofDetail = 1;
    pRow5.mainRow = 4;
    Rowdata1 *pRow6= [Rowdata1 new];
    pRow6.Title = @"查看全部评价";
    pRow6.bHaveDetail = NO;
    pRow6.mainRow = 5;
    
    _objects = [[NSMutableArray alloc] init];
    [_objects addObjectsFromArray:@[pRow1,pRow2,pRow3,pRow4,pRow5,pRow6]];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *pstrTitle = nil;
    NSString *pstrtail = nil;
    if (dic) {
        pstrTitle = [dic1 objectForKey:@"basePath"];
        basePath = pstrTitle;
        pstrtail = [dic objectForKey:@"course_Address"];
    }
    pstrTitle = [pstrTitle stringByAppendingString:pstrtail];
    DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 0, 0, _titleImg.bounds.size.width, _titleImg.bounds.size.height }];
    [imageView setImageWithPath:pstrTitle];
    [_titleImg addSubview:imageView];
    
    
    NSNumber *pnum = nil;
    if (dic1) {
        pnum = [dic1 objectForKey:@"maxTotal"];
        _ncount_pj = pnum.intValue;
    }
    
    [self createFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn_click:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    //申请报名
 //   NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/insertOneApplyForCourseForVIP?apply.courseId=%ld&userInfo.phone_Number=%@&userInfo.passWord=%@",id_ke,app.ph_num,app.ph_pw];
    
    NSString *ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/insertOneApplyForCourseForVIP?apply.courseId=41&userInfo.phone_Number=13886445784&userInfo.passWord=123456789"];
    
    
    NSDictionary *dictmp1 = [self GetJson:ptmp];
    if (!dictmp1) {
        return;
    }
    NSString *a1 = [dictmp1 objectForKey:@"Message"];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:a1
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    Rowdata1* pdata = [_objects objectAtIndex:indexPath.row];
    if (pdata.bHaveDetail) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HaveDetail" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        if (pdata.ntag != 40002) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NoDetail" forIndexPath:indexPath];//使用默认的单行cell
        }
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Pingjia" forIndexPath:indexPath];
        }
    }
    
    
    
    switch (pdata.ntag) {
        case 0:
        {
            if (pdata.mainRow == 4) {//课程评价
                NSString *pstr1 = @"课程评价   ";
                NSString *pstr2 = nil;
                
                NSNumber *pnum = nil;
                if (dic1) {
                    pnum = [dic1 objectForKey:@"maxTotal"];
                    _ncount_pj = pnum.intValue;
                }
                
                pstr2 = [NSString stringWithFormat:@"共%d条评论",pnum.intValue];
                pstr1 = [pstr1 stringByAppendingString:pstr2];
                
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:pstr1];
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(8, AttributedStr.length - 8)];//课程评价+三个空格
                cell.textLabel.attributedText = AttributedStr;
            }
            else
            {
                cell.textLabel.text = pdata.Title;
                cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
            }
        }
            break;
        case 10001:
        {
            cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"适合人群:   "];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
            
            NSString *pstr1 = nil;
            if (dic) {
                pstr1 = [dic objectForKey:@"suitCrowd"];
            }
            
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:pstr1];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            cell.textLabel.attributedText = AttributedStr;
            
        }
            break;
        case 10002:
        {
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"学习目的:   \r"];
            NSString *pstr1 = nil;
            if (dic) {
                pstr1 = [dic objectForKey:@"learningGoal"];
                pstr1 = [pstr1 stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
            }
            
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:pstr1];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
            
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.attributedText = AttributedStr;
        }
            break;
        case 30001:
        {
            NSString *pstr1 = nil;
            if (dic) {
                pstr1 = [dic objectForKey:@"lecturer"];
            }
            
            pstr1 = [pstr1 stringByAppendingString:@"   (点击查看详情)"];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:pstr1];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(AttributedStr.length - 8, 8)];//最大人数300人+三个空格
            cell.textLabel.attributedText = AttributedStr;

        }
            break;
        case 30002:
        {
            NSString *pstr1 = nil;
            if (dic) {
                NSNumber *num  = [dic objectForKey:@"setmaxuser"];
                pstr1 = [NSString stringWithFormat:@"最大人数%d人",num.intValue];
            }
            
            NSString *pstr2 = nil;
            NSNumber *num1 = [dic objectForKey:@"apply_number"];
            pstr2 = [NSString stringWithFormat:@"(已报%d人)",num1.intValue];
            
            
            pstr1 = [pstr1 stringByAppendingString:@"   "];
            pstr1 = [pstr1 stringByAppendingString:pstr2];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:pstr1];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(11, AttributedStr.length - 11)];//最大人数300人+三个空格
            cell.textLabel.attributedText = AttributedStr;
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:@"报名" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(250, 5, 50, 30)];
            btn.backgroundColor = [UIColor greenColor];
            [btn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            
            
            
        }
            break;
        case 30003:
        {
            NSString *pstr1 = nil;
            if (dic) {
                pstr1 = [dic objectForKey:@"class_duration"];
            }
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:pstr1];
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:@"   （支持手机观看）"];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(11, AttributedStr.length - 11)];//课程时长+三个空格
            cell.textLabel.attributedText = AttributedStr;
        }
            break;
        case 40001:
        {
            NSString *pstrTitle = nil;
            NSString *pstrtail = nil;
            NSDictionary *dic2 = [dic1 objectForKey:@"comment"];
            if (dic2) {
                pstrTitle = [dic1 objectForKey:@"basePath"];
                pstrtail = [dic2 objectForKey:@"userInfoPortrait"];
            }
            pstrTitle = [pstrTitle stringByAppendingString:pstrtail];
            DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 10, 10, 30, 30 }];
            [imageView setImageWithPath:pstrTitle];
            imageView.layer.cornerRadius = 15.0f;
            imageView.clipsToBounds = YES;
            imageView.layer.borderWidth = 3.0f;
            
            
            NSString *name = [dic2 objectForKey:@"userInfoNickname"];
            UILabel *labelName = [[UILabel alloc] init];
            labelName.font = [UIFont systemFontOfSize:13.0];
            labelName.text = name;
            [labelName setFrame:CGRectMake(50, 4, 150, 20)];
            
            NSString *pingjia = [dic2 objectForKey:@"evaluate"];
            UILabel *labelPingJia = [[UILabel alloc] init];
            labelPingJia.font = [UIFont systemFontOfSize:13.0];
            labelPingJia.text = pingjia;
            [labelPingJia setFrame:CGRectMake(50, 25, 150, 20)];
            
            
            UILabel *labelContent = [[UILabel alloc] init];
            labelContent.font = [UIFont systemFontOfSize:13.0];
            NSString *pContent = [dic2 objectForKey:@"remark"];
            pContent = [pContent stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:pContent];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            [labelContent setFrame:CGRectMake(10, 60, rc.size.width, rc.size.height)];
            labelContent.numberOfLines = 0;
            labelContent.attributedText = AttributedStr;
            
            [cell addSubview:imageView];
            [cell addSubview:labelName];
            [cell addSubview:labelPingJia];
            [cell addSubview:labelContent];
        }
            break;
        case 40002:
        {
            if (!_arr_pj) {
                return cell;
            }
            
            NSDictionary *dictmp = nil;
            BOOL bfound = false;
            for (int i = 0; i < _arr_pj.count; i++) {
                dictmp = [_arr_pj objectAtIndex:i];
                NSNumber *nid = [dictmp objectForKey:@"id"];
                if (nid.integerValue == pdata.nID) {
                    bfound = true;
                    break;
                }
            }
            
            if (!bfound) {
                return  cell;
            }
            
            NSString *pstrTitle = nil;
            NSString *pstrtail = nil;
            if (dictmp) {
            //    pstrTitle = [_dic_pj objectForKey:@"basePath"];
                pstrTitle = basePath;
                pstrtail = [dictmp objectForKey:@"userInfoPortrait"];
            }
            pstrTitle = [pstrTitle stringByAppendingString:pstrtail];
            NSString *name = [dictmp objectForKey:@"userInfoNickname"];
            NSString *pingjia = [dictmp objectForKey:@"evaluate"];
            NSString *pContent = [dictmp objectForKey:@"remark"];
            if ([cell viewWithTag:-4]) {//该cell已经添加过子视图了
                DBImageView *dbtmp = (DBImageView*)[cell viewWithTag:-1];
                [dbtmp setImageWithPath:pstrTitle];
                UILabel *lablename1 = (UILabel*)[cell viewWithTag:-2];
                lablename1.text = name;
                UILabel *labelpingjia1 = (UILabel*)[cell viewWithTag:-3];
                labelpingjia1.text = pingjia;
                UILabel *labelContent = (UILabel*)[cell viewWithTag:-4];
                
                pContent = [pContent stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:pContent];
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
                CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                [labelContent setFrame:CGRectMake(10, 60, rc.size.width, rc.size.height)];
                labelContent.numberOfLines = 0;
                labelContent.attributedText = AttributedStr;
                
                return cell;
            }
            
            
            
            DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 10, 10, 30, 30 }];
            [imageView setImageWithPath:pstrTitle];
            imageView.layer.cornerRadius = 15.0f;
            imageView.clipsToBounds = YES;
            imageView.layer.borderWidth = 3.0f;
            
            
            UILabel *labelName = [[UILabel alloc] init];
            labelName.font = [UIFont systemFontOfSize:13.0];
            labelName.text = name;
            [labelName setFrame:CGRectMake(50, 4, 150, 20)];
            
            
            UILabel *labelPingJia = [[UILabel alloc] init];
            labelPingJia.font = [UIFont systemFontOfSize:13.0];
            labelPingJia.text = pingjia;
            [labelPingJia setFrame:CGRectMake(50, 25, 150, 20)];
            
            
            UILabel *labelContent = [[UILabel alloc] init];
            labelContent.font = [UIFont systemFontOfSize:13.0];
            pContent = [pContent stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:pContent];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            [labelContent setFrame:CGRectMake(10, 60, rc.size.width, rc.size.height)];
            labelContent.numberOfLines = 0;
            labelContent.attributedText = AttributedStr;
            
            
            imageView.tag = -1;
            labelName.tag = -2;
            labelPingJia.tag = -3;
            labelContent.tag = -4;
            
            [cell addSubview:imageView];
            [cell addSubview:labelName];
            [cell addSubview:labelPingJia];
            [cell addSubview:labelContent];
        }
            break;
        default:
            break;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    Rowdata1* pdata = [_objects objectAtIndex:indexPath.row];
    switch (pdata.ntag) {
        case 10002:
        {
            
            /*
             NSString *ptmp = @"学习目的   \r";
             NSString *pstr1 = nil;
             if (dic) {
             pstr1 = [dic objectForKey:@"learningGoal"];
             }
             [ptmp stringByAppendingString:pstr1];
             ptmp = [[ptmp componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r"]] componentsJoinedByString:@""];
             NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:ptmp];
             */
            //以上处理boundingRectWithSize把\r当作普通字符计算的bug
            
            //目前测试boundingRectWithSize并无bug,可能已修复了
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"学习目的:   \r"];
            NSString *pstr1 = nil;
            if (dic) {
                pstr1 = [dic objectForKey:@"learningGoal"];
                pstr1 = [pstr1 stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
            }
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:pstr1];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            height = rc.size.height + 28;
        }
            break;
        case 40001:
        {
            NSDictionary *dic2 = [dic1 objectForKey:@"comment"];
            NSString *pstr1 = nil;
            if (dic2) {
                pstr1 = [dic2 objectForKey:@"remark"];
            }
            
            pstr1 = [pstr1 stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
            
            
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:pstr1];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            height = rc.size.height + 28 + 60; //头像是30x30
        }
            break;
        case 40002:
        {
            if(!_arr_pj)
            {
                return 40.0f;
            }
            
            NSDictionary *dictmp = nil;
            BOOL bfound = false;
            for (int i = 0; i < _arr_pj.count; i++) {
                dictmp = [_arr_pj objectAtIndex:i];
                NSNumber *nid = [dictmp objectForKey:@"id"];
                if (nid.integerValue == pdata.nID) {
                    bfound = true;
                    break;
                }
            }
            
            if (!bfound) {
                return  40.0f;
            }
            
            NSString *pstr1 = nil;
            if (dictmp) {
                pstr1 = [dictmp objectForKey:@"remark"];
            }
                
            pstr1 = [pstr1 stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:pstr1];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            height = rc.size.height + 28 + 60; //头像是30x30
            
        }
            break;
        default:
            height = 40.0f;
            break;
    }
    return height;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _objects.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    Rowdata1 *pdata = [_objects objectAtIndex:indexPath.row];
    if ([cell.reuseIdentifier isEqualToString:@"HaveDetail"]) {
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:pdata.NumofDetail];
        for (NSInteger i = 1; i <= pdata.NumofDetail; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:indexPath.section]];
        }
        
        
        if (pdata.isOpen) {
            NSRange ran = NSMakeRange(indexPath.row + 1, pdata.NumofDetail);
            [_objects removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:ran]];
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            
        }
        else
        {
            for (NSInteger i = 1; i <= pdata.NumofDetail; i++) {
                Rowdata1 *pdata1 = [Rowdata1 new];
                pdata1.ntag = pdata.mainRow * 10000 + i;
                [_objects insertObject:pdata1 atIndex:indexPath.row + i];
            }
            [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        pdata.isOpen = !pdata.isOpen;
    }
    else
    {
        if (pdata.ntag == 30001) {//点击了教师详情
            return;
        }
        
        if (pdata.ntag == 30003) {//点击了授课形式
            NSURL* url = [[NSURL alloc] initWithString:_url];
            [[ UIApplication sharedApplication] openURL:url];
            //    NSURL* url = [[NSURL alloc] initWithString:@"tel:110"];
            //    [[ UIApplication sharedApplication]openURL:url];
        }
        
        if (pdata.mainRow == 5) {//点击了查看全部评价,进行增加或则删除
            if (_ncount_pj <= 1) {
                return;
            }
            NSInteger ntmp = 0;
            if (bflag) {
                
                if (_ncount_pj <= 1) {
                    return;
                }
                
                if (_ncount_pj > 10) {
                    //添加10条评论,这个10是上限增加10,_ncount_pj是最大的上限
                    ntmp = 10;
                }
                else
                {
                    //添加余下的不足10条评论的上限
                    ntmp = _ncount_pj - 1;
                }
                
                
                NSString *ppingjia = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectSomeCourseForVIPByLIMITANdHql?commonStr=VIP&str=%ld&commonInt1=1&commonInt2=%ld",id_ke,ntmp];
                [tableView.tableFooterView setHidden:NO];
                UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(_tableView.bounds.size.width / 2 - 10, 5.0f, 20.0f, 20.0f)];
                [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                [tableFooterActivityIndicator startAnimating];
                [tableView.tableFooterView addSubview:tableFooterActivityIndicator];
                [tableView.tableFooterView setHidden:NO];
                if (!_arr_pj) {
                    _arr_pj = [[NSMutableArray alloc] init];
                }
                
                NSDictionary *dicll = [self GetJson:ppingjia];
                NSArray *arrtmp = nil;
                if (dicll) {
                    arrtmp = [dicll objectForKey:@"applys"];
                }
                [_arr_pj addObjectsFromArray:arrtmp];
                
                
                NSDictionary *dictmp = nil;
                if (!arrtmp) {
                    return;
                }

                
                NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:10];
                for (NSInteger i = 1; i <= ntmp; i++) {
                    [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:indexPath.section]];
                }
                
                for (NSInteger i = 1; i <= ntmp; i++) {
                    dictmp = [arrtmp objectAtIndex:i - 1];
                    if (!dictmp) {
                        break;
                    }
                    Rowdata1 *pdata1 = [Rowdata1 new];
                    NSNumber *nid = [dictmp objectForKey:@"id"];
                    pdata1.ntag = 40002;
                    pdata1.nID = nid.intValue;
                    [_objects insertObject:pdata1 atIndex:indexPath.row + i];
                }
                
                [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                
                
                
                
                [tableFooterActivityIndicator stopAnimating];
                [tableView.tableFooterView setHidden:YES];
                
                
                //_current_pj = ntmp;
                bflag = false;//关闭，只允许点击1次
             
            }
            
        }
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (bflag) {
        return;
    }
    
    CGPoint offset = scrollView.contentOffset;  // 当前滚动位移
    CGRect bounds = scrollView.bounds;          // UIScrollView 可视高度
    CGSize size = scrollView.contentSize;         // 滚动区域
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 10;
    if (y > (h + reload_distance)) {
        // 滚动到底部
        // ...
        NSInteger ntmp = _arr_pj.count;//当前的评论条数(除去第1条)
        NSInteger ncount = _ncount_pj - 1 - ntmp;//得到剩下的评论条数
        if (ncount > 0) {
            [_btn_addmore setHidden:NO];
            [_tableView.tableFooterView setHidden:YES];
        }
        else
        {
            [_btn_addmore setHidden:YES];
            [_tableView.tableFooterView setHidden:YES];
        }
    }
    
    
    
    
}


- (IBAction)addmore:(id)sender {
    NSInteger ntmp = _arr_pj.count;//当前的评论条数(除去第1条)
    NSInteger ncount = _ncount_pj - 1 - ntmp;//得到剩下的评论条数
    if (ncount > 10) {
        [_btn_addmore setHidden:YES];
        //插入并滑动到最后
        [_tableView.tableFooterView setHidden:NO];
        ncount =  10;
    }
    else
    {
        [_btn_addmore setHidden:YES];
        //插入并滑动到最后
    }
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:10];
    NSInteger nrows = _objects.count;
    for (NSInteger i = 0; i < ncount; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:nrows + i inSection:0]];
    }
    
    //请求
    NSString *ppingjia = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectSomeCourseForVIPByLIMITANdHql?commonStr=VIP&str=%ld&commonInt1=%ld&commonInt2=%ld",id_ke,ntmp + 1,ntmp + ncount];
    NSDictionary *dictmp1 = [self GetJson:ppingjia];
    NSArray *arrtmp = nil;
    if (dictmp1) {
        arrtmp = [dictmp1 objectForKey:@"applys"];
    }
    
    if (arrtmp) {
        [_arr_pj addObjectsFromArray:arrtmp];
    }
    
    NSDictionary *dictmp = nil;
    for (NSInteger i = 0; i < ncount; i++) {
        dictmp = [arrtmp objectAtIndex:i];
        if (!dictmp) {
            break;
        }
        Rowdata1 *pdata1 = [Rowdata1 new];
        NSNumber *nid = [dictmp objectForKey:@"id"];
        pdata1.ntag = 40002;
        pdata1.nID = nid.intValue;
        //[_objects insertObject:pdata1 atIndex:nrows + i];
        [_objects addObject:pdata1];
    }
    
    [_tableView.tableFooterView setHidden:YES];
    [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:nrows inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
