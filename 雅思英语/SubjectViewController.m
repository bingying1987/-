//
//  SubjectViewController.m
//  雅思英语
//
//  Created by mac on 16/1/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SubjectViewController.h"
#import "UIViewController+Json.h"

@interface RowSub : NSObject
@property (nonatomic) NSString *Title;
@property (nonatomic) NSString *SubMain;
@property (nonatomic) NSInteger nID;//仅评价时使用
@end

@implementation RowSub
@end


@interface SubjectViewController ()
{
    NSArray *imgArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btn_addmore;
@property (nonatomic) NSMutableArray *subarr;
@property (nonatomic) NSNumber *maxcount;
@end

@implementation SubjectViewController
@synthesize dic;
@synthesize itype;

- (void)initdata
{
    if (dic) {
        NSArray *arr1 = [dic objectForKey:@"talkTopicClassifications"];
        _subarr = [[NSMutableArray alloc] initWithArray:arr1];
        _maxcount = [dic objectForKey:@"total"];
    }
}

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
    
    UIImage *img1 = [UIImage imageNamed:@"sub_img1"];
    UIImage *img2 = [UIImage imageNamed:@"sub_img2"];
    UIImage *img3 = [UIImage imageNamed:@"sub_img3"];
    UIImage *img4 = [UIImage imageNamed:@"sub_img4"];
    UIImage *img5 = [UIImage imageNamed:@"sub_img5"];
    UIImage *img6 = [UIImage imageNamed:@"sub_img6"];
    UIImage *img7 = [UIImage imageNamed:@"sub_img7"];
    
    imgArray = @[img1,img2,img3,img4,img5,img6,img7];
    
    [self initdata];
    [self createFooterView];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NoDetail"];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_click:(id)sender {
    NSInteger ntmp = _subarr.count;//当前的评论条数(除去第1条)
    NSInteger ncount = _maxcount.integerValue - ntmp;//得到剩下的评论条数
    if (ncount > 20) {
        [_btn_addmore setHidden:YES];
        //插入并滑动到最后
        [_tableView.tableFooterView setHidden:NO];
        ncount =  20;
    }
    else
    {
        [_btn_addmore setHidden:YES];
        //插入并滑动到最后
    }
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:20];
    NSInteger nrows = _subarr.count;
    for (NSInteger i = 0; i < ncount; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:nrows + i inSection:0]];
    }
    
    NSString *ptmp = nil;
    ptmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectAllTalkTopicClassification_ForApp?commonStr=part%ld&commonInt1=%ld&commonInt2=%ld",itype + 1,nrows,ncount];
    
    
    NSDictionary *dictmp1 = [self GetJson:ptmp];
    NSArray *arrtmp = nil;
    if (dictmp1) {
        arrtmp = [dictmp1 objectForKey:@"talkTopicClassifications"];
    }
    
    if (arrtmp) {
        [_subarr addObjectsFromArray:arrtmp];
    }
    else
    {
        return;
    }
    
    
    [_tableView.tableFooterView setHidden:YES];
    [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:nrows inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    
    NSDictionary *dictmp = [_subarr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dictmp objectForKey:@"classifyName"];
    NSNumber *ptmp = [dictmp objectForKey:@"allLenB"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d题",ptmp.intValue];
    NSInteger index = indexPath.row % 7;
    cell.imageView.image = [imgArray objectAtIndex:index];
    
    UILabel *lb = (UILabel*)[cell viewWithTag:-1];
    if (lb) {
        lb.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    }
    else
    {
        CGRect rc = [cell.imageView frame];
        lb = [[UILabel alloc] initWithFrame:rc];
        [lb setTextColor:[UIColor whiteColor]];
        lb.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        lb.tag = -1;
        [cell.contentView addSubview:lb];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _subarr.count;
}
//滑动到最下面

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
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
        NSInteger ntmp = _subarr.count;//当前的评论条数(除去第1条)
        NSInteger ncount = _maxcount.integerValue - ntmp;//得到剩下的评论条数
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
    else
    {
        [_tableView.tableFooterView setHidden:YES];
        [_btn_addmore setHidden:YES];
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
