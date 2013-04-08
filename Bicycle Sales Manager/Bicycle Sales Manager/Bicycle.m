//
//  Bicycle.m
//  Bicycle Sales Manager
//
//  Created by ios12 on 4/8/13.
//  Copyright (c) 2013 ios12. All rights reserved.
//

#import "Bicycle.h"
#import "Information.h"
@interface Bicycle ()
{
    UITableView *_tableView;
    NSArray * _arrayBicycles;
    
}
@end

@implementation Bicycle

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
    self.title = @"List Xe";
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Bicycle" ofType:@"plist"];
    _arrayBicycles = [[NSArray alloc] initWithContentsOfFile:dataPath];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //3. Assign dataSource and delegate properties of UITableView variables
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:nil];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 10; //Don't use arbitrary number here. It makes your code unmaintainable
    return [_arrayBicycles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *result = nil;
    
    static NSString *TableViewCellIdentifier = @"MyCells";
    result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    
    if (result == nil){
        result = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1
                                         reuseIdentifier:TableViewCellIdentifier];
    }
    
    NSDictionary *dic = [_arrayBicycles objectAtIndex:indexPath.row];
    
    result.textLabel.text = [NSString stringWithFormat:@"%@" ,[dic objectForKey:@"kieuxe"]];
    [result.imageView setImage:[UIImage imageNamed:[dic objectForKey:@"xe"]]];
    result.detailTextLabel.text = [NSString stringWithFormat:@"%d VND",[[dic objectForKey:@"tien"]integerValue]];
    return result;

}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Information * info = [[Information alloc]init];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    info.kieuxe = cell.textLabel.text;
    info.giatien =[cell.detailTextLabel.text integerValue];
    info.hinhanhxe = cell.imageView.image;
    [self.navigationController pushViewController:info animated:YES];
}
@end
