//
//  UIViewController_UIViewController_Json.h
//  雅思英语
//
//  Created by mac on 16/1/5.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MyJson)
//- (NSDictionary*)GetJson:(NSString *)Path;//这个函数主要是服务器如果没开启时调用会异常
- (NSDictionary*)GetJson:(NSString *)Path;
@end