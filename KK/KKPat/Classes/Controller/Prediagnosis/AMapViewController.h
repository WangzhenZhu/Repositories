//
//  AMapViewController.h
//  KKPat
//
//  Created by Wang on 19/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPBaseViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

typedef void(^selectEvent)(CLLocationCoordinate2D coordinate, NSString *addressName);
@interface AMapViewController : KKPBaseViewController

@property (nonatomic, copy) selectEvent BackSlect;

@end
