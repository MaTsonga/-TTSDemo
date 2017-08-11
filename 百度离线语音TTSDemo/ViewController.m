//
//  ViewController.m
//  百度离线语音TTSDemo
//
//  Created by 嘟嘟 on 2017/8/11.
//  Copyright © 2017年 MC. All rights reserved.

//App ID: 9995254
//API Key: 8ytDdOQg3T5qwCW6fgxPUs5z
//Secret Key: 129dd56fb617ba1ea55c2d9c1bf89f53

#import "ViewController.h"


@interface ViewController ()
<
    BDSSpeechSynthesizerDelegate
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置apiKey和secretKey
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"zVC2fnLK00BLUs8VILCmv16XSo5WjM1G" withSecretKey:@"S3Smz1kgzYNAg7P8uOFtG0pxY6W9eHPM"];
    
    // 合成参数设置 可根据需求自行修改
    ///女声
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:
     [NSNumber numberWithInt:BDS_SYNTHESIZER_SPEAKER_FEMALE]
                                                  forKey:BDS_SYNTHESIZER_PARAM_SPEAKER];
    ///音量 0 ~9
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithInt:9] forKey:BDS_SYNTHESIZER_PARAM_VOLUME];
    
    ///语速 0 ~9
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithInt:6] forKey:BDS_SYNTHESIZER_PARAM_SPEED];
    
    ///语调 0 ~9
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam: [NSNumber numberWithInt:5] forKey:BDS_SYNTHESIZER_PARAM_PITCH];
    ///mp3音质  压缩的16K
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:
     [NSNumber numberWithInt: BDS_SYNTHESIZER_AUDIO_ENCODE_MP3_16K]
                                                  forKey:BDS_SYNTHESIZER_PARAM_AUDIO_ENCODING ];
    
    // 设置离线引擎 App ID: 9901658
    NSString * offlineEngineSpeechData  = [[NSBundle mainBundle] pathForResource:@"Chinese_Speech_Female"      ofType:@"dat"];
    NSString * offlineEngineTextData    = [[NSBundle mainBundle] pathForResource:@"Chinese_Text"               ofType:@"dat"];
    NSString * offlineEngineLicenseFile = [[NSBundle mainBundle] pathForResource:@"offline_engine_tmp_license" ofType:@"dat"];
    
    NSString* offlineEngineEnglishSpeechData = [[NSBundle mainBundle] pathForResource:@"English_Speech_Female" ofType:@"dat"];
    NSString* offlineEngineEnglishTextData = [[NSBundle mainBundle] pathForResource:@"English_Text" ofType:@"dat"];
    
    NSError* err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineEngineTextData
                                                             speechDataPath:offlineEngineSpeechData
                                                            licenseFilePath:offlineEngineLicenseFile
                                                                withAppCode:@"9995254"];
    if(err){
        NSLog(@"汉语离线  ----errr   ");
        return;
    }
    err = [[BDSSpeechSynthesizer sharedInstance] loadEnglishDataForOfflineEngine:offlineEngineEnglishTextData speechData:offlineEngineEnglishSpeechData];
    if(err){
        NSLog(@"英语离线  ----errr   ");
        return;
    }
    
    // 获得合成器实例
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    // 设置委托对象
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    // 开始合成并播放
    NSError* speakError = nil;
    if([[BDSSpeechSynthesizer sharedInstance] speakSentence:@"语音好用了语音好用了语音好用了语音好用了语音好用了" withError:&speakError] == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
}

- (void)synthesizerStartWorkingSentence:(NSInteger)SynthesizeSentence
{
    NSLog(@"开始合成的句子 %zi", SynthesizeSentence);
}

- (void)synthesizerFinishWorkingSentence:(NSInteger)SynthesizeSentence
{
    NSLog(@"完成合成的句子 %zi", SynthesizeSentence);
}

- (void)synthesizerSpeechStartSentence:(NSInteger)SpeakSentence

{
    
    NSLog(@"开始播放语音 %zi", SpeakSentence);
    
}

- (void)synthesizerSpeechEndSentence:(NSInteger)SpeakSentence

{
    
    NSLog(@"结束播放语音 %zi", SpeakSentence);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
