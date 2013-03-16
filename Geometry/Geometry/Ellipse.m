//
//  Ellipse.m
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Ellipse.h"

@implementation Ellipse
-(void) nhap:(float)trucnho
            :(float)truclon{
    _truclon = truclon;
    _trucnho = trucnho;
}
-(void) dientinh{
    _dientich = _truclon*_trucnho*3.14;
}
-(void) chuvi{
    _chuvi = 2*3.14*sqrt((_truclon*_truclon+_trucnho*_trucnho)/2);
}
-(void) tinhdientich{
    [self dientinh];
    NSLog(@"dien tich hinh ellip la : %f",_dientich);
}
-(void) tinhchuvi{
    [self chuvi];
    NSLog(@"chu vi hinh ellip la : %f",_chuvi);
}
@end
