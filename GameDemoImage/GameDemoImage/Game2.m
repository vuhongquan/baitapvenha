//
//  Game2.m
//  GameDemoImage
//
//  Created by ios12 on 4/5/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//
#import "Game2.h"
#import "Game3.h"
@interface Game2 ()
{
    UISwitch *_mySwitch;
    UIButton *replay;
    UIImageView * _losegame;
    UIView * _loseGame;
    UIProgressView *progress;
    UILabel* _label;
    UIView * _front;
    UIView * _game2;
    UIView * _complete;
    UIImageView * _anhnen2;
    UIImageView * _anh1[12];
    UIImageView * _anhChon1;
    UIImageView * _anhChon2;
    NSInteger  _counter;
    UILabel * _labalA;
    NSTimer * _timer;
    NSTimer * _timer2;
    NSInteger  _timecount;
    NSInteger _counter2;
    NSMutableArray *_game2ImageView;
    NSArray * _game2DataImageView;
    NSInteger _counter1;
    BOOL _isFrontFace;
    BOOL _isStart;
    BOOL isSelected;
}
#define khoangCach1 100
#define khoangCach 75
#define chieuRong 100
#define chieuDai 150
@end

@implementation Game2

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
    self.title = @"LEVEL 2";
    [_mySwitch setOn:NO];
    _mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_mySwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:_mySwitch];
    self.navigationItem.rightBarButtonItem= buttonItem;
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
            self.audioPlayer1 = [[AVAudioPlayer alloc] initWithData:fileData
                                                             error:&error];
            
            self.audioPlayer1.delegate = self;
            [self.audioPlayer1 prepareToPlay];
            [self.audioPlayer1 play];
            self.audioPlayer1.volume = 1;
        });
    }
- (void)viewDidDisappear:(BOOL)animated
{
    [self.audioPlayer1 stop];
}
- (void) switchIsChanged:(UISwitch *)soundChange{
    if ([_mySwitch isOn]) {
        [self.audioPlayer1 stop];
    } else {
        [self.audioPlayer1 play];
    }
}
-(void) front1{
    _front =[[UIView alloc]initWithFrame:CGRectMake(0,0, 768, 1040)];
    _front.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_front];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 60, 100)];
    _label.center = self.view.center;
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor yellowColor];
    _label.font = [UIFont systemFontOfSize:100];
    
    [_front addSubview:_label];
    _timecount = 3;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLabel1) userInfo:Nil repeats:YES];
    [_timer fire];
}
- (void)refreshLabel1{
    _label.text = [NSString stringWithFormat:@"%d",_timecount];
    if (_timecount == 0) {
        [_timer invalidate];
        [self createView2];
        [self musicInGame];
    }
    _timecount --;
}
-(void)losegame1{
    _loseGame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _loseGame.backgroundColor = [UIColor clearColor];
    [_game2 addSubview:_loseGame];
    _losegame=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _losegame.image = [UIImage imageNamed:@"anh10.jpeg"];
    [_loseGame addSubview:_losegame];
    replay = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 200)];
    replay.center = self.view.center;
    [replay addTarget:self action:@selector(createView2) forControlEvents:UIControlEventTouchUpInside];
    [_loseGame addSubview:replay];
}
-(void)refreshProgress1{
    progress.progress = _counter2/100.0;
    _counter2--;
    if (_counter2==0) {
        [progress removeFromSuperview];
        [self.audioPlayer1 stop];
        [_timer2 invalidate];
        [self losegame1];
    }
}
-(void)createView2{
    [self.audioPlayer1 play];
    _counter = 12;
    _game2DataImageView = [NSMutableArray arrayWithArray:@[@"Unknown-2.jpeg",@"Unknown-2.jpeg",@"Unknown.jpeg",@"Unknown.jpeg",@"images-3.jpeg",@"images-3.jpeg",@"images-1.jpeg",@"images-1.jpeg",@"anh4.jpg",@"anh4.jpg",@"anh3.jpg",@"anh3.jpg"]];
    _game2ImageView = [NSMutableArray arrayWithArray: _game2DataImageView];
    
    for (int i=0;i<12; i++) {
        int randomNum = arc4random()% ([_game2ImageView count]);
        [_game2ImageView exchangeObjectAtIndex:randomNum withObjectAtIndex:([_game2ImageView count] -1 -i)];
        for(int i = 12; i<[_game2ImageView count]; i++) {
        }
    }
    _game2.hidden =YES;
    _game2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _game2.backgroundColor = [UIColor  brownColor];
    [self.view addSubview:_game2];

    _counter2=100.0;
    _timer2=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress1) userInfo:Nil repeats:YES];
    [_timer2 fire];
    
    progress = [[UIProgressView alloc]initWithFrame:CGRectMake(25, 10, 715, 0)];
    progress.progressViewStyle = UIProgressViewStyleBar;
    progress.progress = 1;
    [self.view addSubview:progress];
    
    UITapGestureRecognizer * Tap[12];
    for (int k = 0; k < 12; k++) {
        _anh1[k] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anhcard.jpg"]];
        _anh1[k].tag = k;
        [_game2 addSubview:_anh1[k]];
        _anh1[k].userInteractionEnabled = YES;
        Tap[k] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip1:)];
        [_anh1[k] addGestureRecognizer:Tap[k]];
    }
    
    for (int i=0; i<4; i++){
        for(int j=0;j<3;j++){
            _anh1[4*j+i].frame = CGRectMake(khoangCach*(i+1)+chieuRong*i,khoangCach1*(j+1)+chieuDai*j,chieuRong,chieuDai);
        }
    }
    
}

-(void) flip1: (UITapGestureRecognizer *) gesture
{
    
    UIImageView *imageView1 = (UIImageView *)gesture.view;
    if (_anhChon1 && !_anhChon2) {
        if (_anhChon1 == imageView1) {
            return;
        }
    }
    
    [UIView transitionWithView:imageView1 duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                           imageView1.image = [UIImage imageNamed:_game2ImageView[imageView1.tag]];
                       }
                    completion:^(BOOL finished){
                        if (!_anhChon1) {
                            _anhChon1 = imageView1;
                            return;
                        }
                        if (_anhChon1 && !_anhChon2) {
                            _anhChon2 = imageView1;
                        }
                        if (_anhChon1 && _anhChon2) {
                            if (_anhChon1.image == _anhChon2.image) {
                                NSLog(@"Dung");
                                [_anhChon1 removeFromSuperview];
                                [_anhChon2 removeFromSuperview];
                                _counter -=2;
                                if (_counter == 0) {
                                    [self endgame1];
                                    [progress removeFromSuperview];
                                    [_timer2 invalidate];
                                    [self.audioPlayer1 stop];
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
    _anhnen2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen2.image = [UIImage imageNamed:@"anh5.jpg"];
    _labalA= [[UILabel alloc]initWithFrame:CGRectMake(240, 200, 400, 300)];
    _labalA.backgroundColor = [UIColor clearColor];
    _labalA.text =@"GOOD JOB";
    _labalA.textColor = [UIColor redColor];
    _labalA.font = [UIFont systemFontOfSize:70];
    

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"NextRound" style:UIBarButtonItemStyleDone target:self action:@selector(GameView3)];
    [_complete addSubview:_anhnen2];
    [_complete addSubview:_labalA];
    [_game2 addSubview:_complete];
    
}
-(void)GameView3{
    Game3 *game3 = [[Game3 alloc]init];
    [self.navigationController pushViewController:game3 animated:YES];
}
@end
