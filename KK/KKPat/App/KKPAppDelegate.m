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
#import "RequestPreAPIManager.h"

@interface KKPAppDelegate ()<KKAPIManagerParamSourceDelegate,KKAPIManagerApiCallBackDelegate>

@property (nonatomic, strong) RequestPreAPIManager *RequestManager;
@end

@implementation KKPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置
    [self AMapConfig];
    
    //获取预诊API病症 存在plist文件中
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.RequestManager loadData];
//    });
    //设置启动页停留时间
     [NSThread sleepForTimeInterval:1];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([[KKUserDefaults sharedInstance] valueForKey:@"isFirst"]) {
        LoginViewController *LoginVc = [[LoginViewController alloc] init];
        self.window.rootViewController =  LoginVc;
//        KKPatTabBarController *KKPTabVc = [[KKPatTabBarController alloc] init];
//        self.window.rootViewController = KKPTabVc;
    
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

//地图配置
- (void)AMapConfig
{
//发布时需要重新申请Key
    [AMapServices sharedServices].apiKey = @"3bf63e5503d4e0572c13df431c0da866";
}

#pragma mark
- (NSDictionary *)paramForApi:(KKAPIBaseManager *)manager
{
    return nil;
}
- (void)managerCallAPIDidSuccess:(KKAPIBaseManager *)manager
{
    id responseData = manager.responseObject;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"PrediagnosisList.plist"];
    NSLog(@"kkkkkk---%@",plistPath);
//    NSMutableDictionary *PrediagnosisDic = [NSMutableDictionary dictionary];
    NSMutableArray *result = [NSMutableArray array];
    NSMutableSet *bodyArr = [NSMutableSet set];
    NSMutableArray *symptomArr = [NSMutableArray array];
    NSMutableArray *symptomArrs = [NSMutableArray array];
    result = [responseData objectForKey:@"result"];
    for (int i = 0; i < result.count; i++) {
        // [bodyArr addObject:[result[i] objectForKey:@"body"]];
        NSMutableDictionary *symtomDic = [NSMutableDictionary dictionary];
        NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
        [symtomDic setValue:[result[i] valueForKey:@"symptomId"]  forKey:@"symptomId"];
        [symtomDic setValue:[result[i] valueForKey:@"symptom"]  forKey:@"symptom"];
        symptomArr[i] = symtomDic;
        
        [bodyDic setValue:[result[i] valueForKey:@"body"] forKey:@"body"];
        [bodyDic setValue:[result[i] valueForKey:@"bodyId"] forKey:@"bodyId"];
        [bodyDic setValue:symptomArrs forKey:@"symptomArr"];
        [bodyArr addObject:bodyDic];
    }
    NSArray *bodyarr2 = [bodyArr allObjects];
    for (int k = 0; k < bodyarr2.count; k++) {
        NSMutableArray *MuArr = [NSMutableArray array];
        for (int j = 0; j < result.count; j++) {
            if ([bodyarr2[k] valueForKey:@"bodyId"] == [result[j] valueForKey:@"bodyId"]) {
                [MuArr addObject:symptomArr[j]];
            }
        }
        
        [bodyarr2[k] setValue:MuArr forKey:@"symptomArr"];
    }

    [bodyarr2 writeToFile:plistPath atomically:YES];
}
- (void)managerCallAPIDidFailed:(KKAPIBaseManager *)manager
{
    
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

- (RequestPreAPIManager *)RequestManager
{
    if (!_RequestManager) {
        _RequestManager = [[RequestPreAPIManager alloc] init];
        _RequestManager.delegate = self;
        _RequestManager.paramsSource = self;
    }
    return _RequestManager;
}

@end
