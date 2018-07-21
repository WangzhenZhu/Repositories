//
//  AppDelegate.m
//  KKMed
//
//  Created by Wang on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "KKPAppDelegate.h"
#import "KKPGuideViewController.h"
#import "KKConfiguration.h"
#import "LoginViewController.h"
#import "KKPatTabBarController.h"
@interface KKPAppDelegate ()

@end

@implementation KKPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置启动页停留时间
     [NSThread sleepForTimeInterval:1];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[KKUserDefaults sharedInstance] valueForKey:@"isFirst"]) {
//        LoginViewController *LoginVc = [[LoginViewController alloc] init];
//        self.window.rootViewController =  LoginVc;
        KKPatTabBarController *KKPTabVc = [[KKPatTabBarController alloc] init];
        self.window.rootViewController = KKPTabVc;
    
    }else
    {
        [[KKUserDefaults sharedInstance] setBoolValue:YES withKey:@"isFirst"];
        KKPGuideViewController *guideVc = [[KKPGuideViewController alloc] init];
        self.window.rootViewController = guideVc;
    }
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
