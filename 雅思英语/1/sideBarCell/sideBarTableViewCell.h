//
//  sideBarTableViewCell.h
//  雅思英语
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sideBarTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;

//赋值
-(void)configWith:(NSString *)imageName andWithName:(NSString *)name;

@end
