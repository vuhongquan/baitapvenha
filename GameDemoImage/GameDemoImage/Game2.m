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
    UIView * _game2;
    UIView * _complete;
    UIImageView * _anhnen2;
    UIImageView * _anh1[12];
    UIButton * _nextRound;
    UIImageView * _anhChon1;
    UIImageView * _anhChon2;
    NSInteger  count;
    UILabel * _labalA;
    
    NSMutableArray *_game2ImageView;
    NSArray * _game2DataImageView;
    
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
    [super viewDidLoad];
    [self createView2];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createView2{
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
    _game2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_game2];
    
    
    UITapGestureRecognizer * Tap[12];
    for (int k = 0; k < 12; k++) {
        _anh1[k] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hinhcard.jpeg"]];
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

- (void)NextLevel:(id)sender {
    
    _isStart = !_isStart;
    if (_isStart) {
        _game2.hidden = NO;
        [_nextRound removeFromSuperview];
        
    } else {
        _game2.hidden = YES;
        [_nextRound setTitle:@"Next Round" forState:UIControlStateNormal];
    }
    
}
-(void) flip1: (UITapGestureRecognizer *) gesture
{
    
    UIImageView *imageView1 = (UIImageView *)gesture.view;
    [UIView transitionWithView:imageView1 duration:1
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
                                count -=2;
                                if (count == 0) {
                                    [self endgame1];
                                }
                            } else {
                                NSLog(@"Sai");
                                [UIView transitionWithView:_anhChon1 duration:1
                                                   options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                                       _anhChon1.image = [UIImage imageNamed:@"hinhcard.jpeg"];
                                                   }
                                                completion:^(BOOL finished){}];
                                
                                [UIView transitionWithView:_anhChon2 duration:1
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
-(void)endgame1{
    
    _complete = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen2.image = [UIImage imageNamed:@"anh5.jpg"];
    _labalA= [[UILabel alloc]initWithFrame:CGRectMake(260, 200, 400, 300)];
    _labalA.backgroundColor = [UIColor clearColor];
    _labalA.text =@"GOOD JOB";
    _labalA.textColor = [UIColor yellowColor];
    _labalA.font = [UIFont systemFontOfSize:70];
    [_complete addSubview:_anhnen2];
    [_complete addSubview:_labalA];
    [_game2 addSubview:_complete];
    
    _nextRound = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _nextRound.frame = CGRectMake(325,500, 150, 50);
    [_nextRound addTarget:self action:@selector(createView2) forControlEvents:UIControlEventTouchUpInside];
    [_nextRound setTitle:@"Next Level" forState:UIControlStateNormal];
    [_complete addSubview:_nextRound];
    
}
-(void)GameView3{
    Game3 *game3 = [[Game3 alloc]init];
    [self.navigationController pushViewController:game3 animated:YES];
}
@end
