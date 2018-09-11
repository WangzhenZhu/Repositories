//
//  womenFrontOrganView.m
//  KKPat
//
//  Created by Wang on 29/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "womenFrontOrganView.h"
#import "OrganListViewController.h"
@implementation womenFrontOrganView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"womenFrontOrganView" owner:nil options:nil].firstObject;
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

- (IBAction)womenClickAction:(UIButton *)sender {
    OrganListViewController *OrganVc = [[OrganListViewController alloc] init];
    switch (sender.tag) {
        case 2040:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:8];
            break;
        case 2041:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:3];
            break;
        case 2042:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:11];
            break;
        case 2043:
        case 2044:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            break;
        case 2045:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:10];
            break;
        case 2046:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            break;
        case 2047:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:16];
            break;
        case 2048:
        case 2049:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            break;
        case 2050:
        case 2051:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:13];
            break;
        case 2052:
        case 2053:
            OrganVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:14];
            break;
        default:
            break;
    }
    [[self ViewController].navigationController pushViewController:OrganVc animated:YES];
}

@end
