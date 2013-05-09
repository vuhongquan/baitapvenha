//
//  ViewController.m
//  DemoFunnyGame
//
//  Created by ios12 on 5/4/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *_arrayFruit;
    UIView *_viewGame;
    UIView *_viewGame1;
    NSTimer *_timerViewRotateGame1;
    NSTimer *_timerViewRotateGame;
    NSUInteger times;
    NSUInteger times1;
    UIImageView *_imageView;
    UIImageView*_imageView1;
    UIButton *_buttonStartGame;
    NSTimer *_timerCountGame;
    float count;
    float counttime;
    float a;
    float b;
    int pointWin;
    UILabel * labelPoint;
    NSArray *_arrayCount;
    NSArray *_arrayCount1;
    NSMutableArray *_arrayCountTime;
    NSMutableArray *_arrayCountTime1;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _arrayFruit = @[@"Pear.png",@"Orange.png",@"teachers_day.png",@"Apricot.png",@"Strawberry.png",@"Lime.png",@"Banana.png",@"Coconut.png"];
        _arrayCount = @[[NSNumber numberWithFloat:0.1],[NSNumber numberWithFloat:0.02],[NSNumber numberWithFloat:0.03],[NSNumber numberWithFloat:0.04]];
        _arrayCount1 = @[[NSNumber numberWithFloat:0.01],[NSNumber numberWithFloat:0.04],[NSNumber numberWithFloat:0.06],[NSNumber numberWithFloat:0.07]];
        _arrayCountTime = [NSMutableArray arrayWithArray:_arrayCount];
        _arrayCountTime1 = [NSMutableArray arrayWithArray:_arrayCount1];
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        NSString *filePath = [mainBundle pathForResource:[NSString stringWithFormat:@"1"]
                                                  ofType:@"mp3"];
        
        NSData   *fileData = [NSData dataWithContentsOfFile:filePath];
        
        NSError  *error = nil;
        
        /* Start the audio player */
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData
                                                         error:&error];
        
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        self.audioPlayer.volume = 1;
        
        

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    labelPoint = [[UILabel alloc]init];
    labelPoint.frame = CGRectMake(100,40,200,40);
    labelPoint.text = [NSString stringWithFormat:@"Tien:%d.000 VND",pointWin];
    [self.view addSubview:labelPoint];
    
    _buttonStartGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonStartGame.frame = CGRectMake(110,20,100, 30);
    [_buttonStartGame setTitle:@"PlayGame" forState:UIControlStateNormal];
    [_buttonStartGame addTarget:self action:@selector(rotateViewGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonStartGame];
    [self createView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)count{
       count--;
    
    if (count==0) {
        [self.view addSubview:_buttonStartGame];
        
        NSLog(@"%d",(times + times1)%8);
        NSLog(@"time : %d",times);
        NSLog(@"time1 : %d",times1);
        if ((times + times1)%8 == 0) {
            NSLog(@"dung");
            pointWin += 400.000;
            labelPoint.text = [NSString stringWithFormat:@"Tien:%d VND",pointWin];
        }
        
        
        NSBundle *mainBundle1 = [NSBundle mainBundle];
        
        NSString *filePath1 = [mainBundle1 pathForResource:[NSString stringWithFormat:@"2"]
                                                    ofType:@"mp3"];
        
        NSData   *fileData1 = [NSData dataWithContentsOfFile:filePath1];
        
        NSError  *error1 = nil;
        
        /* Start the audio player */
        self.audioPlayerEndGame = [[AVAudioPlayer alloc] initWithData:fileData1
                                                                error:&error1];
        
        self.audioPlayerEndGame.delegate = self;
        [self.audioPlayerEndGame prepareToPlay];
        self.audioPlayerEndGame.volume = 1;
        
        
        [_timerViewRotateGame invalidate];
        [_timerViewRotateGame1 invalidate];
        [_timerCountGame invalidate];
        [self.audioPlayerEndGame stop];
        [self.audioPlayer play];

    }
}
-(void)rotateViewGame{
    [_buttonStartGame removeFromSuperview];
    times = 0;
    times1= 0;
    count  =2;
    _timerCountGame = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
    for (int i=0;i<4; i++) {
        int randomNum = arc4random()% ([_arrayCountTime count]);
        [_arrayCountTime exchangeObjectAtIndex:randomNum withObjectAtIndex:([_arrayCountTime count] -1 -i)];
        a = [_arrayCountTime[i] floatValue];
    }
    for (int i=0;i<4; i++) {
        int randomNum = arc4random()% ([_arrayCountTime1 count]);
        [_arrayCountTime1 exchangeObjectAtIndex:randomNum withObjectAtIndex:([_arrayCountTime1 count] -1 -i)];
        b = [_arrayCountTime1[i] floatValue];
    }
    
        _timerViewRotateGame1 =[NSTimer scheduledTimerWithTimeInterval:a
                                                   target:self
                                                   selector:@selector(rotateView1)
                                                   userInfo:nil
                                                   repeats:YES];
    _timerViewRotateGame =[NSTimer scheduledTimerWithTimeInterval:b
                                                     target:self
                                                     selector:@selector(rotateView)
                                                     userInfo:nil
                                                     repeats:YES];
}
-(void)createView{
    _viewGame = [[UIView alloc]initWithFrame:CGRectMake(10,100,300,300)];
    [self.view addSubview:_viewGame];
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Untitled.png"]];
    _imageView.frame = CGRectMake(0,0, 300,300);
    [_viewGame addSubview:_imageView];
    for (int i = 0; i<[_arrayFruit count]; i++) {
        UIImageView *imageGame = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",_arrayFruit[i]]]];
        if (i<=1) {
        imageGame.frame = CGRectMake(130+i*80,10+i*40,40,40);
        }
        if (i==2) {
            imageGame.frame = CGRectMake(250,130,40,40);
        }
        if (i==3) {
            imageGame.frame = CGRectMake(210,215,40,40);
        }
        if (i==4) {
            imageGame.frame = CGRectMake(130,250,40,40);
        }
        if (i==5) {
            imageGame.frame = CGRectMake(43, 215,40,40);
        }
        if (i==6) {
            imageGame.frame = CGRectMake(10, 125,40,40);
        }
        if (i==7) {
            imageGame.frame =CGRectMake(45, 45,40,40);
        }
        imageGame.transform = CGAffineTransformMakeRotation(i*M_PI/4);
        [_imageView addSubview:imageGame];
    }

    _viewGame1 = [[UIView alloc]initWithFrame:CGRectMake(60,150,200,200)];
    [self.view addSubview:_viewGame1];
    _imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Untitled.png"]];
    _imageView1.frame = CGRectMake(0,0,200,200);
    [_viewGame1 addSubview:_imageView1];
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"images.png"]];
    imageView1.frame = CGRectMake(0,87, 320,320);
    [self.view addSubview:imageView1];
    for (int i = 0; i<[_arrayFruit count]; i++) {
        UIImageView *imageGame = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",_arrayFruit[i]]]];
        if (i<=1) {
            imageGame.frame = CGRectMake(80+i*50,10+i*25,40,40);
        }
        if (i==2) {
            imageGame.frame = CGRectMake(155,85, 40, 40);
        }
        if (i==3) {
            imageGame.frame = CGRectMake(130,135, 40, 40);
        }
        if (i==4) {
            imageGame.frame = CGRectMake(80, 155, 40, 40);
        }
        if (i==5) {
            imageGame.frame = CGRectMake(30, 135, 40, 40);
        }
        if (i==6) {
            imageGame.frame = CGRectMake(5, 80, 40, 40);
        }
        if (i==7) {
            imageGame.frame = CGRectMake(25,30, 40, 40);
        }
        imageGame.transform = CGAffineTransformMakeRotation(i*M_PI/4);
        [_imageView1 addSubview:imageGame];
    }
}
-(void)rotateView{
    times++;
    _viewGame.transform=CGAffineTransformMakeRotation(M_PI/4*times);
    
    [self.audioPlayerEndGame play];
}
-(void)rotateView1{
    times1++;
    _viewGame1.transform=CGAffineTransformMakeRotation(-M_PI/4*times1);
    
}
@end
