//
//  PredictModel.h
//  雅思英语
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PredictModel : NSObject
//图片地址前缀
@property (nonatomic, copy) NSString *basePath;
//id
@property (nonatomic, copy) NSString *ID;
//标题
@property (nonatomic, copy) NSString *titile;
//图片
@property (nonatomic, copy) NSString *picLink;
//简介内容
@property (nonatomic, copy) NSString *content;
//上传时间
@property (nonatomic, copy) NSString *time;
//详情页标题
@property (nonatomic, copy) NSString *detailTitle;
//头像
@property (nonatomic, copy) NSString *headPic;
//昵称
@property (nonatomic, copy) NSString *nickName;
//时间
@property (nonatomic, copy) NSString *detailTime;
//内容
@property (nonatomic, copy) NSString *detailContent;
//详细页面图片
@property (nonatomic, copy) NSString *detailPic;
@end
