//
//  ViewController.h
//  DemoFunnyGame
//
//  Created by ios12 on 5/4/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>
@property (nonatomic, strong)AVAudioPlayer *audioPlayer;
@property (nonatomic,strong)AVAudioPlayer *audioPlayerEndGame;
@end
