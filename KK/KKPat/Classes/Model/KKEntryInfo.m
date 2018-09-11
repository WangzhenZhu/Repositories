//
//  KKEntryInfo.m
//  KKPat
//
//  Created by Wang on 22/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKEntryInfo.h"
#import "KKConfiguration.h"
@implementation KKEntryInfo

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
