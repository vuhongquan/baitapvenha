//
//  ViewController.m
//  GameDemoImage
//
//  Created by ios12 on 4/4/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "ViewController.h"
#import "Game1.h"
#import "Game2.h"
#import "Game3.h"
@interface ViewController ()
{     UIButton * _soundon;
      UIButton * _soundoff;
      UIImageView * _anhnen;
      UIView * _home;
      UIButton * _startGame;
      UIButton * _loadGame;
      NSInteger  count;
      UISwitch * _mySwitch;

    BOOL _isFrontFace;
    BOOL _isStart;
    BOOL isSelected;
    
}
#define khoangCach1 100
#define khoangCach 75
#define chieuRong 100
#define chieuDai 150

@end

@implementation ViewController

- (void)viewDidLoad
{
    [_mySwitch setOn:NO];
    _mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_mySwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:_mySwitch];
    self.navigationItem.rightBarButtonItem= buttonItem;
    
    [super viewDidLoad];
    [self musicInGame];
    self.title = @"Game Image Demo";
    count = 8;
    //count1 = 12;
    _home =[[UIView alloc]initWithFrame:CGRectMake(0, 0,768,1004)];
    [self.view addSubview:_home];
    
    _anhnen = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1004)];
    _anhnen.image = [UIImage imageNamed:@"anhnen3.jpg"];
    [_home addSubview:_anhnen];
    
    //Tao nut Start
     _startGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     _startGame.frame = CGRectMake(300,600, 150, 60);
     _startGame.backgroundColor = [UIColor clearColor];
    [_startGame addTarget:self action:@selector(StartGame) forControlEvents:UIControlEventTouchUpInside];
    [_startGame setTitle:@"Start Game" forState:UIControlStateNormal];
    [_home addSubview:_startGame];
    
    //Tao nut Game Load
    _loadGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loadGame.frame =CGRectMake(300,700, 150, 60);
    [_loadGame addTarget:self action:@selector(viewAlert) forControlEvents:UIControlEventTouchUpInside];
    [_loadGame setTitle:@"Game Load" forState:UIControlStateNormal];
    [_home addSubview:_loadGame];
    
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.audioPlayer stop];
}
- (void) switchIsChanged:(UISwitch *)soundChange{
    if ([_mySwitch isOn]) {
        [self.audioPlayer stop];
    } else {
        [self.audioPlayer play];
    }
}

-(void) musicInGame{
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^(void) {
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        NSString *filePath = [mainBundle pathForResource:@"music3"
                                                  ofType:@"mp3"];
        
        NSData   *fileData = [NSData dataWithContentsOfFile:filePath];
        
        NSError  *error = nil;
        
        /* Start the audio player */
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData
                                                         error:&error];
        
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        self.audioPlayer.volume = 1;
        return;
    });
}


-(void)viewAlert{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Game load" message:@"level game" delegate:self cancelButtonTitle:@"Go" otherButtonTitles:NULL, nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *searchTextfield = [alertView textFieldAtIndex:0];
    NSString * keyWord = searchTextfield.text.lowercaseString;
    if ([keyWord isEqualToString:@"1"]) {
        Game1* game1 = [[Game1 alloc]init];
        [self.navigationController pushViewController:game1 animated:YES];
        [self.audioPlayer stop];
    }
    if ([keyWord isEqualToString:@"2"]) {
        Game2 *game2 = [[Game2 alloc]init];
        [self.navigationController pushViewController:game2 animated:YES];
        [self.audioPlayer stop];
    }
    if ([keyWord isEqualToString:@"3"]) {
        Game3 *game3 = [[Game3 alloc]init];
        [self.navigationController pushViewController:game3 animated:YES];
        [self.audioPlayer stop];
    }
}
-(void)StartGame{
    Game1 *game1 = [[Game1 alloc]init];
    [self.navigationController pushViewController:game1 animated:YES];
    [self.audioPlayer stop];
}
@end