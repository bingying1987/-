//
//  TableViewCell.m
//  雅思英语
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@implementation TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

-(void)createView
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.equalTo(@20);
    }];
    
    self.picImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.picImageView];
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_left).offset(120);
        make.top.equalTo(self.contentView.mas_top).offset(50);
        make.height.equalTo(@100);
    }];
    
    self.descLabel = [[UILabel alloc]init];
    self.descLabel.numberOfLines = 0;
    self.descLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.descLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView.mas_right).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.picImageView.mas_top);
        make.height.equalTo(@100);
    }];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.picImageView.mas_bottom).offset(20);
        make.height.equalTo(@1);
    }];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_left).offset(150);
        make.top.equalTo(lineLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
    }];
    
    UILabel *bottomLine = [[UILabel alloc]init];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.height.equalTo(@4);
    }];
}

//赋值测试
-(void)configWithTitle:(NSString *)title andWithPic:(NSString *)picData andWithDesc:(NSString *)desc andWithTime:(NSString *)time
{
    self.titleLabel.text = title;
    //图片请求
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picData]];
    self.descLabel.text = desc;
    self.timeLabel.text = time;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
