//
//  Trapezoid.m
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Trapezoid.h"

@implementation Trapezoid
-(void) nhap:(float)canhdaydai
            :(float)chieucao
            :(float)canhdayngan
            :(float)canhben1
            :(float)canhben2
{
    _canhdaydai = canhdaydai;
    _chieucao = chieucao;
    _canhdayngan = canhdayngan;
    _canhben1 = canhben1;
    _canhben2 = canhben2;
}
-(void) dientich{
    _dientich = ((_canhdaydai + _canhdayngan)/2*(_chieucao));
}
-(void) chuvi{
    _chuvi = _canhdayngan+_canhdaydai+_canhben1+_canhben2;
}
-(void) tinhdientich{
    [self dientich];
    NSLog(@"dien tich hinh thang la : %f",_dientich);
}
-(void) tinhchuvi{
    [self chuvi];
    NSLog(@"chu vi hinh thang la : %f",_chuvi);
}
@end
