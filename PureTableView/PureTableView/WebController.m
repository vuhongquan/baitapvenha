//
//  WebController.m
//  PureTableView
//
//  Created by ios12 on 5/3/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import "WebController.h"

@interface WebController ()
{
    UIButton *buttonA;
    UIWebView *webview;
}
@end

@implementation WebController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)viewWillAppear:(BOOL)animated   
{
    [super viewWillAppear:YES];
    webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webview.delegate=self;

    buttonA = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonA.frame = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:buttonA];
    for (int i = 0; i<[_arrayWebAsia count]; i++) {
    NSString *stringURL = [NSString stringWithFormat:@"%@",[_arrayWebAsia[i] valueForKey:@"URL"]];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webview loadRequest:request];
    [self.view addSubview:webview];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
