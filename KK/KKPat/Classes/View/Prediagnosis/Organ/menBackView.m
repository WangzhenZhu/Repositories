//
//  menBackView.m
//  KKPat
//
//  Created by Wang on 2018/8/30.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "menBackView.h"
#import "OrganListViewController.h"
@implementation menBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"menBackView" owner:nil options:nil].firstObject;
    }
    return self;
}

- (UIViewController *)ViewController
{
    for (UIView *next = [self superview]; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (IBAction)menBackAction:(UIButton *)sender {
    OrganListViewController *OrganVc = [[OrganListViewController alloc] init];
    switch (sender.tag) {
        case 2034:
        case 2035:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:12];
            break;
        case 2036:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:15];
            break;
        default:
            break;
    }
    [[self ViewController].navigationController pushViewController:OrganVc animated:YES];
}

@end
