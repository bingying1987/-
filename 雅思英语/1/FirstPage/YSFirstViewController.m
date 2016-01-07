//
//  YSFirstViewController.m
//  雅思英语
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YSFirstViewController.h"
#import "CDRTranslucentSideBar.h"
#import "sideBarTableViewCell.h"
#import "Masonry.h"
#define CONTROL_TAG 100
#define BUTTON_TAG 100

@interface YSFirstViewController ()<CDRTranslucentSideBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UIImageView *comprehensiveImageView;
@end

@implementation YSFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"主页"];
    [self createView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


-(void)createView
{
    
    UIImageView *viewImage = [[UIImageView alloc]init];
    viewImage.image = [UIImage imageNamed:@"contents_bg@2x"];
    viewImage.userInteractionEnabled = YES;
    [self.view addSubview:viewImage];
    [viewImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"循循雅思";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(-40);
        make.right.equalTo(self.view.mas_centerX).offset(40);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.height.equalTo(@20);
    }];
    
    self.rightButton = [[UIButton alloc]init];
    [self.rightButton setTitle:@"个人中心" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rightButton addTarget:self action:@selector(gotoCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).offset(-80);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.height.equalTo(@20);
    }];
    
    //侧边栏
    self.sideBar = [[CDRTranslucentSideBar alloc]initWithDirection:YES];
    self.sideBar.delegate = self;
    self.sideBar.tag = 1;
    self.sideBar.sideBarWidth = self.view.frame.size.width / 2;
    self.sideBar.animationDuration = 1.0;
    self.sideBar.translucentStyle = UIBarStyleBlack;
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.backgroundColor = [UIColor colorWithRed:0.26 green:0.25 blue:0.25 alpha:1];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    //设置其分割线不显示
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[sideBarTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.sideBar setContentViewInSideBar:tableView];
    
    //侧边栏滑动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    //听说读写视图
    self.comprehensiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100,180 , 200, 180)];
    self.comprehensiveImageView.userInteractionEnabled = YES;
    self.comprehensiveImageView.image = [UIImage imageNamed:@"contents_shanxing@2x"];
    self.comprehensiveImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.comprehensiveImageView];
    
    CGFloat width = self.comprehensiveImageView.frame.size.width / 2;
    CGFloat height = self.comprehensiveImageView.frame.size.height / 2;
    NSArray *detailArr = @[@"contents_listening@2x",@"contents_speaking@2x (2)",@"contents_read@2x (2)",@"contents_write@2x (2)"];
    for (int i = 0; i < detailArr.count; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(width - 66 + i % 2 * 96, height - 60 + i / 2 * 85, 36, 34)];
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:detailArr[i]]];
        button.tag = BUTTON_TAG + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.comprehensiveImageView addSubview:button];
    }
    
    //中心视图
    UIImageView *centerView = [[UIImageView alloc]init];
    centerView.backgroundColor = [UIColor clearColor];
    centerView.layer.masksToBounds = YES;
    centerView.layer.cornerRadius = 45;
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comprehensiveImageView.mas_centerX).offset(-45);
        make.right.equalTo(self.comprehensiveImageView.mas_centerX).offset(45);
        make.top.equalTo(self.comprehensiveImageView.mas_centerY).offset(-51);
        make.height.equalTo(@90);
    }];
    NSArray *wordList = @[@"听",@"说",@"读",@"写"];
    for (int i = 0; i < wordList.count; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25 + i % 2 * 10 + i % 2 * 15, i / 2 * 30 + 25, 15, 15)];
        label.text = wordList[i];
        label.textColor = [UIColor colorWithRed:0 green:0.29 blue:0.37 alpha:1];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        [centerView addSubview:label];
    }
    
    UILabel *Hline = [[UILabel alloc]init];
    Hline.backgroundColor = [UIColor colorWithRed:0 green:0.29 blue:0.37 alpha:1];
    [centerView addSubview:Hline];
    [Hline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView.mas_centerX).offset(-30);
        make.right.equalTo(centerView.mas_centerX).offset(30);
        make.top.equalTo(centerView.mas_centerY).offset(2);
        make.height.equalTo(@1);
    }];
    
    UILabel *Vline = [[UILabel alloc]init];
    Vline.backgroundColor = [UIColor colorWithRed:0 green:0.29 blue:0.37 alpha:1];
    [centerView addSubview:Vline];
    [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView.mas_centerX).offset(-0.5);
        make.right.equalTo(centerView.mas_centerX).offset(0.5);
        make.top.equalTo(centerView.mas_centerY).offset(-28);
        make.height.equalTo(@58);
    }];
    
    //底部按钮
    NSArray *arrList = @[@"考前预测",@"发现之旅",@"VIP课程",@"个人中心"];
    NSArray *arrPic = @[@"tab_kaoqianyuce@2x",@"tab_faxian@2x",@"tab_vip@2x",@"tab_people@2x"];
    CGFloat size = (self.view.frame.size.width - 163) / 4;
    for (int i = 0 ; i < arrList.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30 + size * i + (i * 2) * 20 + i * 1, self.view.frame.size.height - 80, size - 15, 40)];
        imageView.image = [UIImage imageNamed:arrPic[i]];
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        
        if (i < 3) {
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake((i + 1) * self.view.frame.size.width / 4 + i * 1, self.view.frame.size.height - 80, 1, 80)];
            lineLabel.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:lineLabel];
        }
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + size * i + (i * 2) * 20 + i * 1, self.view.frame.size.height - 30, size + 20, 20)];
        titleLabel.text = arrList[i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:titleLabel];
        
        UIControl *bottomControl = [[UIControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4 * i, self.view.frame.size.height - 100, self.view.frame.size.width/4 - 1, 80)];
        bottomControl.tag = CONTROL_TAG + i;
        bottomControl.backgroundColor = [UIColor clearColor];
        [bottomControl addTarget:self action:@selector(gotoView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bottomControl];
    }
    
}

