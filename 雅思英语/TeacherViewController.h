//
//  TeacherViewController.h
//  雅思英语
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic) NSInteger id_teacher;
@end
