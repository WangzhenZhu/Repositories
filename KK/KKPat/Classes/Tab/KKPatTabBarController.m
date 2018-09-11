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
#import "PrediagnosisViewController.h"

#import "KKConfiguration.h"

#import "SetingTimeAndPositionViewController.h"
#import "KKPatTabBar.h"
@interface KKPatTabBarController ()<UITabBarDelegate>

@property (nonatomic , strong) KKPatTabBar *kkTb;
@end

@implementation KKPatTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //利用KVO来使用自定义的tabBar;
//    self.kkTb.centerBtn.backgroundColor = [UIColor redColor];
    [self setValue:self.kkTb forKey:@"tabBar"];

    [self cleanLine];
    [self addAllChildViewController];
    
}

- (void)clickCenterBtn:(UIButton *)sender
{
    PrediagnosisViewController  *PreVc = [[PrediagnosisViewController alloc] init];
    PreVc.title = @"预诊";
    KKPNavController *nav = [[KKPNavController alloc] initWithRootViewController:PreVc];
    [self presentViewController:nav animated:YES completion:nil];
//    SetingTimeAndPositionViewController *setVc = [[SetingTimeAndPositionViewController alloc] init];
//     KKPNavController *nav = [[KKPNavController alloc] initWithRootViewController:setVc];
//    [self presentViewController:nav animated:YES completion:nil];
}
//清除Tab线 加背景
- (void)cleanLine
{
    UIImageView *bgV = [[UIImageView alloc] init];
    bgV.image = IMG(@"tab_bg");
    bgV.frame = CGRectMake(0, -41, ScreenWidth, 90);
    [self.tabBar insertSubview:bgV atIndex:0];
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];
    
    
}
- (void)addAllChildViewController
{
    KKPRealTimeViewController *realVc = [[KKPRealTimeViewController alloc] init];
    [self addChildViewController:realVc title:@"实时" imageName:@"realTime_tab_icon" selectImage:@"realTimeSelect_tab_icon"];
    
    KKPReservationViewController *resVc = [[KKPReservationViewController alloc] init];
    [self addChildViewController:resVc title:@"预约" imageName:@"reservation_tab_icon" selectImage:@"reservationSelect_tab_icon"];
    
    KKPOrdersViewController *orderVc = [[KKPOrdersViewController alloc] init];
    [self addChildViewController:orderVc title:@"订单" imageName:@"order_tab_icon" selectImage:@"orderSelect_tab_icon"];
    
    KKPMeViewController *meVc = [[KKPMeViewController alloc] init];
    [self addChildViewController:meVc title:@"我的" imageName:@"me_tab_icon" selectImage:@"meSelect_tab_icon"];

}

- (void)addChildViewController:(UIViewController *)vc  title:(NSString *)title imageName:(NSString *)imageName selectImage:(NSString *)selectImageName
{
    KKPNavController *nav = [[KKPNavController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = IMG(imageName);
    nav.tabBarItem.selectedImage = IMG(selectImageName);
    
    [self addChildViewController:nav];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"llll");
}



- (KKPatTabBar *)kkTb
{
    if (!_kkTb) {
        _kkTb = [[KKPatTabBar alloc] init];
        [_kkTb.centerBtn addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kkTb;
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
