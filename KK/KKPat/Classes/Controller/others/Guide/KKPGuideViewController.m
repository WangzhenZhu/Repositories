//
//  KKPGuideViewController.m
//  KKMed
//
//  Created by Wang on 16/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPGuideViewController.h"
#import "KKColors.h"
#import "LoginViewController.h"
#import "RequestPreAPIManager.h"

@interface KKPGuideViewController ()<KKAPIManagerParamSourceDelegate, KKAPIManagerApiCallBackDelegate>
@property (weak, nonatomic) IBOutlet UIButton *AppIntroductionBtn;

@property (nonatomic, strong) RequestPreAPIManager *RequestManager;
@end

@implementation KKPGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.RequestManager loadData];
  //  [self setIntroductionBtn];
    // Do any additional setup after loading the view from its nib.
}

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
    NSMutableDictionary *PrediagnosisDic = [NSMutableDictionary dictionary];
    PrediagnosisDic = responseData;
    //    NSString *status = [responseData valueForKey:@"status"];
    //    if ([status isEqualToString:@"OK"]) {
    //        NSArray *tmpArr = [responseData valueForKey:@"result"];
    //        for (int i = 0; i < tmpArr.count; i++) {
    //
    //        }
    //    }
    
    [PrediagnosisDic writeToFile:plistPath atomically:YES];
}

- (void)managerCallAPIDidFailed:(KKAPIBaseManager *)manager
{
    
}

- (void)setAppIntroductionBtn:(UIButton *)AppIntroductionBtn
{
    //btn背景颜色
    AppIntroductionBtn.backgroundColor = RGBA(255, 255, 255, 0.5);
    //圆角
    AppIntroductionBtn.layer.cornerRadius = 10.0f;
    AppIntroductionBtn.layer.masksToBounds = YES;
    
    //btn点击事件
    [AppIntroductionBtn addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)goToLogin
{
    LoginViewController *LoginVc = [[LoginViewController alloc] init];
    [self presentViewController:LoginVc animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
