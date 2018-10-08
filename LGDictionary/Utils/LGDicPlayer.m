//
//  DLGPlayer.m
//  LGDicDemo
//
//  Created by 刘亚军 on 2018/4/4.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "LGDictionaryConst.h"

@interface LGDicPlayer ()
@property (nonatomic,strong) AVPlayer *player;
@end
@implementation LGDicPlayer
+ (LGDicPlayer *)shareInstance{
    static LGDicPlayer * macro = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        macro = [[LGDicPlayer alloc]init];
    });
    return macro;
}
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)applicationDidEnterBackground:(NSNotification *) noti{
    [self stop];
}
- (void)handleEndTimeNotification:(NSNotification *) noti{
    [[NSNotificationCenter defaultCenter] postNotificationName:LGDictionaryPlayerDidFinishPlayNotification object:nil];
}
- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)startPlayWithUrl:(NSString *)url{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
    [session setActive:YES error:nil];
    [self removeNotification];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    [self.player replaceCurrentItemWithPlayerItem:currentItem];
     [self addNotification];
}
- (void)play{
    [self.player play];
}
- (void)stop{
    [self.player pause];
    self.player = nil;
     [[NSNotificationCenter defaultCenter] postNotificationName:LGDictionaryPlayerDidFinishPlayNotification object:nil];
    [self removeNotification];
}
- (AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
        _player.volume = 1.0;
    }
    return _player;
}

@end
