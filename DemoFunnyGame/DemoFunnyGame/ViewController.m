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
    UIAlertView *_theEnd;
    UIAlertView *_alertLoseGame;
    UIImageView *imageView1;
    UIButton *_textPoint;
    UIButton *_textPoint1;
    UIButton *_textPoint2;
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
    UILabel *_labalPointHave;
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
    UILabel *_buttonPoint;
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
    pointWin = 1500000;
    
    UIImageView *imageTheme = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    imageTheme.frame = self.view.bounds;
    [self.view addSubview:imageTheme];
    _buttonPoint = [[UILabel alloc]init];
    _buttonPoint.frame = CGRectMake(0, 10,40,50);
    _buttonPoint.numberOfLines = 2;
    
    _alertLoseGame = [[UIAlertView alloc]initWithTitle:@"Warring" message:@"So tien con lai cua ban khong du choi moi ban nap them tien" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
    [_alertLoseGame setAlertViewStyle:UIAlertViewStyleDefault];
    
    _theEnd = [[UIAlertView alloc]initWithTitle:@"Good Job" message:@"Ban nap tien thanh cong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [_theEnd setAlertViewStyle:UIAlertViewStyleDefault];
    
    _textPoint = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _textPoint.frame = CGRectMake(60, 10,120,25);
    _textPoint.backgroundColor = [UIColor clearColor];
    [_textPoint setTitle:@"1.500.000 VND" forState:UIControlStateNormal];
    [_textPoint addTarget:self action:@selector(NapTien1) forControlEvents:UIControlEventTouchUpInside];
    
    _textPoint1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _textPoint1.frame = CGRectMake(190, 10,120,25);
     _textPoint1.backgroundColor = [UIColor clearColor];
    [_textPoint1 setTitle:@"2.500.000 VND" forState:UIControlStateNormal];
    [_textPoint1 addTarget:self action:@selector(NapTien2) forControlEvents:UIControlEventTouchUpInside];
    
    _textPoint2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _textPoint2.frame = CGRectMake(120,40,120,25);
     _textPoint2.backgroundColor = [UIColor clearColor];
    [_textPoint2 setTitle:@"3.500.000 VND" forState:UIControlStateNormal];
    [_textPoint2 addTarget:self action:@selector(NapTien3) forControlEvents:UIControlEventTouchUpInside];
    
    labelPoint = [[UILabel alloc]init];
    labelPoint.frame = CGRectMake(90,70,200,20);
    labelPoint.textColor = [UIColor redColor];
    labelPoint.backgroundColor = [UIColor clearColor];
    _labalPointHave = [[UILabel alloc]init];
    _labalPointHave.frame = CGRectMake(10,10,200,20);
    _labalPointHave.textColor=[UIColor redColor];
    _labalPointHave.backgroundColor = [UIColor clearColor];
    _labalPointHave.text = [NSString stringWithFormat:@"So tien:%d VND",pointWin];
    [self.view addSubview:_labalPointHave];
    _buttonStartGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonStartGame.frame = CGRectMake(110,40,100, 30);
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
            [self.audioPlayer play];
            NSLog(@"dung");
            pointWin += 800000;
            labelPoint.text = [NSString stringWithFormat:@"Tien duoc:800.000 VND"];
            _labalPointHave.text = [NSString stringWithFormat:@"So tien:%d VND",pointWin];
            [self.view addSubview:labelPoint];
        }else{
            pointWin -= 400000;
            labelPoint.text = [NSString stringWithFormat:@"Tien mat:-400.000 VND"];
            _labalPointHave.text = [NSString stringWithFormat:@"So tien:%d VND",pointWin];
            [self.view addSubview:labelPoint];
        }
        if (pointWin<=300000) {
            [self.view addSubview:_textPoint];
            [self.view addSubview:_textPoint1];
            [self.view addSubview:_textPoint2];
            [_alertLoseGame show];
            _buttonPoint.text = @"Nap Tien:";
            _buttonPoint.backgroundColor = [UIColor clearColor];
            _buttonPoint.textColor = [UIColor redColor];
            [_labalPointHave removeFromSuperview];
            [_buttonStartGame removeFromSuperview];
            
            [self.view addSubview:_buttonPoint];
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
    }
}
-(void)rotateViewGame{
    [labelPoint removeFromSuperview];
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
    _viewGame.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewGame];
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Untitled.png"]];
    _imageView.frame = CGRectMake(0,0, 300,300);
    _imageView.backgroundColor = [UIColor clearColor];
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
    imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"images.png"]];
    imageView1.frame = CGRectMake(-11,81, 350,350);
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
-(void)NapTien1{
    pointWin +=1500000;
    _labalPointHave.text = [NSString stringWithFormat:@"So tien:%d VND",pointWin];
    [self.view addSubview:_labalPointHave];
    [_textPoint removeFromSuperview];
    [_textPoint1 removeFromSuperview];
    [_textPoint2 removeFromSuperview];
    [_buttonPoint removeFromSuperview];
    [self.view addSubview:_buttonStartGame];
    [_theEnd show];
}
-(void)NapTien2{
    pointWin +=2500000;
    _labalPointHave.text = [NSString stringWithFormat:@"So tien:%d VND",pointWin];
    [self.view addSubview:_labalPointHave];
    [_textPoint removeFromSuperview];
    [_textPoint1 removeFromSuperview];
    [_textPoint2 removeFromSuperview];
    [_buttonPoint removeFromSuperview];
    [self.view addSubview:_buttonStartGame];
    [_theEnd show];
}
-(void)NapTien3{
    pointWin +=3500000;
    _labalPointHave.text = [NSString stringWithFormat:@"So tien:%d VND",pointWin];
    [self.view addSubview:_labalPointHave];
    [_textPoint removeFromSuperview];
    [_textPoint1 removeFromSuperview];
    [_textPoint2 removeFromSuperview];
    [_buttonPoint removeFromSuperview];
    [self.view addSubview:_buttonStartGame];
    [_theEnd show];
}
@end
