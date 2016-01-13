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
/*
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
*/
 
- (NSDictionary*)GetJson:(NSString *)Path
{
    NSString *ptmp = [Path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //解决中文问题
    //初始化网络路径。
    //初始化 url
    NSURL* url = [NSURL URLWithString:ptmp];
    if (url == nil) {
        return nil;
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //将请求到的字符串写到缓冲区。
    if (request == nil) {
        return nil;
    }
    
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (jsonData == nil) {
        return nil;
    }
    //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    /*
    //一下为自定义解析， 自己想怎么干就怎么干
    
    NSArray* arrayResult =[dic objectForKey:@"results"];
    NSDictionary* resultDic = [arrayResult objectAtIndex:0];
    NSDictionary* geometryDic = [resultDic objectForKey:@"geometry"];
    NSLog(@"geometryDic: %@,  resultDic:%@",geometryDic,resultDic);
    NSDictionary* locationDic = [geometryDic objectForKey:@"location"];
    NSNumber* lat = [locationDic objectForKey:@"lat"];
    NSNumber* lng = [locationDic objectForKey:@"lng"];
    NSLog(@"lat = %@, lng = %@",lat,lng);
     */
    return dic;
}
@end
