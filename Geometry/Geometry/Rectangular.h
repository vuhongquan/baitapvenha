//
//  Rectangular.h
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Geometry.h"

@interface Rectangular : Geometry
{
    float _canhlon;
    float _canhbe;
    float _chuvi;
    float _dientich;
}
-(void) nhap :(float)_canhlon
             :(float)_canhbe;
@end
