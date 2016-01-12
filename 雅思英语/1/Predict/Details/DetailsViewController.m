//
//  DetailsViewController.m
//  雅思英语
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailsViewController.h"
#import "YSFirstViewController.h"
#import "UIImageView+WebCache.h"
#import "PredictModel.h"

@interface DetailsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *headPicUrl;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self createView];
}

-(void)createView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.title = self.navName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"header_btn_xiaoxi@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackFirst)];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 20)];
    self.titleLabel.text = self.name;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, self.view.frame.size.width - 40, 1)];
   lineLabel.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    [self.scrollView addSubview:lineLabel];
    
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 61, 60, 60)];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    self.headImageView.layer.cornerRadius = 30;
    self.headImageView.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.headImageView];
    
    self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 66, 150, 15)];
    self.nickLabel.textAlignment = NSTextAlignmentLeft;
    self.nickLabel.textColor = [UIColor colorWithRed:0.2 green:0.74 blue:0.38 alpha:1];
    self.nickLabel.font = [UIFont systemFontOfSize:15];
    [self.scrollView addSubview:self.nickLabel];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 91, 150, 15)];
    self.timeLabel.text = self.time;
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = [UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:1];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [self.scrollView addSubview:self.timeLabel];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.text = self.detailContent;
    NSLog(@"self.contentLabel.text == %@",self.contentLabel.text);
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    CGSize Size = [self.detailContent boundingRectWithSize:CGSizeMake(self.mainView.frame.size.width - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    NSString *size = [NSString stringWithFormat:@"%@",NSStringFromCGSize(Size)];
    int height = [size intValue];
    self.contentLabel.frame = CGRectMake(20, 131, self.view.frame.size.width - 40, height);
    [self.scrollView addSubview:self.contentLabel];
    
    self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(75, 151 + height, self.view.frame.size.width - 150, 150)];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:self.picUrl]];
    NSLog(@"self.picUrl == %@",self.picUrl);
    [self.scrollView addSubview:self.picImageView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 291 + height);
}

-(void)loadData
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (!self.dataArr) {
            self.dataArr = [[NSMutableArray alloc]init];
        }
        NSString *strUrl = self.detailURL;
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"GET"];
        NSURLSession *session =[NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (data == nil) {
                return ;
            }else{
                NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                self.headPicUrl = temp[@"basePath"];
                PredictModel *model = [[PredictModel alloc]init];
                 model.headPic = temp[@"portraits"];
                NSDictionary *userDic = temp[@"article"];
                model.nickName = userDic[@"whoIssue"];
                [self.dataArr addObject:model];
            }
        }];
        //开始任务
        [task resume];
    });
   
}

//返回上一级菜单
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//返回首页
-(void)goBackFirst
{
    YSFirstViewController *yc = [[YSFirstViewController alloc]init];
    [self presentViewController:yc animated:YES completion:nil];
}

//设置头像和昵称
-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PredictModel *model = [(id)self.dataArr firstObject];
    self.nickLabel.text = model.nickName;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",self.headPicUrl,model.headPic]]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
