//
//  Circle.m
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Circle.h"

@implementation Circle
-(void) nhap:(float)bankinh{
    _bankinh = bankinh;
}
-(void) dientich{
    _dientich = _bankinh*_bankinh*3.14;
}
-(void) chuvi{
    _chuvi = _bankinh*2*3.14;
}
-(void)tinhdientich{
    [self dientich];
    NSLog(@"dien tich hinh tron la:%f",_dientich);
}
-(void)tinhchuvi{
    [self chuvi];
    NSLog(@"chu vi hinh tron la :%f",_chuvi);
}
@end
