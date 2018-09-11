//
//  realDoctorModel.m
//  KKPat
//
//  Created by Wang on 24/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "realDoctorModel.h"
#import "KKConfiguration.h"

@implementation realDoctorModel 

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        return [self yy_modelInitWithCoder:coder];
    }
    return self;
}

@end
