//
//  womenBackView.m
//  KKPat
//
//  Created by Wang on 2018/8/30.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "womenBackView.h"
#import "OrganListViewController.h"

@implementation womenBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"womenBackView" owner:nil options:nil].firstObject;
    }
    return self;
}
- (UIViewController *)ViewController
{
    for (UIView *next = [self superview]; next;next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (IBAction)womenBackClickAction:(UIButton *)sender {
    OrganListViewController *OrganlistVc = [[OrganListViewController alloc] init];
    switch (sender.tag) {
        case 2054:
            OrganlistVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:12];
            break;
        case 2055:
            OrganlistVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:15];
            break;
        default:
            break;
    }
    [[self ViewController].navigationController pushViewController:OrganlistVc animated:YES];
}

@end
