//
//  Game1.m
//  GameDemoImage
//
//  Created by ios12 on 4/5/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "Game1.h"
#import "Game2.h"
@interface Game1 ()
{
    UIView * _game1;
    UIImageView *_anhnen1;
    UIImageView *_anh[8];
    UIView * _complete;
    
    NSMutableArray *_game1ImageView;
    NSArray * _game1DataImageView;
    
    UIButton * _nextRound;
    UIImageView * _anhChon1;
    UIImageView * _anhChon2;
    NSInteger  count;
    UILabel * _labalA;
    
    
    BOOL _isFrontFace;
    BOOL _isStart;
    BOOL isSelected;
}
#define khoangCach1 100
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
    [self createView1];
}
	// Do any additional setup after loading the view.

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) createView1
{
    //Tao View
    _game1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _game1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_game1];
    
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
    [UIView transitionWithView:imageView duration:1
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
                        _isFrontFace = NO;
                    }];
}
-(void)endgame{
    
    _complete = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1040)];
    _anhnen1.image = [UIImage imageNamed:@"anh2.jpg"];
    _labalA = [[UILabel alloc]initWithFrame:CGRectMake(260, 200, 400, 300)];
    _labalA.backgroundColor = [UIColor clearColor];
    _labalA.text =@"GOOD JOB";
    _labalA.textColor = [UIColor yellowColor];
    _labalA.font = [UIFont systemFontOfSize:70];
    [_complete addSubview:_anhnen1];
    [_complete addSubview:_labalA];
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
