//
//  VipPublicDetailViewController.m
//  雅思英语
//
//  Created by mac on 16/1/6.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "VipPublicDetailViewController.h"
#import "DBImageView.h"
@interface VipPublicDetailViewController ()
@property NSMutableArray *objects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *titleImg;
@property (nonatomic,weak) NSDictionary *dic;
@property (nonatomic)NSString *url;
@end




@implementation Rowdata

@end

@implementation VipPublicDetailViewController
@synthesize dic1;
@synthesize dic;


- (void)viewDidLoad {
    [super viewDidLoad];
    if (dic1 == nil) {
        return;
    }
    dic = [dic1 objectForKey:@"courseForOpen"];
    
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NoDetail"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HaveDetail"];
    
    
    NSString *pstrtail = nil;
    if (dic) {
        pstrtail = [dic objectForKey:@"course_Name"];
        _url = [dic objectForKey:@"class_place"];
    }
    
    Rowdata *pRow1 = [Rowdata new];
    pRow1.Title = pstrtail;
    pRow1.mainRow = 0;
    Rowdata *pRow2 = [Rowdata new];
    pRow2.Title = @"课程描述";
    pRow2.bHaveDetail = YES;
    pRow2.NumofDetail = 2;
    pRow2.mainRow = 1;
    Rowdata *pRow3 = [Rowdata new];
    pRow3.Title = @"课程图文详情";
    pRow3.bHaveDetail = YES;
    pRow3.NumofDetail = 0;
    pRow3.mainRow = 2;
    Rowdata *pRow4 = [Rowdata new];
    pRow4.Title = @"课程信息";
    pRow4.bHaveDetail = YES;
    pRow4.NumofDetail = 3;
    pRow4.mainRow = 3;
    
    _objects = [[NSMutableArray alloc] init];
    [_objects addObjectsFromArray:@[pRow1,pRow2,pRow3,pRow4]];
    
    
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    Rowdata* pdata = [_objects objectAtIndex:indexPath.row];
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
            cell.textLabel.text = pdata.Title;
            cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
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
            }
            
//            pstr1 = [pstr1 stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\r"];
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
                pstr1 = [dic objectForKey:@"class_time"];
            }

            cell.textLabel.text = pstr1;
        }
            break;
        case 30003:
        {
            NSString *pstr1 = nil;
            if (dic) {
                pstr1 = [dic objectForKey:@"class_shape"];
            }
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:pstr1];
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:@"   （支持手机观看）"];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(8, AttributedStr.length - 8)];
            cell.textLabel.attributedText = AttributedStr;
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
    Rowdata* pdata = [_objects objectAtIndex:indexPath.row];
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
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"学习目的:   \r"];
            
            NSString *pstr1 = nil;
           
            if (dic) {
                pstr1 = [dic objectForKey:@"learningGoal"];
            }
            
            
            
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:pstr1];
            [AttributedStr appendAttributedString:ptnp];
            
            
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            height = rc.size.height + 28;
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
    Rowdata *pdata = [_objects objectAtIndex:indexPath.row];
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
                Rowdata *pdata1 = [Rowdata new];
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
