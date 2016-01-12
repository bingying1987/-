//
//  TableViewCell.h
//  雅思英语
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *timeLabel;

//赋值
//-(void)configWithTitle:(NSString *)title andWithPic:(NSData *)picData andWithDesc:(NSString *)desc andWithTime:(NSString *)time;

-(void)configWithTitle:(NSString *)title andWithPic:(NSString *)picData andWithDesc:(NSString *)desc andWithTime:(NSString *)time;

@end
