//
//  MyRecorder.h
//  雅思英语
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MyRecorder : NSObject
{
    //-----这部分是实用AVAudioRecorder录音
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    int recordingEncoding;
    enum
    {
        ENC_AAC = 1,
        ENC_ALAC = 2,
        ENC_IMA4 = 3,
        ENC_ILBC = 4,
        ENC_ULAW = 5,
        ENC_PCM = 6
    }encodingTypes;
    //------
}
+ (instancetype) recorder;
- (void)StartRecording;//录音并使用lame转成mp3
- (void)StopRecording;
- (void)PlayRecording;//播放的是转换前的pcm格式
- (void)PlayRecordingMP3;//播放mp3
- (void)PlayFile:(NSString *)filePath;
- (void)StopPlaying;
- (NSString*)GetRecordFilePath;
- (NSString*)GetRecordFilePathMP3;
@end
