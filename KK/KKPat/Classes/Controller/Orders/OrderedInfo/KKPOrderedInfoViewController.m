//
//  KKPOrderedInfoViewController.m
//  KKPat
//
//  Created by Wang on 31/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPOrderedInfoViewController.h"
#import "orderedInfoView.h"
#import "KKConfiguration.h"
@interface KKPOrderedInfoViewController ()

@property (nonatomic, strong) UIScrollView *orderedInfoScrollView;

@property (nonatomic, strong) orderedInfoView *orderInfoView;
@end

@implementation KKPOrderedInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.orderedInfoScrollView addSubview:self.orderInfoView];
    [self.view addSubview:self.orderedInfoScrollView];
    
    // Do any additional setup after loading the view from its nib.
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


- (orderedInfoView *)orderInfoView
{
    if (!_orderInfoView) {
        _orderInfoView = [[orderedInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    }
    return _orderInfoView;
}

- (UIScrollView *)orderedInfoScrollView
{
    if (!_orderedInfoScrollView) {
        _orderedInfoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _orderInfoView.backgroundColor = [UIColor whiteColor];
        _orderedInfoScrollView.showsVerticalScrollIndicator = NO;
        _orderedInfoScrollView.contentSize = CGSizeMake(ScreenWidth, 1500);
    }
    return _orderedInfoScrollView;
}
@end
