//
//  VipPublicDetailViewController.h
//  雅思英语
//
//  Created by mac on 16/1/6.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Rowdata : NSObject
@property (nonatomic) NSString *Title;
@property (nonatomic) BOOL bHaveDetail;
@property (nonatomic) NSInteger NumofDetail;//子cell的个数
@property (nonatomic) BOOL isOpen;
@property (nonatomic) NSInteger ntag;
@property (nonatomic) NSInteger mainRow;
@property (nonatomic) NSInteger subRow;
@end

@interface VipPublicDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDictionary *dic1;
@end
