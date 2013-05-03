//
//  WebController.h
//  PureTableView
//
//  Created by ios12 on 5/3/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Object.h"
@interface WebController : UIViewController<UIWebViewDelegate>
@property (nonatomic,strong)Object *object;
@property (nonatomic,strong) NSArray*arrayWebAsia;
@property (nonatomic,strong)NSArray *arrayWebEroup;
@end
