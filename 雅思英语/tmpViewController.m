//
//  tmpViewController.m
//  雅思英语
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "tmpViewController.h"
#import "MyRecorder.h"
@interface tmpViewController ()
{
    MyRecorder *recoder;
}
@end

@implementation tmpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.M
    recoder = [[MyRecorder alloc] init];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)luyinbegin:(id)sender {
    [recoder StartRecording];
}

- (IBAction)luyin:(id)sender {
    [recoder StopRecording];
}

- (IBAction)play:(id)sender {
    [recoder PlayRecording];
}

- (IBAction)playsec:(id)sender {
    [recoder PlayRecordingMP3];
}

- (IBAction)textclick:(id)sender {
    
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"hello!,大兄弟word need you,need you,need you,need you,it's you 10个大兄弟"];  //需要转换的文本
    utterance.voice = voice;
    utterance.rate *= 0.1;
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc]init];
    [av speakUtterance:utterance];
//    sleep(1);
//    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
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
