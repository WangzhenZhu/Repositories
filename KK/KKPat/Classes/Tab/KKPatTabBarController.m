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

#import "KKPatTabBar.h"
@interface KKPatTabBarController ()

@property (nonatomic , strong) KKPatTabBar *kkTb;
@end

@implementation KKPatTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //利用KVO来使用自定义的tabBar;
    [self setValue:[[KKPatTabBar alloc] init] forKey:@"tabBar"];

//    [self.tabBar setBackgroundImage:img];

//    [self.tabBar setClipsToBounds:YES];
//    [UITabBar appearance].translucent = NO;
//    TabBarBgView *TBview = [[TabBarBgView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
//    [self.tabBar insertSubview:TBview atIndex:0];



    [self.tabBar setBackgroundImage:IMG(@"tab_bg")];
    [self addAllChildViewController];
    
    // Do any additional setup after loading the view.
}

//- (void)viewWillLayoutSubviews
//{
//    CGRect tabFrame = self.tabBar.frame;
//    tabFrame.size.height = 90;
//    tabFrame.origin.y = self.view.frame.size.height - 90;
//    self.tabBar.frame = tabFrame;
//}
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
