//
//  NetMediaViewController.h
//  雅思英语
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeakPartViewController.h"
@interface NetMediaViewController : UIViewController
- (void)PlayMedia:(NSString*)moviePath;
- (void)PauseMedia;
@property (nonatomic,strong) NSString *moviePath;
@end
