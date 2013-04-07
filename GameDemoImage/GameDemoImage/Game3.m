//
//  Game3.m
//  GameDemoImage
//
//  Created by ios12 on 4/5/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "Game3.h"
#import "ViewController.h"
@interface Game3 ()
{
    UIButton * replay;
    UIView * _loseGame;
    UIImageView * _losegame;
    UIView * _front;
    UILabel * _labal;
    UIProgressView * progress;
    UIView * _game3;
    UIView * _complete;
    UIImageView * _anhnen3;
    UIImageView * _anh2[16];
    UIButton * _nextRound;
    UIImageView * _anhChon1;
    UIImageView * _anhChon2;
    NSInteger  count;
    UILabel * _labalA;
    NSInteger  count1;
    NSTimer  *time;
    NSTimer  *time1;
    NSInteger  timecount;
    NSMutableArray *_game3ImageView;
    NSArray * _game3DataImageView;
    
    BOOL _isFrontFace;
    BOOL _isStart;
    BOOL isSelected;
}
#define khoangCach1 60
#define khoangCach 75
#define chieuRong 100
#define chieuDai 150

@end

@implementation Game3

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
    self.title = @"LEVEL 3";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sound/on" style:UIBarButtonItemStyleDone target:self action:@selector(soundOn)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sound/off" style:UIBarButtonItemStyleDone target:self action:@selector(soundoff)];
    [super viewDidLoad];
    [self front1];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)musicInGame{
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^(void) {
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        NSString *filePath = [mainBundle pathForResource:@"music2"
                                                  ofType:@"mp3"];
        
        NSData   *fileData = [NSData dataWithContentsOfFile:filePath];
        
        NSError  *error = nil;
        
        /* Start the audio player */
        self.audioPlayer2 = [[AVAudioPlayer alloc] initWithData:fileData
                                                          error:&error];
        
        self.audioPlayer2.delegate = self;
        [self.audioPlayer2 prepareToPlay];
        [self.audioPlayer2 play];
        self.audioPlayer2.volume = 1;
    });
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.audioPlayer2 stop];
}
-(void) soundOn{
    [self.audioPlayer2 play];
}
-(void)soundoff{
    [self.audioPlayer2 stop];
}
-(void) front1{
    _front =[[UIView alloc]initWithFrame:CGRectMake(0,0, 768, 1040)];
    _front.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_front];
    
    _labal = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 60, 100)];
    _labal.center = self.view.center;
    _labal.backgroundColor = [UIColor clearColor];
    _labal.textColor = [UIColor yellowColor];
    _labal.font = [UIFont systemFontOfSize:100];
    
    [_front addSubview:_labal];
    timecount = 3;
    time=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLabel1) userInfo:Nil repeats:YES];
    [time fire];
}
- (void)refreshLabel1{
    _labal.text = [NSString stringWithFormat:@"%d",timecount];
    if (timecount == 0) {
        [time invalidate];
        [self createView3];
        [self musicInGame];
    }
    timecount --;
    
}
-(void)losegame{
    _loseGame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _loseGame.backgroundColor = [UIColor clearColor];
    [_game3 addSubview:_loseGame];
    _losegame=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _losegame.image = [UIImage imageNamed:@"anh10.jpeg"];
    [_loseGame addSubview:_losegame];
    replay = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 200)];
    replay.center = self.view.center;
    [replay addTarget:self action:@selector(createView3) forControlEvents:UIControlEventTouchUpInside];
    [_loseGame addSubview:replay];
}
-(void)refreshProgress1{
    progress.progress = count1/200.0;
    count1--;
    if (count1==0) {
        [progress removeFromSuperview];
        [self.audioPlayer2 stop];
        [time1 invalidate];
        [self losegame];
        
    }
}

