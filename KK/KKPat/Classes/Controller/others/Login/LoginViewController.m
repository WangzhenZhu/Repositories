//
//  LoginViewController.m
//  KKMed
//
//  Created by Wang on 16/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "LoginViewController.h"
#import "KKColors.h"
#import "DisclaimerViewController.h"
#import "EntryInfoViewController.h"
#import "KKConfiguration.h"
#import <SMS_SDK/SMSSDK.h>
#import "KKPatTabBarController.h"
#import "KKLoginManager.h"

@interface LoginViewController ()<UITextFieldDelegate,KKAPIManagerParamSourceDelegate,KKAPIManagerApiCallBackDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *VerificationCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *SendCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *ReadDisclaimer;

@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@property (nonatomic, strong) KKLoginManager *LoginManager;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.LoginBtn.enabled = NO;
    [self setControlStyle];

    // Do any additional setup after loading the view from its nib.
}

- (void)setControlStyle
{
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.backgroundColor = RGBA(255, 255, 255, 0.5);
    self.phoneNumberTextField.layer.borderWidth = 1.0f;
    self.phoneNumberTextField.layer.borderColor = RGBACG(225, 225, 225, 1);
    self.phoneNumberTextField.layer.cornerRadius = _phoneNumberTextField.bounds.size.height * 0.5f;
    self.phoneNumberTextField.layer.masksToBounds = YES;
    [self.phoneNumberTextField setBorderStyle:UITextBorderStyleNone];
    //加手机号输入框左侧图标
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *phoneImage = [[UIImageView alloc] initWithImage:IMG(@"person_login_img")];
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    phoneImage.center = lv.center;
    [lv addSubview:phoneImage];
    self.phoneNumberTextField.leftView = lv;
    //设置光标位置
//    self.phoneNumberTextField.leftView  = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 15.f, 0.f)];
//    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.VerificationCodeTextField.delegate = self;
    self.VerificationCodeTextField.backgroundColor = RGBA(255, 255, 255, 0.5);
    self.VerificationCodeTextField.layer.borderWidth = 1.0f;
    self.VerificationCodeTextField.layer.borderColor = RGBACG(225, 225, 225, 1);
    self.VerificationCodeTextField.layer.cornerRadius = _VerificationCodeTextField.bounds.size.height * 0.5f;
    self.VerificationCodeTextField.layer.masksToBounds = YES;
    [self.VerificationCodeTextField setBorderStyle:UITextBorderStyleNone];
    self.VerificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *VerificationCodeImage = [[UIImageView alloc] initWithImage:IMG(@"lock_login_img")];
    UIView *VerificationCodeLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    VerificationCodeImage.center = VerificationCodeLeftView.center;
    [VerificationCodeLeftView addSubview:VerificationCodeImage];
    self.VerificationCodeTextField.leftView = VerificationCodeLeftView;
    
    self.SendCodeBtn.backgroundColor = RGBA(255, 255, 255, 0.5);
    self.SendCodeBtn.layer.cornerRadius = _SendCodeBtn.bounds.size.height * 0.5;
    self.SendCodeBtn.layer.borderWidth = 1.0f;
    self.SendCodeBtn.layer.borderColor = RGBACG(105, 180, 170, 1);
    self.SendCodeBtn.layer.masksToBounds = YES;
    [self.SendCodeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    
//    self.ReadDisclaimer.backgroundColor = RGBA(255, 255, 255, 1);
    [self.ReadDisclaimer setTitleColor:ThemeColor forState:UIControlStateNormal];
    
    [self.ReadDisclaimer addTarget:self action:@selector(goReadDisclaimer) forControlEvents:UIControlEventTouchUpInside];
//    [self.ReadDisclaimer setImage:IMG(@"readDisclamer_login_img") forState:UIControlStateNormal];
    self.ReadDisclaimer.backgroundColor = [UIColor clearColor];
   // self.ReadDisclaimer.tintColor = ThemeColor;
//    self.ReadDisclaimer.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
//    self.ReadDisclaimer.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //self.ReadStatusLab.textColor = RGB(255, 255, 255);
//
//    self.LoginBtn.layer.cornerRadius = 5.0f;
//    self.LoginBtn.layer.masksToBounds = YES;
    self.LoginBtn.layer.shadowColor = RGBACG(0, 0, 0, 0.3);
    self.LoginBtn.layer.shadowOffset = CGSizeMake(5, 10.0f);
    self.LoginBtn.layer.shadowOpacity = YES;
    [self.LoginBtn addTarget:self action:@selector(goToVerification) forControlEvents: UIControlEventTouchUpInside];
    [self.LoginBtn setEnabled:NO];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[KKUserDefaults sharedInstance] boolValueWithKey:@"IsAgreenDisclaime"]) {
        [self.LoginBtn setEnabled:YES];
       // self.LoginBtn.backgroundColor = ThemeColor;
        [self.ReadDisclaimer setTitle:@"免责声明已阅读" forState:UIControlStateNormal];
        [self.ReadDisclaimer setImage:IMG(@"read_login_img") forState:UIControlStateNormal];
        [self.LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else
    {
//        self.LoginBtn.backgroundColor = RGB(215, 215, 215);

        [self.LoginBtn setEnabled:NO];
        [self.ReadDisclaimer setTitle:@"请阅读免责声明" forState:UIControlStateNormal];
        [self.ReadDisclaimer setImage:IMG(@"readDisclamer_login_img") forState:UIControlStateNormal];
        [self.LoginBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];

    }
}
#pragma mark - event response(键盘收回)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark -- 数据加载
- (void)loadData
{
    [SVProgressHUD show];
    [self.LoginManager loadData];
}


#pragma mark - 阅读免责声明
- (void)goReadDisclaimer
{
    DisclaimerViewController *DisclamVc = [[DisclaimerViewController alloc] init];
    [self presentViewController:DisclamVc animated:YES completion:nil];
}

#pragma mark -获取验证码
- (void)getVerificationCode
{
    if (![NSString isEmpty:_phoneNumberTextField.text]) {
        if ([NSString isMobileNumber:_phoneNumberTextField.text])
        {
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumberTextField.text zone:@"86"  result:^(NSError *error) {
                if (!error)
                {
                    [self startTiming];
                    NSLog(@"请求成功");
                }
                else
                {
                [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"RequestVerificationCodeFailure", @"KKMed", nil)];
                    NSLog(@"请求失败");
                }
            }];
        }else
        {
           [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InPutMObileFailure", @"KKMed", nil)];
        }
    }else
    {
        [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InputMobile", @"KKMed", nil)];
    }
    
   
    
}

#pragma mark --KKAPIManagerParamSourceDelegate
- (NSDictionary *)paramForApi:(KKAPIBaseManager *)manager
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([manager isKindOfClass:[KKLoginManager class]]) {
        [params setObject:self.phoneNumberTextField.text forKey:@"phone"];
    }
    return params;
}
#pragma mark -KKAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(KKAPIBaseManager *)manager
{
  
    id responseData = manager.responseObject;
    NSNumber *errorCode = [responseData objectForKey:@"code"];
    if (errorCode && [errorCode integerValue] == 200) {
        if ([responseData objectForKey:@"data"]) {
            NSDictionary *dic = [[NSDictionary alloc] init];
            dic = [responseData objectForKey:@"data"];
            if ([dic objectForKey:@"token"]) {
                [[KKUserDefaults sharedInstance] saveValue:[dic objectForKey:@"token"] forKey:@"Token"];
//                NSString *tmpDir = NSTemporaryDirectory();
//                NSLog(@"tmp----%@",tmpDir);
                [SVProgressHUD dismiss];
                EntryInfoViewController *EntryInfoVc = [[EntryInfoViewController alloc] init];
                [self presentViewController:EntryInfoVc animated:YES completion:nil];
            }
        }
    } else
    {
        [SVProgressHUD showInfoWithStatus:[responseData objectForKey:@"msg"]];
    }
}
- (void)managerCallAPIDidFailed:(KKAPIBaseManager *)manager
{
     [SVProgressHUD showErrorWithStatus:manager.errorMessage];
}

