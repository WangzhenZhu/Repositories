//
//  doctorInfoView.m
//  KKPat
//
//  Created by Wang on 28/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "doctorInfoView.h"

@implementation doctorInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"doctorInfoView" owner:nil options:nil] firstObject];
        self.frame = frame;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
//    self.frame = CGRectMake(0, 0, 200, 20);
}
@end