-(void)createView3{
    [self.audioPlayer2 play];
    count =16;
    _game3DataImageView = [NSMutableArray arrayWithArray:@[@"Unknown-2.jpeg",@"Unknown-2.jpeg",@"Unknown.jpeg",@"Unknown.jpeg",@"images-3.jpeg",@"images-3.jpeg",@"images-1.jpeg",@"images-1.jpeg",@"anh4.jpg",@"anh4.jpg",@"anh3.jpg",@"anh3.jpg",@"anh6.jpg",@"anh6.jpg",@"anh7.jpg",@"anh7.jpg"]];
    _game3ImageView = [NSMutableArray arrayWithArray: _game3DataImageView];
    
    for (int i=0;i<16; i++) {
        int randomNum = arc4random()% ([_game3ImageView count]);
        [_game3ImageView exchangeObjectAtIndex:randomNum withObjectAtIndex:([_game3ImageView count] -1 -i)];
        for(int i = 16; i<[_game3ImageView count]; i++) {
        }
    }
    _game3.hidden =YES;
    _game3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _game3.backgroundColor = [UIColor  whiteColor];
    [self.view addSubview:_game3];
    
    
    count1=200.0;
    time1=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress1) userInfo:Nil repeats:YES];
    [time1 fire];
    
    progress = [[UIProgressView alloc]initWithFrame:CGRectMake(25, 10, 715, 0)];
    progress.progressViewStyle = UIProgressViewStyleBar;
    progress.progress = 1;
    [self.view addSubview:progress];
    
    UITapGestureRecognizer * Tap[16];
    for (int k = 0; k < 16; k++) {
        _anh2[k] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anhcard.jpg"]];
        _anh2[k].tag = k;
        [_game3 addSubview:_anh2[k]];
        _anh2[k].userInteractionEnabled = YES;
        Tap[k] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip1:)];
        [_anh2[k] addGestureRecognizer:Tap[k]];
    }
    
    for (int i=0; i<4; i++){
        for(int j=0;j<4;j++){
            _anh2[4*j+i].frame = CGRectMake(khoangCach*(i+1)+chieuRong*i,khoangCach1*(j+1)+chieuDai*j,chieuRong,chieuDai);
        }
    }
    
}

- (void)NextLevel:(id)sender {
    
    _isStart = !_isStart;
    if (_isStart) {
        _game3.hidden = NO;
        [_nextRound removeFromSuperview];
        
    } else {
        _game3.hidden = YES;
        [_nextRound setTitle:@"Next Round" forState:UIControlStateNormal];
    }
    
}
-(void) flip1: (UITapGestureRecognizer *) gesture
{
    
    UIImageView *imageView2 = (UIImageView *)gesture.view;
    if (_anhChon1 && !_anhChon2) {
        if (_anhChon1 == imageView2) {
            return;
        }
    }
    
    [UIView transitionWithView:imageView2 duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                           imageView2.image = [UIImage imageNamed:_game3ImageView[imageView2.tag]];
                       }
                    completion:^(BOOL finished){
                        if (!_anhChon1) {
                            _anhChon1 = imageView2;
                            return;
                        }
                        if (_anhChon1 && !_anhChon2) {
                            _anhChon2 = imageView2;
                        }
                        if (_anhChon1 && _anhChon2) {
                            if (_anhChon1.image == _anhChon2.image) {
                                NSLog(@"Dung");
                                [_anhChon1 removeFromSuperview];
                                [_anhChon2 removeFromSuperview];
                                count -=2;
                                if (count == 0) {
                                    [self endgame1];
                                    [time1 invalidate];
                                    [progress removeFromSuperview];
                                }
                            } else {
                                NSLog(@"Sai");
                                [UIView transitionWithView:_anhChon1 duration:0.5
                                                   options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                                       _anhChon1.image = [UIImage imageNamed:@"anhcard.jpg"];
                                                   }
                                                completion:^(BOOL finished){}];
                                
                                [UIView transitionWithView:_anhChon2 duration:0.5
                                                   options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                                       _anhChon2.image = [UIImage imageNamed:@"anhcard.jpg"];
                                                   }
                                                completion:^(BOOL finished){}];
                                
                            }
                            
                            _anhChon1 = nil;
                            _anhChon2 = nil;
                            return;
                        }
                    }];
    
}
-(void)endgame1{
    
    _complete = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen3.image = [UIImage imageNamed:@"cuongphoto.jpg"];
    _labalA= [[UILabel alloc]initWithFrame:CGRectMake(150, 200, 600, 300)];
    _labalA.backgroundColor = [UIColor clearColor];
    _labalA.text =@"SEE YOU LATER";
    _labalA.textColor = [UIColor redColor];
    _labalA.font = [UIFont systemFontOfSize:70];
    [_complete addSubview:_anhnen3];
    [_complete addSubview:_labalA];
    [_game3 addSubview:_complete];
    
    _nextRound = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _nextRound.frame = CGRectMake(325,500, 150, 50);
    [_nextRound addTarget:self action:@selector(gameView) forControlEvents:UIControlEventTouchUpInside];
    [_nextRound setTitle:@"COMPLETE" forState:UIControlStateNormal];
    [_complete addSubview:_nextRound];
    
}
-(void)gameView{
    ViewController * lastgame = [[ViewController alloc]init];
    [self.navigationController pushViewController:lastgame animated:YES];
}
@end
