//
//  KKPatTabBarController.m
//  KKPat
//
//  Created by Wang on 19/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPatTabBarController.h"
#import "KKPatTabBar.h"
#import "KKPNavController.h"

#import "KKPRealTimeViewController.h"
#import "KKPReservationViewController.h"
#import "KKPOrdersViewController.h"
#import "KKPMeViewController.h"

#import "KKConfiguration.h"
@interface KKPatTabBarController ()

@end

@implementation KKPatTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //利用KVO来使用自定义的tabBar;
    [self setValue:[[KKPatTabBar alloc] init] forKey:@"tabBar"];
    [self addAllChildViewController];
    // Do any additional setup after loading the view.
}

- (void)addAllChildViewController
{
    KKPRealTimeViewController *realVc = [[KKPRealTimeViewController alloc] init];
    [self addChildViewController:realVc title:@"实时" imageName:@"tabBar_home"];
    
    KKPReservationViewController *resVc = [[KKPReservationViewController alloc] init];
    [self addChildViewController:resVc title:@"预约" imageName:@"tabBar_activity"];
    
    KKPOrdersViewController *orderVc = [[KKPOrdersViewController alloc] init];
    [self addChildViewController:orderVc title:@"订单" imageName:@"tabBar_find"];
    
    KKPMeViewController *meVc = [[KKPMeViewController alloc] init];
    [self addChildViewController:meVc title:@"我的" imageName:@"tabBar_mine"];

}

- (void)addChildViewController:(UIViewController *)vc  title:(NSString *)title imageName:(NSString *)imageName
{
    KKPNavController *nav = [[KKPNavController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = IMG(imageName);
    
    [self addChildViewController:nav];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
