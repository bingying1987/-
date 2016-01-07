//
//  sideBarTableViewCell.m
//  雅思英语
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "sideBarTableViewCell.h"
#import "Masonry.h"

@implementation sideBarTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

-(void)createView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor colorWithRed:0.26 green:0.25 blue:0.25 alpha:1];
    imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    self.contentView.backgroundColor = [UIColor colorWithRed:0.26 green:0.25 blue:0.25 alpha:1];
    self.headImageView = [[UIImageView alloc]init];
    [imageView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_left).offset(50);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.equalTo(@25);
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [imageView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(20);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_centerY).offset(-10);
        make.height.equalTo(@20);
    }];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor whiteColor];
    [imageView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_bottom).offset(-1);
        make.height.equalTo(@1);
    }];
}

//赋值方法
-(void)configWith:(NSString *)imageName andWithName:(NSString *)name
{
    self.headImageView.image = [UIImage imageNamed:imageName];
    self.nameLabel.text = name;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