#pragma mark --登录之前 判断手机号和验证码是否正确
- (void)goToVerification
{
//    NSLog(@"____%@",self.phoneNumberTextField.text);
    EntryInfoViewController *EntryInfoVc = [[EntryInfoViewController alloc] init];
    [self presentViewController:EntryInfoVc animated:YES completion:nil];
    if ([NSString isEmpty:_phoneNumberTextField.text]) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InputMobile", @"KKMed", nil)];
        return;
    }

    if (![NSString isMobileNumber:_phoneNumberTextField.text])
    {
        [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InPutMObileFailure", @"KKMed", nil)];
        return;
    }

    if ([NSString isEmpty:_VerificationCodeTextField.text]) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InputVerificationCode", @"KKMed", nil)];
        return;
    }
    if ([[KKUserDefaults sharedInstance] boolValueWithKey:@"isEntryInfo"]) {

    }else
    {
        [SMSSDK commitVerificationCode:_VerificationCodeTextField.text phoneNumber:_phoneNumberTextField.text zone:@"86" result:^(NSError *error) {

            if (!error)
            {
                // 验证码成功
                [self loadData];
            }
            else
            {
               [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InputVerificationCodeError", @"KKMed", nil)];
                // error
            }
        }];

    }

    KKPatTabBarController *KKPTabVc = [[KKPatTabBarController alloc] init];
    
    
    
}

#pragma mark --开启验证码倒计时
- (void)startTiming
{
    self.SendCodeBtn.userInteractionEnabled = NO;
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    ;
  //GCD定时器
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (time <= 0) { //倒计时结束 关闭
            dispatch_source_cancel(_timer);// 异步取消调度源
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.SendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.SendCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.SendCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)",seconds] forState:UIControlStateNormal];
            });
            time--;
        }
    });
    //GCD定时器启动，默认是关闭的
    dispatch_resume(_timer);
}

- (KKLoginManager *)LoginManager
{
    if (!_LoginManager) {
        _LoginManager = [[KKLoginManager alloc] init];
        _LoginManager.delegate = self;
        _LoginManager.paramsSource = self;
    }
    return _LoginManager;
}
@end
