//
//  TabBarBgView.m
//  KKPat
//
//  Created by Wang on 24/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "TabBarBgView.h"

@implementation TabBarBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float x = rect.origin.x;
    float y = rect.origin.y;
    float w = rect.size.width;
    float h = rect.size.height;
    //画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画笔的颜色
    CGContextSetRGBStrokeColor(context, 76/255.0, 182/255.0, 170/255.0, 1);
    //线宽
    CGContextSetLineWidth(context, 1.0);
    //填充颜色
    UIColor *fullColor = [UIColor colorWithRed:76/255.0 green:182/255.0 blue:170/255.0 alpha:1];
    CGContextSetFillColorWithColor(context, fullColor.CGColor);
    //绘制路径
    CGContextMoveToPoint(context, x, y+h*0.5);
    CGContextAddLineToPoint(context, x,y+h);
    CGContextAddLineToPoint(context,x+w, y+h);
    CGContextAddLineToPoint(context, x+w,y+h*0.5);
    CGContextAddLineToPoint(context,x+w*0.5, y);
    CGContextAddLineToPoint(context,x , y+h*0.5);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
