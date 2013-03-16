//
//  Triangle.m
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Triangle.h"

@implementation Triangle
-(void) nhap:(float)chieucao :(float)canhday :(float)canh1 :(float)canh2{
    

    _canh1 = canh1;
    _canh2 = canh2;
    _canhday = canhday;
    _chieucao = chieucao;
    

}
-(void)dientich{
    _dientich = _chieucao * _canhday;
}
-(void) chuvi{
    _chuvi = _canh1 + _canh2 + _canhday;
}
-(void)tinhchuvi{
    [self chuvi];
    NSLog(@"chu vi hinh tam giac la :%f",_chuvi);
}
-(void)tinhdientich{
    [self dientich];
    NSLog(@"dien tich hinh tam giac la :%f",_dientich);
}
@end
