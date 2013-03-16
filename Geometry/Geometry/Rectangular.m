//
//  Rectangular.m
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Rectangular.h"

@implementation Rectangular
-(void) nhap:(float) canhlon
            :(float) canhbe{
    _canhlon = canhlon;
    _canhbe = canhbe;
    
}
-(void)chuvi{
    _chuvi = (_canhbe+_canhlon)*2;
}
-(void)dientich{
    _dientich = _canhbe * _canhlon;
}
-(void)tinhchuvi{
    [self chuvi];
    NSLog(@"chu vi hinh chu nhat la :%f",_chuvi);
}
-(void)tinhdientich{
    [self dientich];
    NSLog(@"dien tich hinh chu nhat la :%f",_dientich);
}
@end
