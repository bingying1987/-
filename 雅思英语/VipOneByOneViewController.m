//
//  VipPublicDetailViewController.m
//  雅思英语
//
//  Created by mac on 16/1/6.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "VipOneByOneViewController.h"
#import "DBImageView.h"

@interface Rowdata1 : NSObject
@property (nonatomic) NSString *Title;
@property (nonatomic) BOOL bHaveDetail;
@property (nonatomic) NSInteger NumofDetail;//子cell的个数
@property (nonatomic) BOOL isOpen;
@property (nonatomic) NSInteger ntag;
@property (nonatomic) NSInteger mainRow;
@property (nonatomic) NSInteger subRow;
@end


@interface VipOneByOneViewController ()
@property NSMutableArray *objects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *titleImg;
@property (nonatomic,weak) NSDictionary *dic;
@property (nonatomic)NSString *url;
@property (nonatomic)NSInteger ncount_pj;
@property (nonatomic)NSInteger current_pj;
@end




@implementation Rowdata1

@end

@implementation VipOneByOneViewController
@synthesize dic1;
@synthesize dic;


- (void)viewDidLoad {
    [super viewDidLoad];
    if (dic1 == nil) {
        return;
    }
    dic = [dic1 objectForKey:@"courseForVIP"];
    
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NoDetail"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HaveDetail"];
    
    
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
        pstrtail = [dic objectForKey:@"course_Address"];
    }
    pstrTitle = [pstrTitle stringByAppendingString:pstrtail];
    DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 0, 0, _titleImg.bounds.size.width, _titleImg.bounds.size.height }];
    [imageView setImageWithPath:pstrTitle];
    [_titleImg addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn_click:(id)sender
{
    //申请报名
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"NoDetail" forIndexPath:indexPath];
    }
    
    
    
    switch (pdata.ntag) {
        case 0:
        {
            if (pdata.mainRow == 4) {//课程评价
                NSString *pstr1 = @"课程评价   ";
                NSString *pstr2 = nil;
                
                NSNumber *pnum = nil;
                if (dic) {
                    pnum = [dic objectForKey:@"maxTotal"];
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
            cell.textLabel.text = pstr1;
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
            if (dic) {
                pstrTitle = [dic1 objectForKey:@"basePath"];
                pstrtail = [dic objectForKey:@"course_Address"];
            }
            pstrTitle = [pstrTitle stringByAppendingString:pstrtail];
            DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 10, 10, 30, 30 }];
            [imageView setImageWithPath:pstrTitle];
            imageView.layer.cornerRadius = 15.0f;
            imageView.clipsToBounds = YES;
            imageView.layer.borderWidth = 3.0f;
            
            
            NSString *name = [dic objectForKey:@"name"];
            UILabel *labelName = [[UILabel alloc] init];
            labelName.font = [UIFont systemFontOfSize:13.0];
            labelName.text = name;
            [labelName setFrame:CGRectMake(50, 10, 150, 20)];
            
            NSString *pingjia = [dic objectForKey:@"pingjia"];
            UILabel *labelPingJia = [[UILabel alloc] init];
            labelPingJia.font = [UIFont systemFontOfSize:13.0];
            labelPingJia.text = pingjia;
            [labelPingJia setFrame:CGRectMake(50, 40, 150, 20)];
            
            
            UILabel *labelContent = [[UILabel alloc] init];
            labelContent.font = [UIFont systemFontOfSize:13.0];
            NSString *pContent = [dic objectForKey:@"11"];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:pContent];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            [labelContent setFrame:CGRectMake(10, 70, rc.size.width, rc.size.height)];
            labelContent.numberOfLines = 0;
            labelContent.attributedText = AttributedStr;
            
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
            NSString *pstr1 = nil;
            if (dic) {
                pstr1 = [dic objectForKey:@"learningGoal"];
            }
            
            pstr1 = [[pstr1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r"]] componentsJoinedByString:@""];
            
            
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:pstr1];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            height = rc.size.height + 28 + 80; //头像是30x30
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
        if (pdata.ntag == 30003) {//点击了授课形式
            NSURL* url = [[NSURL alloc] initWithString:_url];
            [[ UIApplication sharedApplication] openURL:url];
            //    NSURL* url = [[NSURL alloc] initWithString:@"tel:110"];
            //    [[ UIApplication sharedApplication]openURL:url];
        }
        
        if (pdata.mainRow == 5) {//点击了查看全部评价,进行增加或则删除
            static bool bflag = true;//可以添加状态
            NSInteger nRows = _objects.count;
            NSInteger ntmp = 0;
            if (bflag) {
                if (_current_pj + 10 <= _ncount_pj) {
                    //添加10条评论
                    ntmp = 10;
                }
                else
                {
                    //添加余下的不足10条评论
                    ntmp = _ncount_pj - _current_pj;
                }
                NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:10];
                for (NSInteger i = 1; i <= ntmp; i++) {
                    [indexPaths addObject:[NSIndexPath indexPathForRow:nRows + i inSection:indexPath.section]];
                }
                
                for (NSInteger i = 1; i <= ntmp; i++) {
                    Rowdata1 *pdata1 = [Rowdata1 new];
                    pdata1.ntag = 40001;
                    [_objects insertObject:pdata1 atIndex:indexPath.row + i];
                }
                _current_pj = ntmp;
                bflag = false;
            }
            
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
