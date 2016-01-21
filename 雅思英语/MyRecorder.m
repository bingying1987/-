//
//  MyRecorder.m
//  雅思英语
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "MyRecorder.h"
#import "DBImageViewCache.h"
#import "lame.h"
@implementation MyRecorder

- (void)StartRecording
{
    recordingEncoding = ENC_PCM;//默认使用这种格式
    audioRecorder = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
    if (recordingEncoding == ENC_PCM) {
        [recordSettings setObject:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
//        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
//        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    }
    else
    {
        NSNumber *formatObject;
        
        switch (recordingEncoding) {
            case (ENC_AAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatMPEG4AAC];
                break;
            case (ENC_ALAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleLossless];
                break;
            case (ENC_IMA4):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
                break;
            case (ENC_ILBC):
                formatObject = [NSNumber numberWithInt: kAudioFormatiLBC];
                break;
            case (ENC_ULAW):
                formatObject = [NSNumber numberWithInt: kAudioFormatULaw];
                break;
            default:
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
        }
        
        [recordSettings setObject:formatObject forKey: AVFormatIDKey];//ID
        [recordSettings setObject:[NSNumber numberWithFloat:44100] forKey: AVSampleRateKey];//采样率
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];//通道的数目,1单声道,2立体声
        [recordSettings setObject:[NSNumber numberWithInt:12800] forKey:AVEncoderBitRateKey];//解码率
        [recordSettings setObject:[NSNumber numberWithInt:8] forKey:AVLinearPCMBitDepthKey];//采样位
        [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityHigh] forKey: AVEncoderAudioQualityKey];
    }
    
    
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    
    dir = [dir stringByAppendingString:@"recordTest.caf"];
//    NSString *strtmp = [[NSBundle mainBundle] resourcePath];
//    NSString *ptmp = [strtmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

//    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", ptmp]];
    //因为我们的程序时中文名，导致url没转码
    NSURL *url = [NSURL fileURLWithPath:dir];
    
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
    
    if ([audioRecorder prepareToRecord] == YES){
        [audioRecorder record];
    }else {
        NSInteger errorCode = CFSwapInt32HostToBig ([error code]);
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
    }
    NSLog(@"recording");
}

- (NSString*)GetRecordFilePathMP3
{
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    
    dir = [dir stringByAppendingString:@"recordTest.mp3"];
    return dir;
}

- (void)StopRecording
{
    NSLog(@"stopRecording");
    [audioRecorder stop];
    NSLog(@"stopped");
    
    [self audio_PCMtoMP3];
}

- (NSString*)GetRecordFilePath
{
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    
    dir = [dir stringByAppendingString:@"recordTest.caf"];
    return dir;
}

-(void)PlayRecording
{
    NSLog(@"playRecording");
    // Init audio with playback capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
//    DBImageViewCache *pcache = [DBImageViewCache cache];
//    NSString *dir = [pcache localDirectory];
    
//    dir = [dir stringByAppendingString:@"recordTest.pcm"];
    
 //   NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
//    NSURL *url = [NSURL fileURLWithPath:dir];
    
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    dir = [dir stringByAppendingString:@"recordTest.caf"];
    NSURL *url = [NSURL fileURLWithPath:dir];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.volume = 1.0;
    audioPlayer.numberOfLoops = 0;
    if ([audioPlayer prepareToPlay]) {
        NSLog(@"can play");
        [audioPlayer play];
        sleep(3);
    }
    else
    {
        NSLog(@"can't play");
    }

}

- (void)PlayRecordingMP3
{
    NSLog(@"playRecordingMp3");
    // Init audio with playback capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    dir = [dir stringByAppendingString:@"recordTest.mp3"];
    NSURL *url = [NSURL fileURLWithPath:dir];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.volume = 1.0;
    audioPlayer.numberOfLoops = 0;
    if ([audioPlayer prepareToPlay]) {
        NSLog(@"can play");
        [audioPlayer play];
//        sleep(3);
    }
    else
    {
        NSLog(@"can't play");
    }

}


-(void)StopPlaying
{
    NSLog(@"stopPlaying");
    [audioPlayer stop];
    NSLog(@"stopped");
}



- (void)audio_PCMtoMP3
{
    DBImageViewCache *pcache = [DBImageViewCache cache];
    NSString *dir = [pcache localDirectory];
    dir = [dir stringByAppendingString:@"recordTest.mp3"];//输出文件mp3
    
    NSString *pfilesource = [self GetRecordFilePath];
    int nsizebegin = 0; //转换前大小
    int nsize = 0;//转换后大小
    @try {
        int read, write;
        
        FILE *pcm = fopen([pfilesource cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([dir cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        
        lame_set_num_channels(lame, 2);
        lame_set_in_samplerate(lame, 11025.0f);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            fwrite(mp3_buffer, write, 1, mp3);
            nsize += write;
            nsizebegin += read;
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        nsizebegin += 4096;
        NSLog(@"转换前大小%d",nsizebegin);
        NSLog(@"MP3生成成功,转换后大小%d!",nsize);
    }
    
}


@end
