//
//  VipPublicDetailViewController.m
//  雅思英语
//
//  Created by mac on 16/1/6.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "VipOneByOneViewController.h"

@interface VipOneByOneViewController ()
@property NSMutableArray *objects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


@interface Rowdata1 : NSObject
@property (nonatomic) NSString *Title;
@property (nonatomic) BOOL bHaveDetail;
@property (nonatomic) NSInteger NumofDetail;//子cell的个数
@property (nonatomic) BOOL isOpen;
@property (nonatomic) NSInteger ntag;
@property (nonatomic) NSInteger mainRow;
@property (nonatomic) NSInteger subRow;
@end


@implementation Rowdata1
@end

@implementation VipOneByOneViewController
@synthesize dic;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NoDetail"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HaveDetail"];
    
    Rowdata1 *pRow1 = [Rowdata1 new];
    pRow1.Title = @"考验英语词汇熟词生义大串讲";
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
    
    _objects = [[NSMutableArray alloc] init];
    [_objects addObjectsFromArray:@[pRow1,pRow2,pRow3,pRow4]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            cell.textLabel.text = pdata.Title;
            cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        }
            break;
        case 10001:
        {
            NSLog(@"2");
            cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"适合人群:   "];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:@"需要升华的考研党们"];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            cell.textLabel.attributedText = AttributedStr;
            
        }
            break;
        case 10002:
        {
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"学习目的:   \r\n"];
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:@"在原考研英语词汇串讲的基础上,抽取同学们容易混淆的70个有生义的熟词进行讲解."];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
            
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.attributedText = AttributedStr;
        }
            break;
        case 30001:
        {
            cell.textLabel.text = @"吕浩民老师";
        }
            break;
        case 30002:
        {
            cell.textLabel.text = @"每晚20:00开播";
        }
            break;
        case 30003:
        {
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"在线授课:"];
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
    Rowdata1* pdata = [_objects objectAtIndex:indexPath.row];
    switch (pdata.ntag) {
        case 10002:
        {
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"学习目的:   \r\n"];
            NSAttributedString *ptnp = [[NSAttributedString alloc] initWithString:@"在原考研英语词汇串讲的基础上,抽取同学们容易混淆的70个有生义的熟词进行讲解."];
            [AttributedStr appendAttributedString:ptnp];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0 , AttributedStr.length)];
            CGRect rc = [AttributedStr boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            height = rc.size.height + 28;
        }
            break;
        default:
            height = 26.0f;
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
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"HaveDetail"]) {
        Rowdata1 *pdata = [_objects objectAtIndex:indexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:pdata.NumofDetail];
        for (NSInteger i = 1; i <= pdata.NumofDetail; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:indexPath.section]];
        }
        
        
        if (pdata.isOpen) {
            NSRange ran = NSMakeRange(indexPath.row + 1, pdata.NumofDetail);
            [_objects removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:ran]];
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

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
