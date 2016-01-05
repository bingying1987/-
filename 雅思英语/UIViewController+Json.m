//
//  UIViewController+Json.m
//  雅思英语
//
//  Created by mac on 16/1/5.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+Json.h"

@implementation UIViewController (MyJson)
- (NSDictionary*)GetJson:(NSString *)Path
{
    //初始化 url
    NSURL* url = [NSURL URLWithString:Path];
    //将文件内容读取到字符串中，注意编码NSUTF8StringEncoding 防止乱码，
    NSString* jsonString = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //将字符串写到缓冲区。
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    return dic;
}
@end
