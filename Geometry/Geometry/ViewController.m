//
//  ViewController.m
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "ViewController.h"
#import "Ellipse.h"
#import "Circle.h"
#import "Square.h"
#import "Rectangular.h"
#import "Triangle.h"
#import "Trapezoid.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Dientich:(id)sender {
    Ellipse *ellipse = [Ellipse new];
    Circle *circle = [Circle new];
    Square *square = [Square new];
    Rectangular *ractangular = [Rectangular new];
    Triangle    *triangle =[Triangle new];
    Trapezoid *trapezoid =[Trapezoid new];
    [ellipse nhap:4.5 :6.2];
    [circle nhap:7.1];
    [square nhap:5.5];
    [ractangular nhap:5.6 :7.8];
    [triangle nhap:5.3 :6.2 :14.2 :22.4];
    [trapezoid nhap:4.6 :6.4 :7.8 :6.7 :5.4];
    NSArray * geometrys = @[ellipse,circle,square,ractangular,triangle,trapezoid];
    for (Geometry * gemetry in geometrys) {
        [gemetry tinhdientich];
    }
}
- (IBAction)tinhchuvi:(id)sender {
    Ellipse *ellipse = [Ellipse new];
    Circle *circle = [Circle new];
    Square *square = [Square new];
    Rectangular *ractangular = [Rectangular new];
    Triangle    *triangle =[Triangle new];
    Trapezoid *trapezoid =[Trapezoid new];
    [ellipse nhap:4.5 :6.2];
    [circle nhap:7.1];
    [square nhap:5.5];
    [ractangular nhap:5.6 :7.8];
    [triangle nhap:5.3 :6.2 :14.2 :22.4];
    [trapezoid nhap:4.6 :6.4 :7.8 :6.7 :5.4];
    NSArray * geometrys = @[ellipse,circle,square,ractangular,triangle,trapezoid];
    for (Geometry * gemetry in geometrys) {
        [gemetry tinhchuvi];
    }
}


@end
