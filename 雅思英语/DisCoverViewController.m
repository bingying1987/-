//
//  DisCoverViewController.m
//  雅思英语
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "DisCoverViewController.h"
#import "MyRecorder.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
@interface DisCoverViewController ()
{
    NSTimer *tSpeak;
    int tick;
    BOOL bspeak6;
}

@property (weak, nonatomic) IBOutlet UITextField *title1;
@property (weak, nonatomic) IBOutlet UITextView *textContent;

@end

@implementation DisCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerfire:(NSTimer*)timer
{
    MyRecorder *recoder = [MyRecorder recorder];
    if (tick > 30) {
        tick = 0;
        [tSpeak invalidate];
        tSpeak = nil;
        //停止录音
        [recoder StopRecording];
        bspeak6 = true;
    }
    tick++;
}


- (IBAction)beginSpeak:(UIButton *)sender {
    if (tSpeak) {
        [tSpeak invalidate];
        tSpeak = nil;
    }
    
    MyRecorder *recoder = [MyRecorder recorder];
    //开始录音
    bspeak6 = false;
    [recoder StartRecording];
    tick = 0;
    tSpeak = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerfire:) userInfo:nil repeats:YES];
}

- (IBAction)endSpeak:(UIButton *)sender {
    if (tSpeak) {
        [tSpeak invalidate];
        tSpeak = nil;
    }
    
    MyRecorder *recoder = [MyRecorder recorder];
    bspeak6 = true;
    [recoder StopRecording];
}


- (IBAction)subjectQuestion:(id)sender {
    if (bspeak6) {
        //上传
        //     [recoder PlayRecordingMP3];
        
        AppDelegate *papp = [[UIApplication sharedApplication] delegate];
        NSString *pnum = papp.ph_num;
        pnum = @"13886445784";
        MyRecorder *recoder = [MyRecorder recorder];
        NSString *strFile = [recoder GetRecordFilePathMP3];
        NSString *strtmp = [NSString stringWithFormat:@"http://192.168.1.231:8080/YaSi_English/saveOneGeneralProblem?str=%@&problem.title=%@&problem.quizContent=%@",pnum,_title1.text,_textContent.text];
        
        NSString *ptmp = [strtmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:ptmp];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setFile:strFile forKey:@"upload"];
        [request startSynchronous];
        if ([request complete]) {
            
            UIAlertView *msgView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传语音成功" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [msgView   show];
        }
        else
        {
            UIAlertView *msgView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传语音失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [msgView   show];
        }
        
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
