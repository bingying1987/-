//
//  NetMediaViewController.m
//  雅思英语
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "NetMediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface NetMediaViewController ()
{
    BOOL bflag;
}
@property (nonatomic,strong) MPMoviePlayerController *moviePlayerController;
@end


@implementation NetMediaViewController

- (void)PlayMedia:(NSString *)moviePath
{
    [self initMoviePlayer];
    NSURL *theMovieURL = [NSURL fileURLWithPath:moviePath];
    [_moviePlayerController setContentURL:theMovieURL];
    [_moviePlayerController prepareToPlay];
    [_moviePlayerController play];
}

- (void)PauseMedia
{
    [_moviePlayerController pause];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason integerValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            //自动播放下一个
        {
  //          [_moviePlayerController pause];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"error1");
            break;
        case MPMovieFinishReasonUserExited:
            NSLog(@"error2");
            break;
        default:
            break;
    }
}

- (void)initMoviePlayer
{
    if (_moviePlayerController) {
        return;//已经初始化了
    }
    MPMoviePlayerController *PlayerController = [[MPMoviePlayerController alloc] init];
    _moviePlayerController = PlayerController;
    
    if (!_moviePlayerController) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayerController];
    
    
    [_moviePlayerController setMovieSourceType:MPMovieSourceTypeFile];
    
    _moviePlayerController.scalingMode = MPMovieScalingModeFill;
    _moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
    _moviePlayerController.backgroundView.backgroundColor = [UIColor blackColor];
    _moviePlayerController.repeatMode = MPMovieRepeatModeNone;
    CGRect rc = [self.view bounds];
    [_moviePlayerController.view setFrame:rc];
    [self.view addSubview:[_moviePlayerController view]];
    if (_moviePath) {
        NSURL* url = [NSURL URLWithString:_moviePath];
        [_moviePlayerController setContentURL:url];
        [_moviePlayerController prepareToPlay];
        [_moviePlayerController play];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self initMoviePlayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
