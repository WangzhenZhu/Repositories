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
@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *VerificationCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *SendCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *ReadDisclaimer;

@property (weak, nonatomic) IBOutlet UILabel *ReadStatusLab;

@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *AgreenDisclaimerIcon;
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
    self.phoneNumberTextField.layer.borderColor = RGBACG(255, 255, 255, 1);
    self.phoneNumberTextField.layer.cornerRadius = 5.0f;
    self.phoneNumberTextField.layer.masksToBounds = YES;
    [self.phoneNumberTextField setBorderStyle:UITextBorderStyleNone];
    //设置光标位置
    self.phoneNumberTextField.leftView  = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 15.f, 0.f)];
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.VerificationCodeTextField.delegate = self;
    self.VerificationCodeTextField.backgroundColor = RGBA(255, 255, 255, 0.5);
    self.VerificationCodeTextField.layer.borderWidth = 1.0f;
    self.VerificationCodeTextField.layer.borderColor = RGBACG(255, 255, 255, 1);
    self.VerificationCodeTextField.layer.cornerRadius = 5.0f;
    self.VerificationCodeTextField.layer.masksToBounds = YES;
    [self.VerificationCodeTextField setBorderStyle:UITextBorderStyleNone];
    self.VerificationCodeTextField.leftView  = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 15.f, 0.f)];
    self.VerificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.SendCodeBtn.backgroundColor = RGBA(255, 255, 255, 0.5);
    self.SendCodeBtn.layer.cornerRadius = 5.0f;
    self.SendCodeBtn.layer.masksToBounds = YES;
    [self.SendCodeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.ReadDisclaimer.backgroundColor = RGBA(255, 255, 255, 1);
    self.ReadDisclaimer.layer.cornerRadius = 5.0f;
    self.ReadDisclaimer.layer.masksToBounds = YES;
    [self.ReadDisclaimer addTarget:self action:@selector(goReadDisclaimer) forControlEvents:UIControlEventTouchUpInside];
    
    self.ReadStatusLab.textColor = RGB(255, 255, 255);
    self.LoginBtn.backgroundColor = RGB(215, 215, 215);
    self.LoginBtn.layer.cornerRadius = 5.0f;
    self.LoginBtn.layer.masksToBounds = YES;
    [self.LoginBtn addTarget:self action:@selector(goToVerification) forControlEvents: UIControlEventTouchUpInside];
    [self.LoginBtn setEnabled:NO];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[KKUserDefaults sharedInstance] boolValueWithKey:@"IsAgreenDisclaime"]) {
        [self.LoginBtn setEnabled:YES];
        self.LoginBtn.backgroundColor = RGB(255, 255, 255);
        self.ReadStatusLab.hidden = NO;
        self.AgreenDisclaimerIcon.hidden = NO;
        self.ReadDisclaimer.hidden = YES;
    }else
    {
        self.ReadStatusLab.hidden = YES;
        self.AgreenDisclaimerIcon.hidden = YES;
        self.ReadDisclaimer.hidden = NO;
    }
}
#pragma mark - event response(键盘收回)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


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



#pragma mark --登录之前 判断手机号和验证码是否正确
- (void)goToVerification
{
//    if ([NSString isEmpty:_phoneNumberTextField.text]) {
//        [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InputMobile", @"KKMed", nil)];
//        return;
//    }
//
//    if (![NSString isMobileNumber:_phoneNumberTextField.text])
//    {
//        [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InPutMObileFailure", @"KKMed", nil)];
//        return;
//    }
//
//    if ([NSString isEmpty:_VerificationCodeTextField.text]) {
//        [SVProgressHUD showInfoWithStatus:NSLocalizedStringFromTable(@"InputVerificationCode", @"KKMed", nil)];
//        return;
//    }
//    if ([[KKUserDefaults sharedInstance] boolValueWithKey:@"isEntryInfo"]) {
//
//    }else
//    {
        EntryInfoViewController *EntryInfoVc = [[EntryInfoViewController alloc] init];
        [self presentViewController:EntryInfoVc animated:YES completion:nil];
//    }
    
    KKPatTabBarController *KKPTabVc = [[KKPatTabBarController alloc] init];
    
    
    
}

#pragma mark --开启验证码倒计时
- (void)startTiming
{
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
@end
