//
//  Square.m
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Square.h"

@implementation Square
-(void) nhap:(float)canh{
    _canh = canh;
}
-(void)dientich{
    _dientich = _canh*_canh;
}
-(void)chuvi{
    _chuvi = _canh*4;
}
-(void)tinhdientich{
    [self dientich];
    NSLog(@"dien tich hinh vuong la : %f",_dientich);
}
-(void)tinhchuvi{
    [self chuvi];
    NSLog(@"chu vi hinh vuong la : %f",_chuvi);
}
@end
