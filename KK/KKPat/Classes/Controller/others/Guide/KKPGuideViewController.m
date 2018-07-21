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
@interface KKPGuideViewController ()
@property (weak, nonatomic) IBOutlet UIButton *AppIntroductionBtn;

@end

@implementation KKPGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self setIntroductionBtn];
    // Do any additional setup after loading the view from its nib.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
