//
//  KKPatTabBar.m
//  KKPat
//
//  Created by Wang on 20/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPatTabBar.h"
#import "KKConfiguration.h"
@interface KKPatTabBar()

@property (nonatomic, strong) UIButton *centerBtn;

@end

@implementation KKPatTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置tabbaritem选中状态时的颜色
        self.tintColor = [UIColor redColor];
        [self addSubview:self.centerBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //把tabBarButton取出来(把tabBar的SubViews打印出来，)
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
    //设置中间按钮的位置居中凸出一点
    self.centerBtn.center = CGPointMake(barWidth/2, barHeight/2 - 20);
    
    //重新布局其他tabBarItem
    //平均分配其他tabbarItem 的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    //逐个布局tabBarItem,修改UITabBarButton的frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView  * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            //重新设置x坐标，如果排在中间按钮的右边需要加上中间的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else
        {
            frame.origin.x = idx * barItemWidth;
        }
        //重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    //把中间按钮带到视图最前面
    [self bringSubviewToFront:self.centerBtn];
}

#pragma mark - Actions

- (void)clickCenterBtn:(UIButton *)sender
{
    NSLog(@"点击中间");
}

#pragma mark - Cetter
- (UIButton *)centerBtn
{
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [_centerBtn setImage:IMG(@"centerIcon") forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

#pragma mark -
//重写hitTest方法，让超过tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生早tabbar里面直接返回
    if (result) {
        return result;
    }
    //这里遍历哪些超过的部分就可以了，不过这么写比较通用
    for (UIView *subview in self.subviews)
    {
        //把这个坐标从tabbar的坐标系转为subView的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        if (result) {
            return result;
        }
    }
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end