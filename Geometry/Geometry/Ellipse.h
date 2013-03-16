//
//  Ellipse.h
//  Geometry
//
//  Created by iOS12 on 3/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Geometry.h"

@interface Ellipse : Geometry
{
    float _trucnho;
    float _truclon;
    float _dientich;
    float _chuvi;
}
-(void) nhap: (float) trucnho
            : (float) truclon;

@end
