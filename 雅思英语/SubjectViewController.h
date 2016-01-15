//
//  SubjectViewController.h
//  雅思英语
//
//  Created by mac on 16/1/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic) NSInteger itype;
@end
