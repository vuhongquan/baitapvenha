//
//  Triangle.h
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Geometry.h"

@interface Triangle : Geometry
{
    float _chieucao;
    float _canhday;
    float _canh1;
    float _canh2;
    float _chuvi;
    float _dientich;
}
-(void) nhap:(float) chieucao
            :(float) canhday
            :(float) canh1
            :(float) canh2;
@end
