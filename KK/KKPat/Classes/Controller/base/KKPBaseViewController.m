//
//  KKPBaseViewController.m
//  KKPat
//
//  Created by Wang on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "KKPBaseViewController.h"
#import "KKConfiguration.h"
@interface KKPBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation KKPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
}

#pragma mark -- 设置导航栏返回的按钮图片
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    
    if (root != viewController) {
        UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:IMG(@"back1_btn") style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
        viewController.navigationItem.leftBarButtonItem = itemleft;
    }
}

- (void)popAction:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
