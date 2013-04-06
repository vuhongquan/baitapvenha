//
//  Game1.m
//  GameDemoImage
//
//hinh gia lap 3d  Created by ios12 on 4/5/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "Game1.h"
#import "Game2.h"
@interface Game1 ()
{
    UIButton * replay;
    UIView * _front;
    UIView * _game1;
    UIImageView *_anhnen1;
    UIImageView *_anh[8];
    UIView * _complete;
    UIView * _loseGame;
    UIImageView * _losegame;
    
    NSMutableArray *_game1ImageView;
    NSArray * _game1DataImageView;
    
    UILabel * _label1;
    UIButton * _nextRound;
    UIImageView * _anhChon1;
    UIImageView * _anhChon2;
    NSInteger  count;
    NSInteger  count1;
    UILabel * _labelA;
    NSInteger  timecount;
    NSTimer * time;
    NSTimer *time1;

    
    UIProgressView * progress;
    
    
    BOOL _isFrontFace;
    BOOL _isStart;
    BOOL isSelected;
}
#define khoangCach1 200
#define khoangCach 75
#define chieuRong 100
#define chieuDai 150
@end

@implementation Game1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    count = 8;
    _game1DataImageView = [NSMutableArray arrayWithArray:@[@"Unknown-2.jpeg",@"Unknown-2.jpeg",@"Unknown.jpeg",@"Unknown.jpeg",@"images-3.jpeg",@"images-3.jpeg",@"images-1.jpeg",@"images-1.jpeg"]];
    _game1ImageView = [NSMutableArray arrayWithArray: _game1DataImageView];
    
    for (int i=0;i<8; i++) {
        int randomNum = arc4random()% ([_game1ImageView count]);
        [_game1ImageView exchangeObjectAtIndex:randomNum withObjectAtIndex:([_game1ImageView count] -1 -i)];
    }
    _game1.hidden = YES;
    _isStart = NO;
    _anhChon1 = nil;
    _anhChon2 = nil;
    [self front1];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.audioPlayer stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) musicInGame{
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^(void) {
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        NSString *filePath = [mainBundle pathForResource:@"music1"
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
    });
}


-(void) front1{
    _front =[[UIView alloc]initWithFrame:CGRectMake(0,0, 768, 1040)];
    _front.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_front];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 60, 100)];
    _label1.center = self.view.center;
    _label1.backgroundColor = [UIColor clearColor];
    _label1.textColor = [UIColor yellowColor];
    _label1.font = [UIFont systemFontOfSize:100];
    
    [self.view addSubview:_label1];
    timecount = 3;
    time=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLabel) userInfo:Nil repeats:YES];
    [time fire];
}

- (void)refreshLabel{
    _label1.text = [NSString stringWithFormat:@"%d",timecount];
    if (timecount == 0) {
        [time invalidate];
        [self createView1];
        [self musicInGame];
    }
    timecount --;
    
}
-(void)losegame{
    _loseGame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _loseGame.backgroundColor = [UIColor clearColor];
    [_game1 addSubview:_loseGame];
    _losegame=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _losegame.image = [UIImage imageNamed:@"anh10.jpeg"];
    [_loseGame addSubview:_losegame];
    replay = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    replay.center = self.view.center;
    replay.font = [UIFont systemFontOfSize:50];
    [replay setTitle:@"Replay" forState:UIControlStateNormal];
    [replay addTarget:self action:@selector(createView1) forControlEvents:UIControlEventTouchUpInside];
    [_loseGame addSubview:replay];
}
-(void)refreshProgress{

    progress.progress = count1/50.0;
    count1--;
    if (count1==0) {
        [self losegame];
        [self.audioPlayer stop];
        [progress removeFromSuperview];
    }
}
- (void) createView1
{
    //Tao View
    _game1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _game1.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1.0];
    [self.view addSubview:_game1];
    
    count1=50.0;
    time1=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:Nil repeats:YES];
    [time1 fire];
    
    progress = [[UIProgressView alloc]initWithFrame:CGRectMake(10, 10, 400, 30)];
    progress.progressViewStyle = UIProgressViewStyleBar;
    progress.progress = 1;
    [self.view addSubview:progress];
    
    UITapGestureRecognizer * Tap[8];
    for (int k = 0; k < 8; k++) {
        _anh[k] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hinhcard.jpeg"]];
        _anh[k].tag = k;
        [_game1 addSubview:_anh[k]];
        _anh[k].userInteractionEnabled = YES;
        Tap[k] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip:)];
        [_anh[k] addGestureRecognizer:Tap[k]];
    }
    
    for (int i=0; i<4; i++){
        for(int j=0;j<2;j++){
            _anh[4*j+i].frame = CGRectMake(khoangCach*(i+1)+chieuRong*i,khoangCach1*(j+1)+chieuDai*j,chieuRong,chieuDai);
        }
    }
    
}

-(void) flip: (UITapGestureRecognizer *) gesture
{
    
    UIImageView *imageView = (UIImageView *)gesture.view;
    
    if (_anhChon1 && !_anhChon2) {
        if (_anhChon1 == imageView) {
            return;
        }
    }
    
    [UIView transitionWithView:imageView duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                           imageView.image = [UIImage imageNamed:_game1ImageView[imageView.tag]];
                       }
                    completion:^(BOOL finished){
                        if (!_anhChon1) {
                            _anhChon1 = imageView;
                            return;
                        }
                        if (_anhChon1 && !_anhChon2) {
                            _anhChon2 = imageView;

                        }
                        if (_anhChon1 && _anhChon2) {
                            if (_anhChon1.image == _anhChon2.image) {
                                NSLog(@"Dung");
                                [_anhChon1 removeFromSuperview];
                                [_anhChon2 removeFromSuperview];
                                count -=2;
                                if (count == 0) {
                                    [self endgame];
                                    [self.audioPlayer stop];
                                    [progress removeFromSuperview];
                                }
                            } else {
                                NSLog(@"Sai");
                                [UIView transitionWithView:_anhChon1 duration:0.5
                                                   options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                                       _anhChon1.image = [UIImage imageNamed:@"hinhcard.jpeg"];
                                                   }
                                                completion:^(BOOL finished){}];
                                
                                [UIView transitionWithView:_anhChon2 duration:0.5
                                                   options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                                       _anhChon2.image = [UIImage imageNamed:@"hinhcard.jpeg"];
                                                   }
                                                completion:^(BOOL finished){}];
                                
                            }
                            
                            _anhChon1 = nil;
                            _anhChon2 = nil;
                            return;
                        }
                    }];
    
}
-(void)endgame{
    
    _complete = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen1.image = [UIImage imageNamed:@"anh2.jpg"];
    _labelA = [[UILabel alloc]initWithFrame:CGRectMake(240, 200, 400, 300)];
    _labelA.backgroundColor = [UIColor clearColor];
    _labelA.text =@"GOOD JOB";
    _labelA.textColor = [UIColor yellowColor];
    _labelA.font = [UIFont systemFontOfSize:70];
    [_complete addSubview:_anhnen1];
    [_complete addSubview:_labelA];
    [_game1 addSubview:_complete];
    
    
    _nextRound = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _nextRound.frame = CGRectMake(325,500, 150, 50);
    [_nextRound addTarget:self action:@selector(GameView2) forControlEvents:UIControlEventTouchUpInside];
    [_nextRound setTitle:@"Next Level" forState:UIControlStateNormal];
    [_complete addSubview:_nextRound];
    
}
-(void)GameView2{
    Game2 * game2 = [[Game2 alloc]init];
    [self.navigationController pushViewController:game2 animated:YES];
}
@end