//个人中心按钮监听事件
-(void)gotoCenter
{
    NSLog(@"个人中心");
    [self.sideBar show];
}

//听说读写监听事件
-(void)buttonClick:(UIButton *)sender
{
    switch (sender.tag - BUTTON_TAG) {
        case 0:
        {
            NSLog(@"听");
            break;
        }
        case 1:
        {
            NSLog(@"说");
            break;
        }
        case 2:
        {
            NSLog(@"读");
            break;
        }
        case 3:
        {
            NSLog(@"写");
            break;
        }
        default:
            break;
    }
}

//底部视图监听事件
-(void)gotoView:(UIControl *)sender
{
    NSLog(@"1");
    [self.navigationController setNavigationBarHidden:NO];
    switch (sender.tag - CONTROL_TAG) {
        case 0:
        {
            NSLog(@"考前预测");
            break;
        }
          case 1:
        {
            NSLog(@"发现之旅");
            break;
        }
            case 2:
        {
            NSLog(@"VIP");
            UIViewController *ptmp = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"vipView"];
            [self.navigationController pushViewController:ptmp animated:YES];
            
            
            break;
        }
            case 3:
        {
            NSLog(@"个人中心");
            [self.sideBar show];
            break;
        }
        default:
            break;
    }
}

//手势监听事件
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
            self.sideBar.isCurrentPanGestureTarget = YES;
    }
    
    [self.sideBar handlePanGestureToShow:recognizer inView:self.view];
} 

#pragma mark---UITabelView协议
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

//设置段头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

//段头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *headerView = [[UIImageView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:0.26 green:0.25 blue:0.25 alpha:1];
    headerView.userInteractionEnabled = YES;
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 30;
    self.imageView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(20);
        make.right.equalTo(headerView.mas_left).offset(80);
        make.top.equalTo(headerView.mas_top).offset(60);
        make.height.equalTo(@60);
    }];
    
    self.nickNameLabel = [[UILabel alloc]init];
    self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
    self.nickNameLabel.textColor = [UIColor whiteColor];
    self.nickNameLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.right.equalTo(headerView.mas_right).offset(-20);
        make.top.equalTo(self.imageView.mas_top).offset(10);
        make.height.equalTo(@20);
    }];
    return headerView;
}

//创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *picArr = @[@"list_gerenziliao@2x",@"list_rengongfuwu@2x",@"list_vip@2x",@"list_shengciben@2x",@"list_cuotiji@2x",@"list_nanduwenzhang@2x",@"list_yuyinguangchang@2x",@"1"];
    NSArray *nameArr = @[@"个人资料",@"人工服务",@"我的vip课程",@"生词本",@"错题集",@"难度文章",@"语音广场",@"返回首页"];
    sideBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell configWith:picArr[indexPath.row] andWithName:nameArr[indexPath.row]];
    return cell;
}

//点击某一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"000");
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
        case 4:
        {
            break;
        }
        case 5:
        {
            break;
        }
        case 6:
        {
            break;
        }
        case 7:
        {
            break;
        }
        case 8:
        {
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
