//
//  ViewController.m
//  PureTableView
//
//  Created by techmaster on 5/2/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import "ViewController.h"
#import "WebController.h"
#define COUNTRY_KEY @"countries"
#define HEADER_KEY @"header"
@interface ViewController ()
{
 
    NSArray *_countryAsia;
    NSArray *_countryEurope;
    
}
@end

@implementation ViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        _data = [NSArray arrayWithContentsOfFile:dataPath];        
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _countryAsia = [NSArray arrayWithArray:[_data[0] valueForKey:COUNTRY_KEY]];
    _countryEurope = [NSArray arrayWithArray:[_data[1] valueForKey:COUNTRY_KEY]];
	// Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return [_data count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_countryAsia count];
    } else {
        return [_countryEurope count];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_data[section] valueForKey:HEADER_KEY];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"UniqueID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSArray *countries;
    if (indexPath.section == 0) {
        countries = [NSArray arrayWithArray:_countryAsia];
    } else {
        countries = [NSArray arrayWithArray:_countryEurope];
    }
    
    cell.textLabel.text = [countries[indexPath.row] valueForKey:@"ten"];
    cell.detailTextLabel.text = [countries[indexPath.row] valueForKey:@"songuoi"];
    cell.imageView.image = [UIImage imageNamed: [countries[indexPath.row] valueForKey:@"anh"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebController *web = [[WebController alloc]initWithNibName:@"WebController" bundle:nil];
    web.arrayWebAsia = _countryAsia;
    web.modalPresentationStyle = UIModalPresentationFormSheet;
    web.modalTransitionStyle =UIModalTransitionStyleCrossDissolve;
    [self presentViewController:web animated:YES completion:^{
    }];
}
- (IBAction)segmentValueChanged:(id)sender {
    if (_segmentControll.selectedSegmentIndex == 0) {
        NSSortDescriptor *des = [[NSSortDescriptor alloc] initWithKey:@"ten" ascending:YES];
        _countryAsia = [_countryAsia sortedArrayUsingDescriptors:[NSArray arrayWithObject:des]];
        _countryEurope = [_countryEurope sortedArrayUsingDescriptors:[NSArray arrayWithObject:des]];
    } else {
        NSSortDescriptor *des = [[NSSortDescriptor alloc] initWithKey:@"songuoi" ascending:YES];
        _countryAsia = [_countryAsia sortedArrayUsingDescriptors:[NSArray arrayWithObject:des]];
        _countryEurope = [_countryEurope sortedArrayUsingDescriptors:[NSArray arrayWithObject:des]];
    }
    [_tableView reloadData];
}
@end
