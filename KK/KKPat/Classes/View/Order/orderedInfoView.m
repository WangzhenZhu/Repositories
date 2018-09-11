//
//  orderedInfoView.m
//  KKPat
//
//  Created by Wang on 31/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "orderedInfoView.h"

@interface orderedInfoView()


@end

@implementation orderedInfoView


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"orderedInfoView" owner:nil options:nil] firstObject];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
