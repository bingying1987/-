//
//  DetailsViewController.h
//  雅思英语
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
//详细页内容地址
@property (nonatomic, copy) NSString *detailURL;
//导航条标题
@property (nonatomic, copy) NSString *navName;
//文章标题
@property (nonatomic, copy) NSString *name;
//文章详细内容
@property (nonatomic, copy) NSString *detailContent;
//文章发表时间
@property (nonatomic, copy) NSString *time;
//文章图片地址
@property (nonatomic, copy) NSString *picUrl;

@end
