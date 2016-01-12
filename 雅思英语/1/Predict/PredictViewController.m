//
//  PredictViewController.m
//  雅思英语
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PredictViewController.h"
#import "TableViewCell.h"
#import "DetailsViewController.h"
#import "PredictModel.h"

@interface PredictViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *PredictTableView;
@property (nonatomic, strong) UITableView *MemoriesTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *memoriesArr;
@property (nonatomic, copy) NSString *strUrl;
//图片前缀
@property (nonatomic, copy) NSString *picStr;
@end

@implementation PredictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self loadDataMemories];
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createView
{
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
//    self.navigationItem.title = @"考前预测";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"header_btn_xiaoxi@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    //设置文字颜色
    self.title = @"考前预测";
    self.navigationItem.title = self.title;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //背景色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.2 green:0.74 blue:0.38 alpha:1]];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImageView *segImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 50)];
    segImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    segImageView.userInteractionEnabled = YES;
    [self.view addSubview:segImageView];
    
    NSArray *segArr = @[@"考前预测",@"回忆解析"];
    self.segment = [[UISegmentedControl alloc]initWithItems:segArr];
    self.segment.frame = CGRectMake(80, 10, self.view.frame.size.width - 160, 30);
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor colorWithRed:0.2 green:0.74 blue:0.38 alpha:1];
    //未选中时的颜色
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    //设置控件上文字的颜色(选中时)
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.segment addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [segImageView addSubview:self.segment];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    self.PredictTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height)];
    self.PredictTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.PredictTableView.delegate = self;
    self.PredictTableView.dataSource = self;
    self.PredictTableView.showsHorizontalScrollIndicator = NO;
    self.PredictTableView.showsVerticalScrollIndicator = NO;
    self.PredictTableView.rowHeight = 215;
    [self.PredictTableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview:self.PredictTableView];
    
    self.MemoriesTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.scrollView.frame.size.height)];
    self.MemoriesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.MemoriesTableView.delegate = self;
    self.MemoriesTableView.dataSource = self;
    self.MemoriesTableView.showsHorizontalScrollIndicator = NO;
    self.MemoriesTableView.showsVerticalScrollIndicator = NO;
    self.MemoriesTableView.rowHeight = 215;
    [self.MemoriesTableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"ID"];
    [self.scrollView addSubview:self.MemoriesTableView];
}

//请求数据
-(void)loadData
{
    if (!self.dataArr) {
        self.dataArr = [[NSMutableArray alloc]init];
    }
        NSString *str = @"http://192.168.1.231:8080/YaSi_English/selectSomeArticleByHql?str=考前预测";
        NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.strUrl = str1;
    
    NSURL *URL = [NSURL URLWithString:self.strUrl];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"GET"];
        NSURLSession *session =[NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            if (data == nil) {
                return ;
            }else{
                NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                self.picStr = temp[@"basePath"];
                NSArray *arr = temp[@"articles"];
                for (NSDictionary *dic in arr) {
                    PredictModel *model = [[PredictModel alloc]init];
                    model.ID = dic[@"id"];
                    model.titile = dic[@"title"];
                    model.picLink = dic[@"cover_Address"];
                    model.content = dic[@"digest"];
                    model.detailContent = dic[@"detail"];
                    model.time = dic[@"releaseTime"];
                    [self.dataArr addObject:model];
                }
                    [self.PredictTableView reloadData];
            }
        }];
        //开始任务
        [task resume];
}

-(void)loadDataMemories
{
    if (!self.memoriesArr) {
        self.memoriesArr = [[NSMutableArray alloc]init];
    }
        NSString *str = @"http://192.168.1.231:8080/YaSi_English/selectSomeArticleByHql?str=回忆解析";
        NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.strUrl = str1;
    NSURL *URL = [NSURL URLWithString:self.strUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session =[NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data == nil) {
            return ;
        }else{
            NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.picStr = temp[@"basePath"];
            NSArray *arr = temp[@"articles"];
            for (NSDictionary *dic in arr) {
                PredictModel *model = [[PredictModel alloc]init];
                model.ID = dic[@"id"];
                model.titile = dic[@"title"];
                model.picLink = dic[@"cover_Address"];
                model.content = dic[@"digest"];
                model.detailContent = dic[@"detail"];
                model.time = dic[@"releaseTime"];
                [self.memoriesArr addObject:model];
            }
                [self.MemoriesTableView reloadData];
        }
    }];
    //开始任务
    [task resume];
}

//导航条按钮监听事件
-(void)backView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//segment监听事件
-(void)changeValue:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        [self.PredictTableView reloadData];
    }else{
        self.scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        [self.MemoriesTableView reloadData];
    }
}


#pragma mark---UITableViewDataSource,UITableViewDelegate

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.PredictTableView) {
        return self.dataArr.count;
    }else{
        return self.memoriesArr.count;
    }
    
}

//cell赋值
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.PredictTableView) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        PredictModel *model = (id)self.dataArr[indexPath.row];
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",self.picStr,model.picLink];
        [cell configWithTitle:model.titile andWithPic:strUrl andWithDesc:model.content andWithTime:model.time];
        return cell;
    }else{
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
        PredictModel *model = (id)self.memoriesArr[indexPath.row];
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",self.picStr,model.picLink];
        [cell configWithTitle:model.titile andWithPic:strUrl andWithDesc:model.content andWithTime:model.time];
        return cell;
    }
    
}

//当点击某一行的时候的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *dc = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:dc animated:YES];
    
    if (self.PredictTableView == tableView) {
        PredictModel *model = (id)self.dataArr[indexPath.row];
         dc.detailURL = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneAdministratorByArticleHql?str=%@",model.ID];
        dc.navName = @"考前预测详情";
        dc.name = model.titile;
        dc.time = model.time;
        dc.detailContent = model.detailContent;
        dc.picUrl = [NSString stringWithFormat:@"%@%@",self.picStr,model.picLink];
    }else{
        PredictModel *model = (id)self.memoriesArr[indexPath.row];
        dc.detailURL = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/selectOneAdministratorByArticleHql?str=%@",model.ID];
        dc.navName = @"回忆解析详情";
        dc.name = model.titile;
        dc.time = model.time;
        dc.detailContent = model.detailContent;
        dc.picUrl = [NSString stringWithFormat:@"%@%@",self.picStr,model.picLink];
    }
}

#pragma mark---UIScrollViewDelegate
//滚动视图减速结束（可以不用）
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前页的位置
    CGPoint contentOffSet = scrollView.contentOffset;
   int mainPage = contentOffSet.x / (scrollView.frame.size.width);
    if (mainPage == 0) {
        self.segment.selectedSegmentIndex = 0;
    }else{
        self.segment.selectedSegmentIndex = 1;
    }
}

@end
