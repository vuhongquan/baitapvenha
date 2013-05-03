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
    UISwitch *_mySwitch;
    UILabel * _scoreYouhave;
    UILabel * _score;
    UIButton * _replay;
    UIView * _front;
    UIView * _game1;
    UIImageView *_anhnen1;
    UIImageView *_anh[8];
    UIView * _complete;
    UIView * _loseGame;
    UIImageView * _losegame;
    
    NSMutableArray *_game1ImageView;
    NSArray * _game1DataImageView;
    
    UILabel * _point;
    UILabel * _label1;
    UIImageView * _anhChon1;
    UIImageView * _anhChon2;
    NSInteger  _count;
    NSInteger  _count1;
    UILabel * _labelA;
    NSInteger  _timecount;
    NSTimer * _time;
    NSTimer * _time1;
    NSInteger _count2;
    
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
    self.title = @"LEVEL 1";

    [_mySwitch setOn:NO];
    _mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_mySwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:_mySwitch];
    self.navigationItem.rightBarButtonItem= buttonItem;

    _count2 = 0;
    _count = 8;
    _point =[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 40)];
    _point.backgroundColor = [UIColor redColor];
    _point.textColor = [UIColor whiteColor];
    _point.text =[NSString stringWithFormat:@"%d",_count2];
    [_game1 addSubview:_point];
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
    _timecount = 3;
    _time=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLabel) userInfo:Nil repeats:YES];
    [_time fire];
}
- (void)refreshLabel{
    _label1.text = [NSString stringWithFormat:@"%d",_timecount];
    if (_timecount == 0) {
        [_time invalidate];
        [self createView1];
        [self musicInGame];
    }
    _timecount --;
    
}
-(void)losegame{
    _loseGame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _loseGame.backgroundColor = [UIColor clearColor];
   
    _losegame=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _losegame.image = [UIImage imageNamed:@"anh10.jpeg"];
    
    _replay = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    _replay.center = self.view.center;
    [_replay setTitle:@"Replay" forState:UIControlStateNormal];
    [_replay addTarget:self action:@selector(createView1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loseGame];
    [self.view addSubview:_losegame];
    [self.view addSubview:_replay];
}
-(void)refreshProgress{

    progress.progress = _count1/50.0;
    _count1--;
    if (_count1==0) {
        [self losegame];
        [_time1 invalidate];
        [progress removeFromSuperview];
        [self.audioPlayer stop];
    }
}
- (void) createView1
{
    //Tao View
    [self.audioPlayer play];
    _game1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _game1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_game1];
    _point =[[UILabel alloc]initWithFrame:CGRectMake(345,40, 200, 50)];
    _point.backgroundColor = [UIColor clearColor];
    _point.textColor = [UIColor whiteColor];
    _point.font = [UIFont systemFontOfSize:30];
    _point.text =[NSString stringWithFormat:@"Point: %d",_count2];
    [_game1 addSubview:_point];
    _count1=50.0;
    _time1=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:Nil repeats:YES];
    [_time1 fire];
    
    progress = [[UIProgressView alloc]initWithFrame:CGRectMake(25, 10, 715, 0)];
    progress.progressViewStyle = UIProgressViewStyleBar;
    progress.progress = 1;
    [self.view addSubview:progress];
    
    
    UITapGestureRecognizer * Tap[8];
    for (int k = 0; k < 8; k++) {
        _anh[k] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anhcard.jpg"]];
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
    
    [UIView transitionWithView:imageView duration:0.2
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
                                _count2 +=500;
                                _point.text =[NSString stringWithFormat:@"Point: %d",_count2];
                                _count -=2;
                                if (_count == 0) {
                                    [self endgame];
                                    [self.audioPlayer stop];
                                    [progress removeFromSuperview];
                                    [_time1 invalidate];
                                }
                            } else {
                                NSLog(@"Sai");
                                if (_count2 !=0) {
                                    _count2 -=10;
                                    _point.text =[NSString stringWithFormat:@"Point :%d",_count2];
                                }
                                [UIView transitionWithView:_anhChon1 duration:0.2
                                                   options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                                       _anhChon1.image = [UIImage imageNamed:@"anhcard.jpg"];
                                                   }
                                                completion:^(BOOL finished){}];
                                
                                [UIView transitionWithView:_anhChon2 duration:0.2
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
-(void)endgame{
    _complete = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen1.image = [UIImage imageNamed:@"anh2.jpg"];
    
    _labelA = [[UILabel alloc]initWithFrame:CGRectMake(230, 200, 400, 300)];
    _labelA.backgroundColor = [UIColor clearColor];
    _labelA.text =@"GOOD JOB";
    _labelA.textColor = [UIColor redColor];
    _labelA.font = [UIFont systemFontOfSize:70];
    
    _score = [[UILabel alloc]initWithFrame:CGRectMake(160,0,600, 200)];
    _score.backgroundColor = [UIColor clearColor];
    _score.text =@"You Have New Score";
    _score.textColor = [UIColor redColor];
    _score.font = [UIFont systemFontOfSize:50];
    
    _scoreYouhave = [[UILabel alloc]initWithFrame:CGRectMake(310,50,400, 200)];
    _scoreYouhave.backgroundColor = [UIColor clearColor];
    _scoreYouhave.text =[NSString stringWithFormat:@"%d",_count2];
    _scoreYouhave.textColor = [UIColor redColor];
    _scoreYouhave.font = [UIFont systemFontOfSize:60];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"NextRound" style:
                                              UIBarButtonItemStyleDone target:self action:@selector(GameView2)];
    [self.view addSubview:_scoreYouhave];
    [self.view addSubview:_score];
    [_complete addSubview:_anhnen1];
    [_complete addSubview:_labelA];
    [_game1 addSubview:_complete];

}
-(void)GameView2{
    Game2 * game2 = [[Game2 alloc]init];
    [self.navigationController pushViewController:game2 animated:YES];
}
@end
