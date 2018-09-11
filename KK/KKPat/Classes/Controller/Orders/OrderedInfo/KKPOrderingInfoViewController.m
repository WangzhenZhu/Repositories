//
//  KKPOrderingInfoViewController.m
//  KKPat
//
//  Created by Wang on 10/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPOrderingInfoViewController.h"
#import "KKConfiguration.h"
#import "orderingInfo.h"
@interface KKPOrderingInfoViewController ()

@property (nonatomic, strong) orderingInfo *orderingInfoView;
@end

@implementation KKPOrderingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.orderingInfoView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setNavStyle];
}
- (void)setNavStyle
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = ThemeColor;
    //    self.navigationController.navigationBar.translucent = NO;
    [self.navigationItem setHidesBackButton:NO];
}


- (orderingInfo *)orderingInfoView
{
    if (!_orderingInfoView) {
        _orderingInfoView = [[orderingInfo alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _orderingInfoView;
}
@end
