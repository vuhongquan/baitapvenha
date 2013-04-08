//
//  ViewController.m
//  Bicycle Sales Manager
//
//  Created by ios12 on 4/7/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "ViewController.h"
#import "Bicycle.h"
#define NUMBER_DISHES 2
#define khoangCach 30
#define chieuRong 40
#define chieuDai 40
@interface ViewController ()
{
    UIButton *_buttonSelectBicyle;
    UIButton *_buttonSelectMoneyOfBicycle;
    UITextField * _textFieldA;
    UITextField * _textFieldB;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    self.title = @"QuanLyBanHang";
   _textFieldA= [[UITextField alloc]initWithFrame:CGRectMake(150,40, 150,30)];
    [_textFieldA setBorderStyle:UITextBorderStyleRoundedRect];

    [self.view addSubview:_textFieldA];
    _textFieldB= [[UITextField alloc]initWithFrame:CGRectMake(150,150,150,30)];
    [_textFieldB setBorderStyle:UITextBorderStyleRoundedRect];
   
    [self.view addSubview:_textFieldB];
    
    _buttonSelectBicyle = [UIButton new];
    _buttonSelectBicyle.frame = CGRectMake(10,0, 100,130);
    _buttonSelectBicyle.backgroundColor = [UIColor clearColor];
     [_buttonSelectBicyle addTarget:self action:@selector(createView) forControlEvents:UIControlEventTouchUpInside];
    [_buttonSelectBicyle setImage:[UIImage imageNamed:@"mauxe.png"] forState:UIControlStateNormal];
    [self.view addSubview:_buttonSelectBicyle];
    _buttonSelectMoneyOfBicycle = [UIButton new];
    _buttonSelectMoneyOfBicycle.frame =CGRectMake(10,100,100,130);
    [_buttonSelectMoneyOfBicycle setImage:[UIImage imageNamed:@"Money.png"] forState:UIControlStateNormal];
    //[_buttonSelectBicyle addTarget:self action:@selector(gotoTableView) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_buttonSelectMoneyOfBicycle];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:nil];
	}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView {


    if ([_textFieldA.text isEqualToString: [NSString stringWithFormat:@"Xe"]]&&[_textFieldB.text isEqualToString:[NSString stringWithFormat:@"2.7"]]){
        Bicycle * bicycle = [[Bicycle alloc]initWithNibName:@"Bicycle" bundle:nil];
        [self.navigationController pushViewController:bicycle animated:YES];
    }
    if ([_textFieldA.text isEqualToString:[NSString stringWithFormat:@"Xe the thao"]]&&[_textFieldA.text isEqualToString:[NSString stringWithFormat:@"3.000.000"]]) {
    }
}

@end
