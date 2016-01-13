//
//  TeacherViewController.m
//  雅思英语
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "TeacherViewController.h"
#import "DBImageView.h"

@interface Rowdata2 : NSObject
@property (nonatomic) NSString *Title;
@property (nonatomic) BOOL bHaveDetail;
@property (nonatomic) NSInteger NumofDetail;//子cell的个数
@property (nonatomic) BOOL isOpen;
@property (nonatomic) NSInteger ntag;
@property (nonatomic) NSInteger mainRow;
@property (nonatomic) NSInteger subRow;
@end

@implementation Rowdata2
@end


@interface TeacherViewController ()
@property NSMutableArray *objects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *titleImg;
@end

@implementation TeacherViewController
@synthesize dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *strName,*strSex,*strSchoolAge,*strEducation,*strProfessionalTitle,*strMember;
    
    if (!dic) {
        return;
    }
    NSDictionary *dictmp = [dic objectForKey:@"teacher"];
    
    if (dictmp) {
        strName = [dictmp objectForKey:@"name"];
        strSex = [dictmp objectForKey:@"sex"];
        strSchoolAge = [dictmp objectForKey:@"school_age"];
        strEducation = [dictmp objectForKey:@"education"];
        strProfessionalTitle = [dictmp objectForKey:@"lecturer"];
        NSNumber *num = [dictmp objectForKey:@"trainP_Number"];
        strMember = [NSString stringWithFormat:@"%ld人",num.integerValue];
    }
    
    
    
    
    
    Rowdata2 *pRow1 = [Rowdata2 new];
    pRow1.Title = [NSString stringWithFormat:@"姓名:     %@",strName];
    pRow1.mainRow = 0;
    Rowdata2 *pRow2 = [Rowdata2 new];
    pRow2.Title = [NSString stringWithFormat:@"性别:     %@",strSex];
    pRow2.mainRow = 1;
    Rowdata2 *pRow3 = [Rowdata2 new];
    pRow3.Title = [NSString stringWithFormat:@"教龄:     %@",strSchoolAge];
    pRow3.mainRow = 2;
    Rowdata2 *pRow4 = [Rowdata2 new];
    pRow4.Title = [NSString stringWithFormat:@"学历:     %@",strEducation];
    pRow4.mainRow = 3;
    Rowdata2 *pRow5 = [Rowdata2 new];
    pRow5.Title = [NSString stringWithFormat:@"职称:     %@",strProfessionalTitle];
    pRow5.mainRow = 4;
    Rowdata2 *pRow6 = [Rowdata2 new];
    pRow6.Title = [NSString stringWithFormat:@"已培训学员:     %@",strMember];
    pRow6.mainRow = 5;
    
    _objects = [[NSMutableArray alloc] init];
    [_objects addObjectsFromArray:@[pRow1,pRow2,pRow3,pRow4,pRow5,pRow6]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NoDetail"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *pstrTitle = nil;
    NSString *pstrtail = nil;
    if (dic) {
        pstrTitle = [dic objectForKey:@"basePath"];
        NSDictionary *dictmp = [dic objectForKey:@"teacher"];
        pstrtail = [dictmp objectForKey:@"detail_image_text"];
    }
    pstrTitle = [pstrTitle stringByAppendingString:pstrtail];
    DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 0, 0, _titleImg.bounds.size.width, _titleImg.bounds.size.height }];
    [imageView setImageWithPath:pstrTitle];
    [_titleImg addSubview:imageView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"NoDetail" forIndexPath:indexPath];
    Rowdata2* pdata = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = pdata.Title;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
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
