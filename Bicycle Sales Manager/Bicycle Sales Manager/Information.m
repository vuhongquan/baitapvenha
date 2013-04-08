//
//  Information.m
//  Bicycle Sales Manager
//
//  Created by ios12 on 4/8/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "Information.h"

@interface Information ()
{
    UITextField *_textfiedlA;
    UITextField *_textfiedlB;
    UIImageView * _image;
    UILabel *  _labelA;
    UILabel *  _labelB;
    UIButton * _datmuahang;
}
@end

@implementation Information

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
    self.view.backgroundColor =[UIColor whiteColor];
    [super viewDidLoad];
    _textfiedlA= [[UITextField alloc]initWithFrame:CGRectMake(200,800,400, 30)];
    [_textfiedlA setBorderStyle:UITextBorderStyleRoundedRect];
    _textfiedlA.text = [NSString stringWithFormat:@"%d VND",self.giatien];
    [self.view addSubview:_textfiedlA];
    _textfiedlB= [[UITextField alloc]initWithFrame:CGRectMake(200,700,400, 30)];
    [_textfiedlB setBorderStyle:UITextBorderStyleRoundedRect];
    _textfiedlB.text =self.kieuxe;
    [self.view addSubview:_textfiedlB];
    _image = [[UIImageView alloc]initWithImage:self.hinhanhxe];
    _image.frame = CGRectMake(200, 30, 400, 600);
    _image.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_image];
    _labelA = [[UILabel alloc]initWithFrame:CGRectMake(30, 690, 120, 40)];
    _labelA.text = @"The Loai Xe:";
    _labelB = [[UILabel alloc]initWithFrame:CGRectMake(30, 790, 120, 40)];
    _labelB.text=@"Gia tien: ";
    [self.view addSubview:_labelB];
    [self.view addSubview:_labelA];
    [self.view addSubview:_textfiedlA];
    [self.view addSubview:_textfiedlB];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
