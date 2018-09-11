//
//  chooseOrganView.m
//  KKPat
//
//  Created by Wang on 28/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "chooseOrganView.h"
#import "OrganListViewController.h"
@implementation chooseOrganView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"chooseOrganView" owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (UIViewController *)viewController {
    for (UIView *next = [self superview];next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (IBAction)organClickAction:(UIButton *)sender {
    OrganListViewController *OrganListVc = [[OrganListViewController alloc] init];
    switch (sender.tag) {
        case 2020:
            OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:8];
            break;
        case 2021:
             OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:3];
            break;
        case 2022:
            OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:10];
            break;
        case 2023:
            OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:11];
            break;
        case 2024:
             OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            break;
        case 2025:
        case 2026:
            OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            break;
        case 2027:
        case 2028:
            OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            break;
        case 2029:
             OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:16];
            break;
        case 2030:
        case 2031:
            OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:13];
            break;
        case 2032:
        case 2033:
            OrganListVc.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:14];
        default:
            break;
    }
    [[self viewController].navigationController pushViewController:OrganListVc animated:YES];
    
}


@end
