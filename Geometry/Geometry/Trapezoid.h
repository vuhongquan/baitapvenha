//
//  Trapezoid.h
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Geometry.h"

@interface Trapezoid : Geometry
{
    float _canhdaydai;
    float _chieucao;
    float _canhdayngan;
    float _chuvi;
    float _dientich;
    float _canhben1;
    float _canhben2;
}
-(void) nhap :(float)canhdaydai
             :(float)chieucao
             :(float)canhdayngan
             :(float)canhben1
             :(float)canhben2;
@end
