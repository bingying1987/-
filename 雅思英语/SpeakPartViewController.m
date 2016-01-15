//
//  SpeakPartViewController.m
//  雅思英语
//
//  Created by mac on 16/1/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SpeakPartViewController.h"

@interface SpeakPartViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgmenu;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIImageView *imgmenu7;
@property (weak, nonatomic) IBOutlet UIView *view6;

@end

@implementation SpeakPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btclick:(UIButton *)sender {
    NSInteger itmp = sender.tag;
    NSString *ptmp = [NSString stringWithFormat:@"shuo0%ld",itmp];
    _imgmenu.image = [UIImage imageNamed:ptmp];
}

- (IBAction)btn7click:(UIButton *)sender {
    NSInteger itmp = sender.tag;
    NSString *ptmp = [NSString stringWithFormat:@"shuo7_0%ld",itmp];
    _imgmenu7.image = [UIImage imageNamed:ptmp];
}

- (IBAction)changeclick:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        [_view6 setHidden:YES];
    }
    else
    {
        [_view6 setHidden:NO];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
