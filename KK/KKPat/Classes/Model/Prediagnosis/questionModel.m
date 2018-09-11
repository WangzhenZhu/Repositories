//
//  questionModel.m
//  KKPat
//
//  Created by Wang on 2018/9/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "questionModel.h"
#import "KKConfiguration.h"

@implementation questionModel


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        return [self yy_modelInitWithCoder:aDecoder];
    }
    return self;
}
@end
